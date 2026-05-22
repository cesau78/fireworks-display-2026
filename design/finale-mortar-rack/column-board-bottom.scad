// Green column dividers — open this file directly to preview.
include <config.scad>
include <layout.scad>

module column_board_bottom(x_center) {
  lap = board_half_lap_z_in();
  eps = 0.02;
  oy_front = end_wall_inner_front_y() - wall_thickness_in;
  oy_back = end_wall_inner_back_y();
  y0b = column_board_y0();
  color(color_wall_side)
    translate([x_center - wall_thickness_in / 2, y0b, 0])
      difference() {
        cube([
          wall_thickness_in,
          column_board_length_in(),
          wall_height_in
        ]);
        if (column_end_half_lap) {
          translate([0, oy_front - y0b - eps, 0])
            cube([
              wall_thickness_in + 2 * eps,
              wall_thickness_in + 2 * eps,
              lap + eps
            ]);
          translate([0, oy_back - y0b - eps, 0])
            cube([
              wall_thickness_in + 2 * eps,
              wall_thickness_in + 2 * eps,
              lap + eps
            ]);
        }
      }
}

module column_boards_bottom() {
  for (i = [0 : num_rows])
    column_board_bottom(x_divider_center_x(i));
}

column_boards_bottom();
