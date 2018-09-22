# Cammill Notes

Until fixes are merged, you should use thatch's fork.  This lets you pick
postprocessor by name, which is pretty essential for scriptable builds, but it
also fixes some errors which are printed to stderr.

https://github.com/thatch/cammill

## File names

`cfg/*.ngc` -> `gcode/*.gcode` is because `ngc` is specialcased inside cammill,
and `gcode` is the default pattern filter in `pronterface`.

If you want to preview the settings, you can run `make` (to generate the dxf)
then `cammill cfg/foo.ngc` and it will load the presets.

## Adjusting for your machine

In general, parameters like bit sizes and material thickness need to be set in
`cfg/*.ngc` (yes, all of them until it's scripted), and you may need to
duplicate those in `*_lib.scad` if there are features (like slots or tabs) in
the model.

## Machine zero

The default EMC postprocessor doesn't zero or home your machine, so do that
first yourself.  Then run the gcode program.  Most should have zero very close
to lower-left of the model, but when doing final outline the bit may go
negative by its radius.  Please simulate or air-cut as there isn't yet
consistency here.

The zero from openscad is preserved into cammill only if `(cfg:Misc-Zero: 1)`
is specified, otherwise it's lower-left.  If you rotate from the gui, this
differs.
