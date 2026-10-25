-- Little Days: household sharing.
-- Paste all of this into Supabase → SQL Editor → New query, then click Run. Run it once.
--
-- What it stores: one row per log entry, already encrypted on the phone.
-- The household id is a hash of the household code, so the database never sees the code itself.
-- Phones can only reach the data through the two functions below, and only for a household they know.

create table if not exists public.entries (
  household  text        not null check (length(household) = 32),
  id         text        not null check (length(id) <= 200),
  iv         text        check (length(iv) <= 64),
  data       text        check (length(data) <= 300000),
  deleted    boolean     not null default false,
  updated_at timestamptz not null default clock_timestamp(),
  primary key (household, id)
);

create index if not exists entries_household_updated on public.entries (household, updated_at);

-- Stamp every insert and update with the server's clock.
create or replace function public.ld_touch() returns trigger
language plpgsql as $$
begin
  new.updated_at := clock_timestamp();
  return new;
end $$;

drop trigger if exists ld_touch on public.entries;
create trigger ld_touch before insert or update on public.entries
for each row execute function public.ld_touch();

-- No direct access to the table from the app; only the functions below.
alter table public.entries enable row level security;
revoke all on public.entries from anon, authenticated;

-- Save a batch of encrypted entries for one household.
create or replace function public.ld_push(hh text, rows jsonb) returns void
language plpgsql security definer set search_path = public as $$
begin
  if hh is null or length(hh) <> 32 then raise exception 'bad household'; end if;
  if jsonb_typeof(rows) <> 'array' or jsonb_array_length(rows) > 200 then raise exception 'bad batch'; end if;
  insert into public.entries as e (household, id, iv, data, deleted)
  select hh, r->>'id', r->>'iv', r->>'data', coalesce((r->>'deleted')::boolean, false)
  from jsonb_array_elements(rows) as r
  on conflict (household, id) do update
    set iv = excluded.iv, data = excluded.data, deleted = excluded.deleted;
end $$;

-- Read a household's entries changed since a point in time, oldest first.
create or replace function public.ld_pull(hh text, since timestamptz)
returns table (id text, iv text, data text, deleted boolean, updated_at timestamptz)
language sql stable security definer set search_path = public as $$
  select e.id, e.iv, e.data, e.deleted, e.updated_at
  from public.entries e
  where e.household = hh and e.updated_at >= since
  order by e.updated_at
  limit 500;
$$;

revoke all on function public.ld_push(text, jsonb) from public;
revoke all on function public.ld_pull(text, timestamptz) from public;
grant execute on function public.ld_push(text, jsonb) to anon, authenticated;
grant execute on function public.ld_pull(text, timestamptz) to anon, authenticated;
