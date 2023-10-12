include { QPTIFF2OMETIFF } from '../modules/qptiff2ometiff.nf'
include { CHECK_CHANNELS } from '../modules/check_channels.nf'
include { ADD_CHANNEL_NAMES } from '../modules/add_channel_names.nf'


workflow CONVERT {
    take: images
    
    main:

    images | CHECK_CHANNELS | QPTIFF2OMETIFF | ADD_CHANNEL_NAMES | set { converted}

    emit: converted
}
