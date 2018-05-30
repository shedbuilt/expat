#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_DOCDIR="/usr/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}"
# Configure
sed -i 's|usr/bin/env |bin/|' run.sh.in &&
./configure --prefix=/usr \
            --disable-static \
            --docdir="$SHED_PKG_LOCAL_DOCDIR" &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    install -v -m644 doc/*.{html,png,css} "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}"
else
    rm -rf "${SHED_FAKE_ROOT}/usr/share/doc"
fi
