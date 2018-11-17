# define BASE and PARTS and PLATES (no extensions)
# optionally define CAMERA for demo image
# If there are multiple plate sets, use A_PLATES, etc.

CAMERA ?= 53,20,-5.5,50,0,23,360
LIB ?= $(BASE)_lib.scad $(EXTRA_LIB)
PROJECTION ?= p

CAMMILL ?= cammill
PNGCRUSH ?= pngcrush
PYTHON ?= python2

.PHONY: all
all: check parts plates demo

.PHONY: clean
clean:
	rm -rf out gcode $(BASE)_demo.png

.PHONY: parts
parts: $(patsubst %,gcode/%.gcode,$(PARTS))

.PHONY: plates
plates: $(patsubst %,gcode/%.gcode,$(PLATES)) \
	$(if $(A_PLATES),gcode/a0_combined.gcode) \
	$(if $(B_PLATES),gcode/b0_combined.gcode) \
	$(if $(C_PLATES),gcode/c0_combined.gcode) \
	$(if $(D_PLATES),gcode/d0_combined.gcode) \
	$(if $(PLATES),gcode/0_combined.gcode)

.PHONY: demo
demo: $(BASE)_demo.png

.PRECIOUS: out/%.dxf gcode/%.gcode

out/%.dxf: %.scad $(LIB)
	mkdir -p out
	openscad -o $@ $<

gcode/%.gcode: cfg/%.ngc out/%.dxf
	mkdir -p gcode
	$(CAMMILL) -d $< -o $@ -bm 1

# TODO reduce repetition in this section
# Omit tool changes and spindle-off; leave M01 as an optional pause in Mach3.
gcode/0_combined.gcode: $(patsubst %,gcode/%.gcode,$(PLATES))
	cat $^ | grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"

gcode/a0_combined.gcode: $(patsubst %,gcode/%.gcode,$(A_PLATES))
	cat $^ | grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
gcode/b0_combined.gcode: $(patsubst %,gcode/%.gcode,$(B_PLATES))
	cat $^ | grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
gcode/c0_combined.gcode: $(patsubst %,gcode/%.gcode,$(C_PLATES))
	cat $^ | grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
gcode/d0_combined.gcode: $(patsubst %,gcode/%.gcode,$(D_PLATES))
	cat $^ | grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"

# the complex MAKEFILE_LIST call is basically dirname(this_file)
.PHONY: check
check:
	$(PYTHON) $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))/syntax_checker.py $(patsubst %,%.scad,$(PLATES)) $(patsubst %,%.scad,$(PARTS))

# Avoid in-place updates; convert doesn't like overwriting?
%.png: %.scad $(LIB)
	( \
		T=$$(mktemp -d); \
		echo "Tempdir=$$T"; \
		openscad -o "$$T/openscad.png" --imgsize=2048,2048 --camera=$(CAMERA) --projection=$(PROJECTION) "$<" && \
		convert "$$T/openscad.png" -transparent "#ffffe5" -trim +repage "$$T/convert.png" && \
		$(PNGCRUSH) "$$T/convert.png" "$@" && \
		rm -r "$$T" \
	)
