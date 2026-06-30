// Finale mortar rack — shared parameters (inches unless noted)

// --- Tubes (inventory) ---
tube_od_in = 2.375;
tube_length_in = 12;
shell_nominal_in = 2; // Class C 2 in. mortars

// --- Layout ---
num_rows = 5;
tubes_per_row = 5; // 5×5 per rack × 2 racks = 50 tubes (Commander finale)
num_dividers_x = num_rows + 1; // 6 green boards: left side + 4 between columns + right side
board_thickness_in = 0.625;
tube_gap_in = 0.25; // extra clearance inside each cell
row_spacing_in = tube_od_in + board_thickness_in + tube_gap_in;
row_depth_in = tube_od_in + board_thickness_in + tube_gap_in;

// --- Column layout (+X = right, from rack center) ---
column_tube_offset_from_center_in = [
  -6.5, // 0 outer left
  -3, // 1 middle left
  0,      // 2 center
  3,  // 3 middle right
  6.5,  // 4 outer right
];
divider_offset_from_center_in = [
  -9,     // 0 left side (outer)
  -5,     // 1 outer left | middle left
  -1.5625, // 2 middle left | center (+1/16 each vs 1/2 in. boards — keeps 2-1/2 in. center slot)
  1.5625,  // 3 center | middle right
  5,      // 4 middle right | outer right
  9,      // 5 right side (outer)
];

// --- Depth layout (+Y = toward back, from rack center) ---
depth_tube_offset_from_center_in = [
  -6.5, // 0 front
  -3.25,
  0,    // 2 center
  3.25,
  6.5,  // 4 back
];
end_wall_inner_offset_from_center_y = [
  -7.6875, // front inner face
  7.6875,  // back inner face
];

green_board_length_in = 18; // green dividers + dowels along +Y; centered on rack Y (layout column_board_y0)
row_board_span_in = 24; // outside row boards + row dividers along +X; centered on rack; notches at columns unchanged (+2-5/8 in. each end vs prior 1 in. extension)
column_end_half_lap = true; // half-lap: columns lose bottom half, rows lose top half
middle_row_half_lap = true; // mid-height row dividers: bottom half out; columns lose top of upper half

// --- Top dowels (four cylinders along +Y, centered on rack Y) ---
num_row_dowels_top = 4;
row_dowel_x_offset_from_center_in = [
  -6,     // 0 inside outer-left column (bay 0)
  -2,  // 1 outside middle column, left (bay 1)
  2,   // 2 outside middle column, right (bay 3)
  6,      // 3 inside outer-right column (bay 4)
];
row_dowel_bay_i = [0, 1, 3, 4]; // green-column bay per dowel (for OD)
row_dowel_tube_column_i = [0, 1, 3, 4]; // tubes to subtract per dowel
dowel_above_middle_row_in = 1; // bottom of dowel sits this far above row-board-middle top
row_dowel_od_middle_in = 2;   // ±6 in. X (bay 0 / 4)
row_dowel_od_inner_in = 1.5;  // ±2 in. X (bay 1 / 3)
row_dowel_middle_i = [0, 3];
row_dowel_inner_i = [1, 2];
// OD per dowel index: [middle-L, inner-L, inner-R, middle-R]
row_dowel_od_in = [
  row_dowel_od_middle_in,
  row_dowel_od_inner_in,
  row_dowel_od_inner_in,
  row_dowel_od_middle_in,
];
dowel_fit_clearance_in = 0.125; // used when auto-sizing OD from bay span
center_tube_column_i = 2; // middle tube column (0..num_rows-1)

// --- Angles (degrees from vertical; left negative, right positive) ---
outer_angle_deg = 12;

function row_offset(i) = i - floor(num_rows / 2); // -2 .. +2 for 5 rows
function sign(x) = x < 0 ? -1 : (x > 0 ? 1 : 0);
function row_angle_deg(i) =
  let (o = row_offset(i))
  o == 0 ? 0 : sign(o) * outer_angle_deg * abs(o) / 2;

tilt_pad_x_in = tube_length_in * sin(outer_angle_deg) + tube_gap_in;

// --- Structure (5/8 in. wall boards) ---
wall_thickness_in = 0.625;
wall_height_in = 3.5; // row boards + column boards (same height)

color_wall_end = [0.863, 0.149, 0.149]; // outside row board — red (#DC2626)
color_wall_side = [0.941, 0.941, 0.941]; // column divider — white (#F0F0F0)
color_middle_row = [0.231, 0.510, 0.965]; // row divider — blue (#3B82F6)
color_dowel_middle = [0.85, 0.75, 0.35];
color_dowel_standard = [0.75, 0.55, 0.25];
color_tube = [0.769, 0.627, 0.416, 0.85]; // cardboard brown (#C4A06A)

// --- Preview ---
preview = true;
$fn = preview ? 24 : 72;
show_tubes = true;
show_walls = true; // brown front/back ends
show_x_column_boards = true; // six green dividers along +X
show_middle_row_boards = true; // four mid-height row dividers (between tube rows along Y)
show_row_dowels_top = true; // dowels along Y between column boards
