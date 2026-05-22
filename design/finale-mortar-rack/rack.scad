// Full rack assembly (row boards + column boards + middle row dividers + tubes + dowels).
FINALE_RACK_ASSEMBLY = true;
include <row-board-bottom.scad>
include <column-board-bottom.scad>
include <row-board-middle.scad>
include <row-dowel-top-inner.scad>
include <row-dowel-top-middle.scad>

module tube_solid(row_i, col_i) {
  translate([bay_center_x(row_i), tube_center_y(col_i), 0])
    rotate(row_angle_deg(row_i), [0, 1, 0])
      cylinder(h = tube_length_in, d = tube_od_in + 0.05, center = false);
}

module tube_at(row_i, col_i) {
  color(color_tube)
    tube_solid(row_i, col_i);
}

module row_dowel_top_at(i) {
  translate([row_dowel_placement_x(i), 0, row_dowel_center_z_in(i)])
    difference() {
      children();
      for (c = [0 : tubes_per_row - 1])
        translate([
          bay_center_x(row_dowel_tube_column(i)) - row_dowel_placement_x(i),
          tube_center_y(c),
          -row_dowel_center_z_in(i)
        ])
          rotate(row_angle_deg(row_dowel_tube_column(i)), [0, 1, 0])
            cylinder(h = tube_length_in, d = tube_od_in + 0.05, center = false);
    }
}

module row_dowels_top() {
  if (show_row_dowels_top) {
    for (i = row_dowel_middle_i)
      row_dowel_top_at(i) row_dowel_top_middle_cylinder();
    for (i = row_dowel_inner_i)
      row_dowel_top_at(i) row_dowel_top_inner_cylinder();
  }
}

module rack_assembly() {
  if (show_tubes) {
    for (r = [0 : num_rows - 1], c = [0 : tubes_per_row - 1])
      tube_at(r, c);
  }
  if (show_row_dowels_top)
    row_dowels_top();
}

rack_assembly();
