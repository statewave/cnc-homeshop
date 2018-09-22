# define BASE and PARTS and PLATES (no extensions)
# optionally define CAMERA for demo image

CAMERA ?= 53,20,-5.5,50,0,23,360
LIB ?= $(BASE)_lib.scad

CAMMILL ?= cammill
PNGCRUSH ?= pngcrush

.PHONY: all
all: parts plates demo

.PHONY: parts
parts: $(patsubst %,out/%.dxf,$(PARTS))

.PHONY: plates
plates: $(patsubst %,gcode/%.gcode,$(PLATES)) gcode/0_combined.gcode

.PHONY: demo
demo: $(BASE)_demo.png

.PRECIOUS: out/%.dxf gcode/%.gcode

out/%.dxf: %.scad $(LIB)
	mkdir -p out
	openscad -o $@ $<

gcode/%.gcode: cfg/%.ngc out/%.dxf
	mkdir -p gcode
	$(CAMMILL) -d $< -o $@ -bm 1

gcode/0_combined.gcode: $(patsubst %,gcode/%.gcode,$(PLATES))
	cat $^ > $@

%_demo.png: %_demo.scad %_lib.scad
	openscad -o "$@" --imgsize=2048,2048 --camera=$(CAMERA) "$<"
	convert "$@" -transparent "#ffffe5" -trim +repage "$@"
	pngcrush -ow "$@"
