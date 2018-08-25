#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
sed -i 's|usr/bin/env |bin/|' run.sh.in &&
./configure --prefix=/usr \
            --disable-static \
            --docdir="$SHED_PKG_DOCS_INSTALL_DIR" &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    install -v -m644 doc/*.{html,png,css} "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}"
else
    rm -rf "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}"
fi
