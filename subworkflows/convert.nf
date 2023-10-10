include { QPTIFF2OMETIFF } from '../modules/qptiff2ometiff.nf'

workflow CONVERT {
    take: images
    
    main:

    QPTIFF2OMETIFF( images )
    
    QPTIFF2OMETIFF.out
        .set { converted }

    emit: converted
}
