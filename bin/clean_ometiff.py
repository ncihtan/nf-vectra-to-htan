#!/usr/bin/env python

import sys
import tifftools
import ome_types
import os

input = sys.argv[1]


def split_all_ext(filename):
    basename = filename
    extensions = []
    while "." in basename:
        basename, ext = os.path.splitext(basename)
        extensions.append(ext)
    return basename, "".join(reversed(extensions))


insert_string = "_cleaned"

basename, all_ext = split_all_ext(input)

new_filename = f"{basename}{insert_string}{all_ext}"
print(new_filename)

ome = ome_types.from_tiff(input)
ome.structured_annotations.clear()
for i, exp in enumerate(ome.experimenters):
    ome.experimenters[i].email = None
    ome.experimenters[i].first_name = None
    ome.experimenters[i].last_name = None
for i, img in enumerate(ome.images):
    ome.images[i].acquisition_date = None

set_list = [(tifftools.Tag.IMAGEDESCRIPTION, ome_types.to_xml(ome))]

tifftools.tiff_set(input, overwrite=True, setlist=set_list)
