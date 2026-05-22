// Mid-height row dividers (between tube rows along Y) — open to preview.
include <config.scad>
include <layout.scad>

module row_board_middle(y_center) {
  lap = middle_row_half_lap_z_in();
  z0 = middle_row_z0_in();
  h = middle_row_height_in();
  eps = 0.02;
  color(color_middle_row)
    translate([row_board_middle_x0(), y_center - wall_thickness_in / 2, z0])
      difference() {
        cube([row_board_middle_w_in(), wall_thickness_in, h]);
        if (middle_row_half_lap)
          for (i = [0 : num_rows])
            translate([
              x_divider_center_x(i) - wall_thickness_in / 2 - row_board_middle_x0(),
              -eps,
              0
            ])
              cube([
                wall_thickness_in,
                wall_thickness_in + 2 * eps,
                lap + eps
              ]);
      }
}

module row_boards_middle() {
  for (i = [0 : num_middle_row_dividers() - 1])
    row_board_middle(middle_row_divider_center_y(i));
}

row_boards_middle();
