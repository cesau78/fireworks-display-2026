// Rack layout geometry. Include config.scad once before this file.
// Functions are ordered so each name is defined before use (OpenSCAD 2021).

function rack_center_x() = 0;
function rack_center_y() = 0;

function x_divider_center_x(i) =
  rack_center_x() + divider_offset_from_center_in[i];

function divider_inner_left_x() =
  x_divider_center_x(0) + wall_thickness_in / 2;
function divider_inner_right_x() =
  x_divider_center_x(num_rows) - wall_thickness_in / 2;

function end_wall_inner_front_y() =
  rack_center_y() + end_wall_inner_offset_from_center_y[0];
function end_wall_inner_back_y() =
  rack_center_y() + end_wall_inner_offset_from_center_y[1];

function footprint_d_in() = max(
  end_wall_inner_back_y() - end_wall_inner_front_y(),
  (tubes_per_row - 1) * row_depth_in + tube_od_in
);

function layout_half_span_in() =
  max(
    max([for (i = [0 : num_rows - 1]) abs(column_tube_offset_from_center_in[i])])
      + tube_od_in / 2,
    max([for (i = [0 : num_rows]) abs(divider_offset_from_center_in[i])])
      + wall_thickness_in / 2
  );

function end_wall_w_in() =
  x_divider_center_x(num_rows) - x_divider_center_x(0) + wall_thickness_in
    + 2 * end_wall_extension_in;
function end_wall_x0() =
  x_divider_center_x(0) - wall_thickness_in / 2 - end_wall_extension_in;
function end_wall_height_in() = wall_height_in;

function tube_center_y(col_i) =
  rack_center_y() + depth_tube_offset_from_center_in[col_i];

function column_board_length_in() = footprint_d_in() + column_board_extension_in;
function column_board_y0() =
  rack_center_y() - column_board_length_in() / 2;
function board_half_lap_z_in() = wall_height_in / 2;

function footprint_w_in() = max(
  divider_inner_right_x() - divider_inner_left_x(),
  2 * (layout_half_span_in() + tilt_pad_x_in)
);

function bay_center_x(row_i) =
  rack_center_x() + column_tube_offset_from_center_in[row_i];
