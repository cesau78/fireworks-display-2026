// Brown front/back row boards — open this file directly to preview.
include <config.scad>
include <layout.scad>

module row_board_bottom(y_outer) {
  lap = board_half_lap_z_in();
  eps = 0.02;
  color(color_wall_end)
    difference() {
      translate([end_wall_x0(), y_outer, 0])
        cube([end_wall_w_in(), wall_thickness_in, end_wall_height_in()]);
      if (column_end_half_lap)
        for (i = [0 : num_rows])
          translate([
            x_divider_center_x(i) - wall_thickness_in / 2,
            y_outer - eps,
            lap
          ])
            cube([
              wall_thickness_in,
              wall_thickness_in + 2 * eps,
              lap + eps
            ]);
    }
}

module row_boards_bottom() {
  iy0 = end_wall_inner_front_y();
  iy1 = end_wall_inner_back_y();
  row_board_bottom(iy0 - wall_thickness_in);
  row_board_bottom(iy1);
}

if (is_undef(FINALE_RACK_ASSEMBLY))
  row_boards_bottom();
