include { clean_ome } from "../modules/clean_ome.nf"
include { clean_tiff } from "../modules/clean_tiff.nf"


workflow DEID {
  take:
  images

  main:

  images | clean_ome | clean_tiff | set { cleaned }

  emit:
  cleaned
}
