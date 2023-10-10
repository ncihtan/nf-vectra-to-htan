include { SAMPLESHEET_SPLIT } from '../subworkflows/samplesheet_split.nf'
include { CONVERT } from '../subworkflows/convert.nf'
// include { GET_METADATA } from '../subworkflows/get_metadata.nf'
include { DEID } from '../subworkflows/deid.nf'

workflow VECTRA2HTAN {
    SAMPLESHEET_SPLIT ( params.input )
    CONVERT( SAMPLESHEET_SPLIT.out.images )
    CONVERT.out.converted.set{converted}
    // GET_METADATA( converted ) 
    DEID( converted )
}
