include { QPTIFF2OMETIFF } from '../modules/qptiff2ometiff.nf'
include { CHECK_CHANNELS } from '../modules/check_channels.nf'


workflow CONVERT {
    take: images
    
    main:

    CHECK_CHANNELS ( images )

    QPTIFF2OMETIFF( CHECK_CHANNELS.out )
    
    QPTIFF2OMETIFF.out
        .set { converted }

    emit: converted
}
