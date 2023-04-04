#! /bin/bash

CONFIGURE_FLAGS=("--prefix=$cur__install" "--enable-cxx" "--with-pic")

UNAME_M=$(uname -m)

ARCH="${UNAME_M%%*( )}"
OS=$(uname -s)

if [ "$OS" == "Darwin" ]
then
    CONFIGURE_FLAGS+=("--build=${ARCH}-apple-darwin$(uname -r)")
fi

case "$(uname -s)" in
    CYGWIN*|MINGW32*|MSYS*)
       CONFIGURE_FLAGS+=("--host x86_64-w64-mingw32")
     ;;
    *)
	true
        ;;
esac

CONFIGURE_ARGS=$(printf '%s ' "${CONFIGURE_FLAGS[@]}")
./configure $CONFIGURE_ARGS
