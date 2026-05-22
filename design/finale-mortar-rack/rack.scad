// Full rack assembly (row boards + column boards + middle row dividers + tubes + dowels).
FINALE_RACK_ASSEMBLY = true;
include <config.scad>
include <layout.scad>
include <row-board-bottom.scad>
include <column-board-bottom.scad>
include <row-board-middle.scad>
include <row-dowel-top-inner.scad>
include <row-dowel-top-middle.scad>
include <rack-modules.scad>

row_boards_bottom();
column_boards_bottom();
row_boards_middle();
rack_assembly();
