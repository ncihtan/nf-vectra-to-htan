process clean_tiff {
  tag {"$meta.id"}
  input:
    tuple val(meta), file(image)
  output:
    tuple val(meta), file('*.ome.tiff')
  publishDir "$params.outdir/", mode: 'copy', overwrite: true
  stub:
  """
  touch image_cleaned.ome.tiff
  """
  script:
  """
  clean_tiff.py $image --suffix "$params.suffix"
  """
}
