.PHONY: all
all: plates 1_outline.svg
	
.PHONY: plates
plates: gcode/1_outline.gcode

out/%.dxf: %.scad calipers_lib.scad
	mkdir -p out
	openscad -o $@ $<

%.svg: %.scad calipers_lib.scad
	openscad -o $@ $<

gcode/%.gcode: cfg/%.ngc out/%.dxf
	mkdir -p gcode
	cammill -d $< -o $@ -bm 1

#gcode/0_combined.gcode: gcode/1_pocket.gcode gcode/2_outline.gcode
#	cat $^ > $@
