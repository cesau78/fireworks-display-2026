# Finale Mortar Rack — Bill of Materials

**Design:** 5 rows × 5 tubes = **25 tubes per rack**. Build **two identical racks** for the Commander finale (**50 shells**, cues **47–96** in `data/firing-sequence.csv`).

OpenSCAD source: `rack.scad` · Machine-readable list: `data/finale-rack-bom.json` · **Blueprint:** [`blueprint.svg`](blueprint.svg) (four-view parts + assembly)

---

## Stock to buy (two racks total)

| Item | Qty | Notes |
|------|-----|--------|
| **2×4×8 ft** | **3 studs** | Rip to **5/8 in.** thick; all wall boards for **both** racks (4 outside row + 12 column + 8 row dividers) |
| **2 in. dowel rod** | **6 ft total** | 18 in. × 4 cuts (outer dowels, both racks) · `row-dowel-top-middle.scad` |
| **1-1/2 in. dowel rod** | **6 ft total** | 18 in. × 4 cuts (inner dowels, both racks) · `row-dowel-top-inner.scad` |
| **Mortar tubes** | **50** | 2-3/8 in. OD × 12 in. long (25 per rack; often already on hand) |
| **Class C 2 in. shells** | **50** | Commander finale block |

Fasteners (per rack, approximate): screws or bolts through half-lap joints — pilot for 5/8 in. wall thickness.

---

## Cut list — one rack

All wall boards **5/8 in.** thick, height **3-1/2 in.** (`wall_height_in`). Notches per OpenSCAD part files (half-lap at crossings).

| Qty | Part | Cut size | OpenSCAD / notes |
|-----|------|----------|------------------|
| 2 | Outside row board (brown, front & back) | **24 × 3-1/2 × 5/8 in.** | `row-board-bottom.scad` — centered on rack X (+2-5/8 in. each end past prior layout); **top** half notched at 6 column X |
| 6 | Column divider | **18 × 3-1/2 × 5/8 in.** | `column-board-bottom.scad` — same blank each; **bottom** half at brown; **top** of upper band at 4 blue Y |
| 4 | Row divider | **24 × 3-1/2 × 5/8 in.** | `row-board-middle.scad` — 24 in. centered on X; bottom edge at **z = 1-3/4**; **bottom** half at 6 column X |
| 2 | Outer dowel (±6 in. X) | **2 in. OD × 18 in.** | `row-dowel-top-middle.scad` |
| 2 | Inner dowel (±2 in. X) | **1.5 in. OD × 18 in.** | `row-dowel-top-inner.scad` |

**Wall boards per rack:** 12 pieces · **Dowels per rack:** 4 pieces · **Tubes per rack:** 25

---

## Cut list — two racks (build qty)

Multiply the one-rack table by **2**. Suggested labeling: **Rack A** and **Rack B** before assembly.

| Part | Per rack | Both racks |
|------|----------|------------|
| Outside row board | 2 | **4** |
| Column divider | 6 | **12** |
| Row divider | 4 | **8** |
| Outer dowel (2 in. OD) | 2 | **4** |
| Inner dowel (1.5 in. OD) | 2 | **4** |
| Mortar tube | 25 | **50** |

**Total wall boards:** 24 · **Total dowels:** 8

---

## Dowel placement (per rack)

| Dowel | X from center | OD | File |
|-------|---------------|-----|------|
| Middle left | −6 in. | 2 in. | `row-dowel-top-middle.scad` |
| Inner left | −2 in. | 1.5 in. | `row-dowel-top-inner.scad` |
| Inner right | +2 in. | 1.5 in. | `row-dowel-top-inner.scad` |
| Middle right | +6 in. | 2 in. | `row-dowel-top-middle.scad` |

Install after frame dry-fit; bottom of dowel **1 in.** above top of blue mid-row boards (`dowel_above_middle_row_in`).

---

## Field setup

- Same row angles on both racks: **0°, ±6°, ±12°** (`outer_angle_deg` = 12° in `config.scad`).
- **25 tubes per rack** — map shells to racks (e.g. **47–71** on rack A, **72–96** on rack B) per your fuse plan.
- Racks are sized for **transport**; set **side by side** on site to restore fan width (~20-3/8 in. footprint width per rack).

### Colors in the 3D preview

| Color | Part |
|-------|------|
| Tan | Outside row board (24 × 3-1/2 × 5/8 in.) |
| Green | Column divider: 18 × 3-1/2 × 5/8 in. (6× same) |
| Blue | Row divider: 24 × 3-1/2 × 5/8 in. (4× same) |
| Gold / brown dowel | Outer dowel (2 in. OD) |
| Darker dowel | Inner dowel (1.5 in. OD) |

See **README.md** → [Building two racks](#building-two-racks) for step-by-step shop and field instructions.
