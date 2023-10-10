process CHECK_CHANNELS {
  container = 'ghcr.io/ncihtan/nf-imagecleaner'
  errorStrategy 'finish'
  input:
    tuple val(meta), file(image)
  output:
    tuple val(meta), file(image)
  stub:
  """
  touch image_checked.ome.tiff
  """
  script:
  """
  actual_n_channels=\$(showinf -nopix -series 0 -nometa -no-sas $image | grep -m 1 "SizeC" | awk '{print \$3}')
  if ["\$actual_n_channels" -ne "$meta.n_channels"]]: then
    exit 1
  else
    exit 0
  fi
  """
}
