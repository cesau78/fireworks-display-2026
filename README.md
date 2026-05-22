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
| `data/firing-sequence.csv` | Show sequence; fuse placement at 12 sec/ft from show start |
| `data/sequence.json` | Legacy (optional); CSV drives the sequence table and map markers |
| `data/lines.json` | Map lines (`points`: `{lat,lng}` arrays) |
| `data/finale-rack.json` | Finale fan rack spec (5 rows, tube angles, layout) |
| `data/finale-rack-bom.json` | Plywood cut list and 4×8 sheet layout |
| `design/finale-mortar-rack/` | OpenSCAD model, `BOM.md`, construction/assembly blueprints (`README.md`) |

Open `index.html` locally with any static server (browsers block `fetch` on `file://`):

```bash
npx --yes serve .
```

## Zones (north → south)

| Zone | Size | Style |
|------|------|--------|
| **Fireworks Deployment Zone** | 50 × 150 ft | Yellow |
| **DMZ** | 50 × 50 ft, south of deployment | Grey |
| **Bonfire** | 20 × 20 ft, inside DMZ at NE corner | Red |
| **Dryer** | 10 × 10 ft, inside DMZ at NW corner | Blue |
| **Crowd Zone** | 50 × 100 ft, south of DMZ | Green (south, Dangerous) → yellow (north, More Dangerous) |

**Maps:** Field map shows 5-minute summary dots on the fuse path; **Placement** section has a horseshoe schematic with every cue (click for details).

**Finale rack:** **5×5 tubes per rack** (25), build **2 racks** for 50 Commander shells (47–96). Compact **2×4** base + 1/2 in. ply walls/lattice. See `design/finale-mortar-rack/BOM.md`.
