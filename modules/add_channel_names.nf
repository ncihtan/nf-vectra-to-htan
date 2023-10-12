process ADD_CHANNEL_NAMES {
  tag {"$meta.id"}
  input:
    tuple val(meta), file(image)
  output:
    tuple val(meta), file(image)
  stub:
  """
  touch image_named.ome.tiff
  """
  script:
  """
  add_channel_names.py $image $meta.channel_names
  """
}
