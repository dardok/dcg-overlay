#!/usr/bin/env bash

case ${CATEGORY}/${PN} in
    app-emulation/libcacard)
        export LIBS="-lpthread"
        ;;
    sys-cluster/ceph)
        export LIBZFS_CFLAGS="-I/usr/include/libzfs -I/usr/include/libspl"
        ;;
esac

