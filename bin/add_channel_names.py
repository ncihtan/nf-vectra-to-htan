#!/usr/bin/env python

import ome_types
import tifftools
import sys


# Function to read OME-XML using ome-types
def read_ome_tiff(ome_tiff_path):
    metadata = ome_types.from_tiff(ome_tiff_path)
    return metadata


# Function to add channel names to OME-XML
def add_channel_names_to_ome_xml(ome_xml, channel_names):
    image = ome_xml.images[0]
    pixels = image.pixels

    # Check if the number of channel names matches the number of channels
    if len(channel_names) != len(pixels.channels):
        print("Number of channel names does not match the number of channels.")
        return

    # Set channel names
    for i, channel in enumerate(pixels.channels):
        channel.name = channel_names[i]


# Specify the path to the multi-channel OME-TIFF file and the channel names
ome_tiff_path = sys.argv[1]
channel_names = list(sys.argv[2:])

try:
    # Read the OME from the OME-TIFF using ome-types
    ome_xml = read_ome_tiff(ome_tiff_path)

    # Add channel names to the OME-XML
    add_channel_names_to_ome_xml(ome_xml, channel_names)

    # Serialize the modified OME-XML
    ome_xml_str = str(ome_xml)

    print("Channel names added to OME-XML.")

except Exception as e:
    print(e)


set_list = [(tifftools.Tag.IMAGEDESCRIPTION, ome_types.to_xml(ome_xml))]

tifftools.tiff_set(ome_tiff_path, overwrite=True, setlist=set_list)
