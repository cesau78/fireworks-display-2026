# Finale Mortar Rack

Five-row fan rack sized for **50 tubes** (5×5 per rack × 2 racks) — matches the Commander finale block **(47–96)/96** in `data/firing-sequence.csv`.

## Tubes

| | |
|---|---|
| Outer diameter | 2-3/8 in. (2.375 in.) |
| Length | 12 in. |
| Shell | Class C **2 in.** mortars |

## Row angles

Tubes tilt **left/right** from vertical in the plane toward the crowd (not forward/back). The **center row** is straight up (0°). Each row outward is **halfway** between the center angle and the outside row on that side:

| Row | Tilt | From vertical |
|-----|------|----------------|
| 1 — Outer left | Left | **−12°** |
| 2 — Inner left | Left | **−6°** (half of 12°) |
| 3 — Center | — | **0°** |
| 4 — Inner right | Right | **+6°** |
| 5 — Outer right | Right | **+12°** |

Total fan spread: **24°** (±12°). Adjust `outer_angle_deg` in `config.scad` (and `data/finale-rack.json`) — **10–15°** is typical for consumer 2 in. racks; 12° is a conservative default.

## Layout

- **5 rows** × **5 tubes** = 25 per rack (50 total with two racks)  
- **Rows** run left–right (**+X**): outer left → center → outer right  
- **Tubes in each row** run front–back (**+Y**)  
- **Tilt** is rotation about the **Y axis** (fan in the XZ plane), not about X  

Row/column spacing: **3.125 in.** center-to-center (tube OD + 1/2 in. divider + 1/4 in. gap) → **2.625 in.** clear opening per cell  

### Column positions (`config.scad`)

Rack center is **X = 0**. Tune each column independently:

| Array | Count | Meaning |
|-------|-------|---------|
| `column_tube_offset_from_center_in` | 5 | Tube centerline X per column (0–4) |
| `divider_offset_from_center_in` | 6 | Green divider centerline X — `[0]` left side … `[5]` right side |
| `depth_tube_offset_from_center_in` | 5 | Tube centerline Y along each row (front → back) |
| `end_wall_inner_offset_from_center_y` | 2 | Brown end wall **inner face** Y — `[front, back]` |

Negative X = left; negative Y = front. Rack origin is **X = 0, Y = 0** (center column / center tube along depth). Footprint width spans divider `[0]`–`[5]` inner faces; brown ends wrap the outer faces of those two side dividers.

Defaults restore the prior 2-1/2 in. center slot (`divider` 1 & 2 at ±1.5 in.) and middle L/R tubes bottom-flush to those boards.

All six green dividers share the same cut (**17-7/8 × 3-1/2 in.** with `column_board_extension_in`); only X positions differ. Row and column boards are **3-1/2 in.** tall (`wall_height_in`). At crossings, **columns** lose the **bottom** half and **rows** lose the **top** half (`column_end_half_lap`).

## Blueprints

Axes (rack origin **X = 0, Y = 0** at center column / center depth tube):

| Axis | Direction |
|------|-----------|
| **+X** | Right (outer right row) |
| **+Y** | Back (away from crowd) |
| **+Z** | Up (tube points up) |

### Plan view (top — construction layout)

One rack; build **two identical** units for 50 tubes. Brown = row boards (front/back). Green = column boards (six dividers along X).

```
        -X (left)                              +X (right)
          |                                        |
    G     |   o    o    o    o    o                |     G   ← column [0] / [5] = side walls
    |     |                                        |     |
    G  |  |   o    o    o    o    o                |  |  G   ← columns [1]–[4]
    |  |  |                                        |  |  |
    G  |  |   o    o    o    o    o                |  |  G
    |  |  |                                        |  |  |
    G  |  |   o    o    o    o    o                |  |  G
    |  |  |                                        |  |  |
    G  |  |   o    o    o    o    o                |  |  G
    |     |                                        |     |
          |======== brown front row (-Y) ==========|       ← 23-3/8 × 3-1/2 in.
          |                                        |
          |======== brown back row (+Y) ===========|

  o = tube (2-3/8 in. OD × 12 in.), tilted ±12° / ±6° / 0° by column
```

