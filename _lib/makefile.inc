# define BASE and PARTS and PLATES (no extensions)
# optionally define CAMERA for demo image
# If there are multiple plate sets, use A_PLATES, etc.

CAMERA ?= 53,20,-5.5,50,0,23,360
LIB ?= $(BASE)_lib.scad $(EXTRA_LIB)
PROJECTION ?= p

CAMMILL ?= cammill
PNGCRUSH ?= pngcrush
PYTHON ?= python2

LIB_DIR = $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
CONFIG_LIBS = $(wildcard $(LIB_DIR)/cam/*.config) $(EXTRA_LIB)
VARS_TARGET= $(patsubst %.scad,%.txt,$(wildcard vars.scad))

ALL_SCAD=$(BASE)_demo.scad $(patsubst %,%.scad,$(PLATES) $(PARTS) $(A_PLATES) $(B_PLATES) $(C_PLATES) $(D_PLATES) $(E_PLATES) $(F_PLATES) $(G_PLATES) $(H_PLATES) $(I_PLATES) $(J_PLATES) $(K_PLATES) $(L_PLATES))

.PHONY: all
all: check parts plates

.PHONY: clean
clean:
	rm -rf out gcode $(BASE)_demo.png vars.txt

.PHONY: parts
parts: $(patsubst %,gcode/%.gcode,$(PARTS)) $(patsubst %,out/%.stl,$(STL_PARTS))

.PHONY: plates
plates: $(patsubst %,gcode/%.gcode,$(PLATES)) \
	$(if $(A_PLATES),gcode/a0_combined.gcode) \
	$(if $(B_PLATES),gcode/b0_combined.gcode) \
	$(if $(C_PLATES),gcode/c0_combined.gcode) \
	$(if $(D_PLATES),gcode/d0_combined.gcode) \
	$(if $(E_PLATES),gcode/e0_combined.gcode) \
	$(if $(F_PLATES),gcode/f0_combined.gcode) \
	$(if $(G_PLATES),gcode/g0_combined.gcode) \
	$(if $(H_PLATES),gcode/h0_combined.gcode) \
	$(if $(I_PLATES),gcode/i0_combined.gcode) \
	$(if $(J_PLATES),gcode/j0_combined.gcode) \
	$(if $(K_PLATES),gcode/k0_combined.gcode) \
	$(if $(L_PLATES),gcode/l0_combined.gcode) \
	$(if $(PLATES),gcode/0_combined.gcode)

.PHONY: demo
demo: $(BASE)_demo.png

# ECHO: "VarName", 1.23
vars.txt: vars.scad $(LIB)
	# This won't actually write the file unless there is a top-level object in the
	# lib, but will send echo to stderr.
	openscad -o _tmp.dxf $< 2>&1 | perl -ne 'print "-D $$1=$$2 " if /ECHO: "(.*)", (.*)/' > $@
	grep -q -v undef $@
	rm -f _tmp.dxf || :

.PRECIOUS: out/%.dxf gcode/%.gcode out/%.ngc vars.txt

out/%.dxf: %.scad $(LIB)
	mkdir -p out
	openscad -o $@ $<

out/%.stl: %.scad $(LIB)
	mkdir -p out
	openscad -o $@ $<

.PHONY: showcfgdeps
showcfgdeps:
	@echo $(VARS_TARGET) $(CONFIG_LIBS)

# This naming is a bit of technical debt, to avoid generated (and ignored) files
# having the same name as ones that used to be checked in.
out/%.ngc: cfg/%.ngc $(VARS_TARGET) $(CONFIG_LIBS)
	mkdir -p out
	$(PYTHON) $(LIB_DIR)/cam/cammill_config.py \
		$$(cat vars.txt) \
		-DInputName=out/$*.dxf \
		-DOutputName=gcode/$*.gcode \
		$< -o $@

gcode/%.gcode: out/%.ngc out/%.dxf
	mkdir -p gcode
	$(CAMMILL) -d $< -o $@ -bm 1

# TODO reduce repetition in this section
# Omit tool changes and spindle-off; leave M01 as an optional pause in Mach3.
gcode/0_combined.gcode: $(patsubst %,gcode/%.gcode,$(PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt

gcode/a0_combined.gcode: $(patsubst %,gcode/%.gcode,$(A_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/b0_combined.gcode: $(patsubst %,gcode/%.gcode,$(B_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/c0_combined.gcode: $(patsubst %,gcode/%.gcode,$(C_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/d0_combined.gcode: $(patsubst %,gcode/%.gcode,$(D_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/e0_combined.gcode: $(patsubst %,gcode/%.gcode,$(E_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/f0_combined.gcode: $(patsubst %,gcode/%.gcode,$(F_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/g0_combined.gcode: $(patsubst %,gcode/%.gcode,$(G_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/h0_combined.gcode: $(patsubst %,gcode/%.gcode,$(H_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/i0_combined.gcode: $(patsubst %,gcode/%.gcode,$(I_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/j0_combined.gcode: $(patsubst %,gcode/%.gcode,$(J_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/k0_combined.gcode: $(patsubst %,gcode/%.gcode,$(K_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt
gcode/l0_combined.gcode: $(patsubst %,gcode/%.gcode,$(L_PLATES))
	for f in $^; do echo "( line_start $$f )"; cat $$f; done | \
		grep -v '^\(M06\|M05\)' | sed -e 's/^M02/M01/' > "$@"
	echo "M05" >> "$@"
	grep -n line_start "$@" > "$@"_index.txt

# the complex MAKEFILE_LIST call is basically dirname(this_file)
.PHONY: check
check:
	EXTRA_LIB="$(EXTRA_LIB)" $(PYTHON) $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))/syntax_checker.py $(ALL_SCAD)

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
