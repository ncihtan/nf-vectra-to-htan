process QPTIFF2OMETIFF {
  tag {"$meta.id"}
  label "process_medium"
  input:
      tuple val(meta), file(image) 
  output:
      tuple val(meta), file("${image.simpleName}.ome.tiff")
  stub:
  """
  touch raw_dir
  touch "${image.simpleName}.ome.tiff"
  """
  script:
  """
  bioformats2raw $image 'raw_dir' -s 0 
  raw2ometiff 'raw_dir' "${image.simpleName}.ome.tiff"
  """
}