**Divider centerlines X (in):** −9, −5, −1.5, +1.5, +5, +9  
**Tube centerlines X (in):** −6.5, −3, 0, +3, +6.5  
**Tube centerlines Y per row (in):** −6.25, −3.125, 0, +3.125, +6.25  

### Half-lap joint (section at front or back crossing)

Board height **3-1/2 in.** Lap depth **1-3/4 in.** (half height). Column boards carry the load from the bottom; row boards cap from the top.

```
  side view at one column × row intersection (looking along +X)

       row board (brown)          column board (green)
       ┌─────────────┐            ┌──┐
       │  top half   │            │  │  top half (1-3/4) — column
       │  NOTCHED    ├────────────┤  │
       │  away       │  interlock │  │
       ├─────────────┤            │  │
       │  bottom     │            ├──┤  bottom half NOTCHED away
       │  remains    │            │  │  on column
       └─────────────┘            └──┘
            z=0 ─────────────────────── slab bottom (ground)
```

| Board | Notch location | Material removed |
|-------|----------------|------------------|
| Green column (×6) | Front & back brown crossings | **Bottom** 1-3/4 in. × 1/2 in. × board thickness |
| Brown row (×2) | Each of six column X positions | **Top** 1-3/4 in. × 1/2 in. × board thickness |

### Assembly order

1. **Cut** — per `BOM.md` / `data/finale-rack-bom.json`: 2× brown **23-3/8 × 3-1/2**, 6× green **17-7/8 × 3-1/2** (per rack).
2. **Notch columns** — bottom-half pockets at front and back Y (see OpenSCAD `column-board-bottom.scad`).
3. **Notch rows** — top-half pockets at all six divider X positions (`row-board-bottom.scad`).
4. **Dry-fit** — stand six green boards vertical; slide brown front and back boards onto the top laps.
5. **Fasten** — screw or bolt through laps (pilot holes in 1/2 in. plywood); keep tops flush at **z = 0** for tube seating.
6. **Tubes** — insert 25 tubes per rack; tilt outer columns per row-angle table above.
7. **Field** — place **two racks** side by side; wire shells **47–96** per `data/firing-sequence.csv`.

```mermaid
flowchart LR
  cut[Cut plywood] --> notchG[Notch green columns]
  notchG --> notchB[Notch brown rows]
  notchB --> fit[Dry-fit half-laps]
  fit --> fasten[Fasten frame]
  fasten --> tubes[Insert tubes]
  tubes --> field[Two racks on site]
```

### 3D reference

| Preview file | Shows |
|--------------|-------|
| `column-board-bottom.scad` | Six green boards + bottom notches |
| `row-board-bottom.scad` | Two brown boards + top notches |
| `rack.scad` | Full frame + tubes |

## Structure

| Part | Size |
|------|------|
| Brown end walls (front & back) | **23-3/8 × 3-1/2 in.** (`end_wall_extension_in` +1 in./side in X) |
| Green dividers (6 along +X) | 1/2 in. × **17-7/8 × 3-1/2 in.** |

Footprint widens **~2-3/4 in.** per side for fan tilt so tubes do not hit the side dividers.

## OpenSCAD

```bash
openscad design/finale-mortar-rack/rack.scad
openscad design/finale-mortar-rack/row-board-bottom.scad
openscad design/finale-mortar-rack/column-board-bottom.scad
```

| File | Role |
|------|------|
| `config.scad` | Tubes, angles, divider/tube offsets, extensions |
| `layout.scad` | Derived footprint and centerline helpers (include after `config.scad`) |
| `row-board-bottom.scad` | Brown front/back boards + half-lap (self-contained preview) |
| `column-board-bottom.scad` | Six green dividers + half-lap (self-contained preview) |
| `rack.scad` | Full assembly (includes both board files + optional tubes) |

Edit `config.scad` for angles, divider/tube positions, and wall height.

## Web board

Spec for the site: `data/finale-rack.json` (Finale Rack section on the design board).
