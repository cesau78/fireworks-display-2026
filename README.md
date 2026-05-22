# Fireworks Display 2026

Team design board for sequence, placement, and zone definitions. Static site suitable for [GitHub Pages](https://pages.github.com/).

## Deploy on GitHub Pages

1. Create a repo (e.g. `fireworks-display-2026`) and push this folder.
2. In the repo: **Settings → Pages**.
3. **Build and deployment → Source**: Deploy from a branch.
4. **Branch**: `main` (or `master`), folder **`/` (root)** if the repo root is this project, or **`/docs`** if you only publish the `docs` subfolder.
5. Save. The site will be at `https://<user>.github.io/<repo>/` (or your custom domain).

To use this as a subdirectory of a larger repo, set Pages to publish from `/docs` and copy `index.html`, `data/`, and assets into `docs/`, or use a GitHub Action to publish the `fireworks-display-2026` folder.

## Collaborate

Edit JSON under `data/` via pull requests:

| File | Purpose |
|------|---------|
| `data/zone.json` | Zone boundaries (`zones[]`: deployment, crowd, …) |
| `data/placement.json` | Mortar/rack positions (`id`, `lat`, `lng`, `label`, `notes`) |
| `data/sequence.json` | Cues (`sort`, `time_sec`, `position_id`, `effect`, `notes`) |
| `data/lines.json` | Map lines (`points`: `{lat,lng}` arrays); or draw on site and copy JSON |

Open `index.html` locally with any static server (browsers block `fetch` on `file://`):

```bash
npx --yes serve .
```

## Zones (north → south)

| Zone | Size | Style |
|------|------|--------|
| **Deployment** | 50 × 200 ft | Yellow |
| **Safety** | 50 × 50 ft, south of deployment | Grey |
| **Bonfire** | 20 × 20 ft, inside safety at NE corner | Red |
| **Dryer** | 10 × 10 ft, inside safety at NW corner | Blue |
| **Crowd** | 50 × 50 ft, south of safety | Green |
