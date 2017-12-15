#!/bin/bash
./configure --prefix=/usr \
            --disable-static
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
install -v -dm755 ${SHED_FAKEROOT}/usr/share/doc/expat-2.2.3
install -v -m644 doc/*.{html,png,css} ${SHED_FAKEROOT}/usr/share/doc/expat-2.2.3
