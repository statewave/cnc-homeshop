BASE=pantry_cans

A_PLATES=a1_pocket a2_outline
B_PLATES=b1_pocket b2_outline
C_PLATES=c1_pocket c2_outline

include ../../_lib/makefile.inc

out/a.dxf: $(patsubst %,out/%.dxf,$(A_PLATES))
	python ../../_lib/dxfmerge.py -o $@ $^
out/b.dxf: $(patsubst %,out/%.dxf,$(B_PLATES))
	python ../../_lib/dxfmerge.py -o $@ $^
out/c.dxf: $(patsubst %,out/%.dxf,$(C_PLATES))
	python ../../_lib/dxfmerge.py -o $@ $^

all: out/a.dxf out/b.dxf out/c.dxf
