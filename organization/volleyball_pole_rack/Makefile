.PHONY: all
all: pieces plates
	
.PHONY: pieces
pieces: out/top.dxf out/top_rabbet.dxf out/back.dxf out/back_rabbet.dxf out/verticals.dxf out/spinner.dxf out/front.dxf out/front_rabbet.dxf out/1_pocket.dxf out/2_outline.dxf out/3_spinner_pocket.dxf out/4_spinner_outline.dxf

.PHONY: plates
plates: gcode/1_pocket.gcode gcode/2_outline.gcode gcode/0_combined.gcode gcode/3_spinner_pocket.gcode gcode/4_spinner_outline.gcode

out/%.dxf: %.scad volleyball_pole_rack.scad
	mkdir -p out
	openscad -o $@ $<

gcode/%.gcode: cfg/%.ngc out/%.dxf
	mkdir -p gcode
	cammill -d $< -o $@ -bm 1

gcode/0_combined.gcode: gcode/1_pocket.gcode gcode/2_outline.gcode
	cat $^ > $@

