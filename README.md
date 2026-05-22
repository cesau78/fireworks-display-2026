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

Open `index.html` locally with any static server (browsers block `fetch` on `file://`):

```bash
npx --yes serve .
```

## Zones

**Deployment** — NW `45.048785, -90.487844` to SE `45.048522, -90.487548`.

**Crowd** — Same width, directly south of deployment; height is half the deployment zone (north edge shared with deployment south edge). NW `45.048522, -90.487844` to SE `45.048391, -90.487548`.
