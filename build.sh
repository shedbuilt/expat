#!/bin/bash
sed -i 's|usr/bin/env |bin/|' run.sh.in
./configure --prefix=/usr \
            --disable-static || exit 1
make -j $SHED_NUM_JOBS || exit 1
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
install -v -dm755 ${SHED_FAKE_ROOT}/usr/share/doc/expat-2.2.5
install -v -m644 doc/*.{html,png,css} ${SHED_FAKE_ROOT}/usr/share/doc/expat-2.2.5
