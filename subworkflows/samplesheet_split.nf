workflow SAMPLESHEET_SPLIT {
    take:
    samplesheet
    main:
    Channel
        .fromPath(samplesheet)
        .splitCsv (header:true, sep:',', quote: '\"')
        // Make meta map from the samplesheet
        .map { 
            row -> 
            def meta = [:]
            if (row.id ) {
                meta.id = row.id
            } else {
                meta.id = file(row.image).simpleName
            }
            image = file(row.image)
            if (row.channel_names) {
                meta.channel_names = row.channel_names.split(',')
                meta.n_channels = meta.channel_names.size()
            }
            [meta, image]
        }
        .set {images }

        images.view()
        
    emit: 
    images
}
