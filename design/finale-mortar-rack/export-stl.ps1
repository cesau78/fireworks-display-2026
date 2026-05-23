# Generate STL meshes for the finale mortar rack (requires OpenSCAD on PATH).
$ErrorActionPreference = "Stop"
$OpenScad = if ($env:OPENSCAD) { $env:OPENSCAD } else { "C:\Program Files\OpenSCAD\openscad.exe" }
if (-not (Test-Path $OpenScad)) {
  Write-Error "OpenSCAD not found. Set OPENSCAD or install to 'C:\Program Files\OpenSCAD\openscad.exe'."
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$stlDir = Join-Path $root "stl"
$exportDir = Join-Path $root "export"
New-Item -ItemType Directory -Force -Path $stlDir | Out-Null

$jobs = @(
  @{ Scad = "rack-frame.scad"; Out = "rack-frame.stl" },
  @{ Scad = "rack-assembly.scad"; Out = "rack-assembly.stl" },
  @{ Scad = "outside-row-boards.scad"; Out = "outside-row-boards.stl" },
  @{ Scad = "column-dividers.scad"; Out = "column-dividers.stl" },
  @{ Scad = "row-dividers.scad"; Out = "row-dividers.stl" },
  @{ Scad = "outer-dowels.scad"; Out = "outer-dowels.stl" },
  @{ Scad = "inner-dowels.scad"; Out = "inner-dowels.stl" },
  @{ Scad = "mortar-tubes.scad"; Out = "mortar-tubes.stl" },
  @{ Scad = "end-wall.scad"; Out = "end-wall.stl" },
  @{ Scad = "column-board.scad"; Out = "column-board.stl" },
  @{ Scad = "mid-row-divider.scad"; Out = "mid-row-divider.stl" },
  @{ Scad = "dowel-middle.scad"; Out = "dowel-middle.stl" },
  @{ Scad = "dowel-inner.scad"; Out = "dowel-inner.stl" }
)

foreach ($job in $jobs) {
  $in = Join-Path $exportDir $job.Scad
  $out = Join-Path $stlDir $job.Out
  Write-Host "Exporting $($job.Out) ..."
  $proc = Start-Process -FilePath $OpenScad -ArgumentList @("-o", $out, $in) -Wait -PassThru -NoNewWindow
  if (-not (Test-Path $out)) { throw "OpenSCAD did not create $out (exit $($proc.ExitCode))" }
}

Write-Host "Done. STL files in $stlDir"
