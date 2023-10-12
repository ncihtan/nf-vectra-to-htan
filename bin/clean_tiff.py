#!/usr/bin/env python

import argparse
import tifftools
import os

import argparse

parser = argparse.ArgumentParser()

parser.add_argument("input")
parser.add_argument("--suffix", default="_cleaned")

args = parser.parse_args()


def split_all_ext(filename):
    basename = filename
    extensions = []
    while "." in basename:
        basename, ext = os.path.splitext(basename)
        extensions.append(ext)
    return basename, "".join(reversed(extensions))


basename, all_ext = split_all_ext(args.input)

new_filename = f"{basename}{args.suffix}{all_ext}"
print(new_filename)


unset_list = [
    "DateTime",
]

tifftools.tiff_set(args.input, output=new_filename, overwrite=False, unset=unset_list)
