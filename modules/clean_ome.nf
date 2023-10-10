process clean_ome {
  container = 'ghcr.io/ncihtan/nf-imagecleaner'
  input:
    tuple val(meta), file(image)
  output:
    tuple val(meta), file(image)
  stub:
  """
  touch image_cleaned.ome.tiff
  """
  script:
  """
  clean_ometiff.py $image
  """
}
