.PHONY: all
all: pieces plates gcode/0_combined.gcode clamp_demo.png
	
.PHONY: pieces
pieces: out/1_hole.dxf out/2_pocket.dxf out/3_outline.dxf

.PHONY: plates
plates: gcode/1_hole.gcode gcode/2_pocket.gcode gcode/3_outline.gcode


out/%.dxf: %.scad clamp_lib.scad
	mkdir -p out
	openscad -o $@ $<

gcode/%.gcode: cfg/%.ngc out/%.dxf
	mkdir -p gcode
	cammill -d $< -o $@ -bm 1


gcode/0_combined.gcode: gcode/1_hole.gcode gcode/2_pocket.gcode gcode/3_outline.gcode
	cat $^ > $@

%_demo.png: %_demo.scad %_lib.scad
	openscad -o "$@" --imgsize=2048,2048 --camera=53,20,-5.5,50,0,23,360 "$<"
	convert "$@" -transparent "#ffffe5" -trim +repage "$@"
