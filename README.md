# Little Days

A gentle baby and pregnancy tracker that installs on a phone's home screen. Everything a person logs stays on their own phone. Nothing is sent anywhere.

## Put it online with GitHub Pages (about 10 minutes, free)

1. Sign in at github.com (or create a free account).
2. Click **+** at the top right, then **New repository**. Name it `little-days`, leave it **Public**, and click **Create repository**.
3. On the new repository page, click **uploading an existing file**. Drag in all the files from this folder (not the folder itself): `index.html`, `manifest.webmanifest`, `sw.js`, `apple-touch-icon.png`, `icon-192.png`, `icon-512.png`, `icon-maskable-512.png`, and this README. Click **Commit changes**.
4. Go to **Settings**, then **Pages** in the left menu. Under **Branch**, choose **main** and **/ (root)**, then click **Save**.
5. Wait a minute or two and refresh. The page shows the address, which looks like `https://YOUR-USERNAME.github.io/little-days/`.

## Install it on an iPhone

1. Open the address in **Safari**.
2. Tap **Share** (on newer iOS it may be under the **⋯** menu first).
3. Tap **Add to Home Screen**, then **Add**.

It opens full screen like an app and works without internet once it has been opened once.

On Android, open the address in Chrome and tap **Install app** or **Add to Home screen** in the menu.

## Good to know

- Each phone keeps its own log. Sharing one log between two phones isn't available in this version.
- Use **Settings → Backup** now and then, and before switching phones. Paste the backup into Notes, and paste it back into Backup on the new phone to restore.
- To update the app later, upload the new `index.html`, and in `sw.js` change `little-days-v1` to `little-days-v2` (and so on) so phones pick up the change.
