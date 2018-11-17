#!/bin/bash
for f in *.ngc; do
  x="${f%.*}";
  sed -i.bak -e 's/out\/.*)/out\/'$x'.dxf)/' -e 's/gcode\/.*/gcode\/'$x'.gcode)/' $f;
done
