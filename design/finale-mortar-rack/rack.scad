// Full rack assembly (row boards + column boards + tubes).
include <row-board-bottom.scad>
include <column-board-bottom.scad>

module tube_at(row_i, col_i) {
  translate([bay_center_x(row_i), tube_center_y(col_i), 0])
    rotate(row_angle_deg(row_i), [0, 1, 0])
      color(color_tube)
        cylinder(h = tube_length_in, d = tube_od_in, center = false);
}

module rack_assembly() {
  if (show_tubes) {
    for (r = [0 : num_rows - 1], c = [0 : tubes_per_row - 1])
      tube_at(r, c);
  }
}

rack_assembly();
