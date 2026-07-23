# 🚀 Setup Guide — Chinnadurai S U Profile README

Everything is generated. Here's how to go live.

## 1. Create the special repo
Your profile README lives in a repo named **exactly** your username:

```bash
# Repo name must be:  chinnadurai-su
git init
git add .
git commit -m "feat: cinematic animated profile"
git branch -M main
git remote add origin https://github.com/chinnadurai-su/chinnadurai-su.git
git push -u origin main
```

Once pushed, it renders automatically at **github.com/chinnadurai-su**.

## 2. Embed your real anime avatar  (⚠️ the one manual step)
I built polished holographic **frames** with a placeholder, because I can't process your attached image. Drop your PNG in and run the helper:

```bash
cd assets
./embed-avatar.sh /path/to/your-avatar.png
```

- It removes the white background (needs ImageMagick — `brew install imagemagick`) and writes two paste-ready snippets.
- For a *pixel-perfect* cut-out, run the image through [remove.bg](https://remove.bg) first, then point the script at the transparent PNG.
- Paste `snippet-banner.txt` into the avatar group in **banner.svg** *and* **banner-light.svg**, and `snippet-lanyard.txt` into **lanyard.svg** (search each file for the `<!-- Replace ... -->` comment).

## 3. Enable the contribution snake 🐍
1. Push the repo (the workflow is at `.github/workflows/github-snake.yml`).
2. Go to **Actions** tab → run **"Generate Snake Animation"** once manually (workflow_dispatch).
3. It creates an `output` branch with the purple+pink snake SVGs — the README already points at them. It re-runs daily.
4. If Actions is blocked: **Settings → Actions → General → Workflow permissions → Read and write**.

## 4. Fill in the placeholders in `README.md`
- `REPO_NAME_1` / `REPO_NAME_2` → your two featured repos (Featured Projects section).
- `Portfolio` badge `href="#"` → your live portfolio URL.
- All stats/streak/trophy/graph cards read **live data** from your GitHub automatically once the repo is public — no config needed.

---

## 📦 What's in this repo
| File | Purpose |
|------|---------|
| `README.md` | The full profile — banners, typing, stats, langs, trophies, snake, wave footer |
| `assets/banner.svg` | 1280×740 animated hero (dark) — terminal, hologram avatar, name/role typing, glass cards, code editor |
| `assets/banner-light.svg` | Light-theme recolor (auto-switches via `<picture>`) |
| `assets/lanyard.svg` | Swinging ReactBits-style ID lanyard with QR + barcode |
| `assets/stats.svg` | Custom glassmorphism stats card (animated rank + bars) |
| `assets/langs.svg` | Animated skill-proficiency bars |
| `assets/trophies.svg` | Pop-in trophy showcase with shine sweep |
| `assets/embed-avatar.sh` | Avatar background-removal + Base64 embed helper |
| `.github/workflows/github-snake.yml` | Daily purple+pink snake generator (Platane/snk) |

## ⚙️ Notes on the tech
- **100% SVG + CSS + SMIL, zero JavaScript** → renders on GitHub.
- **Fonts**: GitHub blocks custom web fonts in proxied SVGs, so everything uses safe system stacks (the "script" name effect is approximated with the animated gradient + letter-by-letter reveal).
- **Custom `stats.svg`/`langs.svg`/`trophies.svg`** show *designed* numbers (edit them to taste). The README's live cards (github-readme-stats, github-profile-trophy) pull real data — use whichever you prefer, or both.
