# nf-vectra-to-htan

This workflow takes `qptiff` files from Vectra miF images and outputs OME-TIFF 
images suitable for submission to the HTAN DCC with the Imaging Level 2 template.

It performs the following steps

- Converts the first series in the qptiff (the full resolution image) to OME-TIFF via `bioformats2raw` and `raw2ometiff`. Other images included in the qptiff (the `thumbnail`, `overview` and `label`) are discarded.
- Removes `AcquisitionDate` and `StructuredAnnotations` from the OME-XML
- Removes `DateTime` from the TIFF tags.

It outputs a tiled, pyramidal, single scene OME-TIFF file.

### Requirements

- [NextFlow](https://nextflow.io/)
- [Docker](https://docs.docker.com/engine/install/)

### Usage

```
nextflow run ncihtan/nf-vectra-to-htan --input <path-to-samplesheet>
```

### Inputs

Create a CSV samplesheet containing one column called `image`. for example:

```
image
path/to/myimage.qptiff
s3://mybucket/myimage.qptiff
```

### Outputs

By default this outputs into a new directory called `outputs` in your current working directory.

### Parameters

- `outdir`: Directory for outputs (default: "`outputs`")
- `suffix`: Suffix for output files (default: "`_htan`")

### Docker images

This workflow uses two existing Docker images that support other HTAN pipelines

- [nf-artist](https://github.com/Sage-Bionetworks-Workflows/nf-artist/pkgs/container/nf-artist): This image is used for the conversion step
- [nf-imagecleaner](https://github.com/ncihtan/nf-imagecleaner/pkgs/container/nf-imagecleaner/115612162?tag=latest): This image is used for the deidentification steps
