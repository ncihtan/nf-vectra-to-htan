process CHECK_CHANNELS {
  tag {"$meta.id"}
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
  if [ "\$actual_n_channels" = "$meta.n_channels" ]
  then
    echo "FAILURE for $image:
    Actual channels in image (\${actual_n_channels})
    IS EQUAL TO number of channel names provided in samplesheet ($meta.n_channels)"
    exit 0
  else
    echo "FAILURE for $image:
    Actual channels in image (\${actual_n_channels})
    NOT EQUAL TO number of channel names provided in samplesheet ($meta.n_channels)"
    exit 1
  fi
  """
}
