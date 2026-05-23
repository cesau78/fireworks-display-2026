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

function end_wall_w_in() = row_board_span_in;
function end_wall_x0() = rack_center_x() - row_board_span_in / 2;
function end_wall_height_in() = wall_height_in;

function tube_center_y(col_i) =
  rack_center_y() + depth_tube_offset_from_center_in[col_i];

function column_board_length_in() = green_board_length_in;
function column_board_y0() =
  rack_center_y() - column_board_length_in() / 2;
function board_half_lap_z_in() = wall_height_in / 2;

function num_middle_row_dividers() = tubes_per_row - 1;

function middle_row_divider_center_y(i) =
  rack_center_y()
    + (depth_tube_offset_from_center_in[i]
      + depth_tube_offset_from_center_in[i + 1])
      / 2;

function middle_row_z0_in() = board_half_lap_z_in();
function middle_row_height_in() = wall_height_in;
function middle_row_half_lap_z_in() = middle_row_height_in() / 2;
// Lap in the column upper band (overlap with column is only wall_height - z0).
function column_middle_row_notch_z0() =
  middle_row_z0_in() + (wall_height_in - middle_row_z0_in()) / 2;
function column_middle_row_notch_h_in() =
  (wall_height_in - middle_row_z0_in()) / 2;
function row_board_middle_w_in() = end_wall_w_in();
function row_board_middle_x0() = end_wall_x0();

function footprint_w_in() = max(
  divider_inner_right_x() - divider_inner_left_x(),
  end_wall_w_in(),
  2 * (layout_half_span_in() + tilt_pad_x_in)
);

function bay_center_x(row_i) =
  rack_center_x() + column_tube_offset_from_center_in[row_i];

function divider_clear_span_x(bay_i) =
  divider_offset_from_center_in[bay_i + 1]
    - divider_offset_from_center_in[bay_i]
    - wall_thickness_in;

// --- Top dowels (middle + inner primitives; rack.scad places num_row_dowels_top copies) ---
function dowel_layer_z0_in() =
  middle_row_z0_in() + middle_row_height_in() + dowel_above_middle_row_in;

function row_dowel_length_y_in() = column_board_length_in();

function row_dowel_od_at(i) = row_dowel_od_in[i];

function row_dowel_center_z_in(i) = dowel_layer_z0_in() + row_dowel_od_at(i) / 2;

function row_dowel_placement_x(i) =
  rack_center_x() + row_dowel_x_offset_from_center_in[i];

function row_dowel_tube_column(i) = row_dowel_tube_column_i[i];
