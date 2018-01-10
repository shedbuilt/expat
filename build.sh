#!/bin/bash
sed -i 's|usr/bin/env |bin/|' run.sh.in
./configure --prefix=/usr \
            --disable-static || exit 1
make -j $SHED_NUMJOBS || exit 1
make DESTDIR="$SHED_FAKEROOT" install || exit 1
install -v -dm755 ${SHED_FAKEROOT}/usr/share/doc/expat-2.2.5
install -v -m644 doc/*.{html,png,css} ${SHED_FAKEROOT}/usr/share/doc/expat-2.2.5
