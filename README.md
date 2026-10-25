# Little Days

A gentle baby and pregnancy tracker that installs on a phone's home screen. Each phone keeps its own copy of everything. Households can optionally share one log between phones; entries are encrypted on the phone before they're sent, so nobody else (including whoever runs this site) can read them. Pregnancy entries never leave the phone.

## Put it online with GitHub Pages (about 10 minutes, free)

1. Sign in at github.com (or create a free account).
2. Click **+** at the top right, then **New repository**. Name it `little-days`, leave it **Public**, and click **Create repository**.
3. Click **uploading an existing file**. Drag in all the files from this folder (not the folder itself) and click **Commit changes**.
4. Go to **Settings → Pages**. Under **Branch**, choose **main** and **/ (root)**, then click **Save**.
5. Wait a minute or two and refresh. The page shows the address, like `https://YOUR-USERNAME.github.io/little-days/`.

## Turn on sharing between phones (about 15 minutes, free)

Sharing needs a small free database at Supabase. Skip this section to keep every phone separate.

1. Go to **supabase.com**, click **Start your project**, and sign up (signing in with GitHub is easiest).
2. Click **New project**. Pick any name (like `little-days`), make up a database password and save it somewhere safe, choose the region closest to you (for New York, **East US**), and click **Create new project**. Wait a minute or two while it sets up.
3. In the left menu, open **SQL Editor**, then **New query**. Open `supabase-setup.sql` from this folder in a text editor (Notepad is fine), copy everything, paste it into the query box, and click **Run**. It should say "Success. No rows returned."
4. Open **Project Settings** (gear icon) → **API** (it may be called **Data API** or **API Keys**). Copy two things:
   - the **Project URL**, like `https://abcdefghijklmnop.supabase.co`
   - the **anon public** key (starts with `eyJ`) or the **publishable** key (starts with `sb_publishable_`). Never use the **service_role** or **secret** key.
5. On GitHub, open your `little-days` repository, click **config.js**, then the **pencil icon** to edit. Paste the URL and key between the quotes, then click **Commit changes**.
6. Wait a minute. On each phone, close the app completely and open it again (sometimes twice) to pick up the change.

The key in `config.js` is meant to be public: it only lets phones use the two locked-down functions the setup script created, and every entry is encrypted before it's sent.

## Install it on a phone

1. Open the address in **Safari**.
2. Tap **Share** (on newer iOS it may be under the **⋯** menu first).
3. Tap **Add to Home Screen**, then **Add**.

On Android, open the address in Chrome and tap **Install app** or **Add to Home screen** in the menu.

## Share a log between two phones

1. Install the app on both phones first, and open it from the home screen icon. (Safari and the home-screen app keep separate data on iPhone.)
2. On the first phone: **More → Settings → Share with a partner → Start sharing**. Copy the household code.
3. On the second phone: **More → Settings → Join with a code**, enter the code, and tap **Join**.

Entries from both phones merge, and new ones show up on the other phone within about 15 seconds while the app is open. A grandparent or sitter can join with the same code. Anyone with the code can see and add to the log, so share it only with people you trust.

If every phone and the code are lost, the shared data can't be recovered, because nobody else can decrypt it. Use **Settings → Backup** now and then.

## Updating the app

Upload the new files with **Add file → Upload files** (same names replace the old ones) and click **Commit changes**. Bump the version in `sw.js` (`little-days-v2` → `little-days-v3`, and so on) so phones pick up the change. Don't overwrite your filled-in `config.js` unless you mean to.
