import os.path
import sys
from typing import List

import click
import ezdxf

GOOD_COLORS = [1, 5, 2, 3, 4, 6, 7, 8, 9, 10]


@click.command()
@click.option("-o", "--output", help="Output filename", default="out.dxf")
@click.argument("filenames", nargs=-1)
def main(output: str, filenames: List[str]) -> None:
    new = ezdxf.new()
    new_modelspace = new.modelspace()

    colors = GOOD_COLORS[:]
    for f in filenames:
        layername = os.path.splitext(os.path.basename(f))[0]
        doc = ezdxf.readfile(f)
        new.layers.new(name=layername, dxfattribs={"color": colors.pop(0)})
        for line in doc.modelspace().query("LINE"):
            new_modelspace.add_line(
                line.dxf.start, line.dxf.end, dxfattribs={"layer": layername},
            )

    new.saveas(output)


if __name__ == "__main__":
    main()
