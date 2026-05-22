// Finale mortar rack — shared parameters (inches unless noted)

// --- Tubes (inventory) ---
tube_od_in = 2.375;
tube_length_in = 12;
shell_nominal_in = 2; // Class C 2 in. mortars

// --- Layout ---
num_rows = 5;
tubes_per_row = 5; // 5×5 per rack × 2 racks = 50 tubes (Commander finale)
num_dividers_x = num_rows + 1; // 6 green boards: left side + 4 between columns + right side
board_thickness_in = 0.5;
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
  -1.5,   // 2 middle left | center
  1.5,    // 3 center | middle right
  5,      // 4 middle right | outer right
  9,      // 5 right side (outer)
];

// --- Depth layout (+Y = toward back, from rack center) ---
depth_tube_offset_from_center_in = [
  -6.25, // 0 front
  -3.125,
  0,     // 2 center
  3.125,
  6.25,  // 4 back
];
end_wall_inner_offset_from_center_y = [
  -7.438, // front inner face
  7.438,  // back inner face
];

column_board_extension_in = 3; // +length along Y total (1-1/2 in. each end), centered on rack Y
end_wall_extension_in = 1; // brown ends: +1 in. per side in X (panel plane)
column_end_half_lap = true; // half-lap: columns lose bottom half, rows lose top half

// --- Angles (degrees from vertical; left negative, right positive) ---
outer_angle_deg = 12;

function row_offset(i) = i - floor(num_rows / 2); // -2 .. +2 for 5 rows
function sign(x) = x < 0 ? -1 : (x > 0 ? 1 : 0);
function row_angle_deg(i) =
  let (o = row_offset(i))
  o == 0 ? 0 : sign(o) * outer_angle_deg * abs(o) / 2;

tilt_pad_x_in = tube_length_in * sin(outer_angle_deg) + tube_gap_in;

// --- Structure (1/2 in. plywood walls only) ---
wall_thickness_in = 0.5;
wall_height_in = 3.5; // row boards + column boards (same height)

color_wall_end = [0.90, 0.62, 0.38];
color_wall_side = [0.58, 0.72, 0.42];
color_tube = [0.25, 0.45, 0.85, 0.85];

// --- Preview ---
preview = true;
$fn = preview ? 24 : 72;
show_tubes = true;
show_walls = true; // brown front/back ends
show_x_column_boards = true; // six green dividers along +X
