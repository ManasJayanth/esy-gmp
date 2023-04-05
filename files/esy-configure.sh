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
export PATH="/usr/x86_64-w64-mingw32/sys-root/mingw/bin:$PATH" # because mingw g++ fails the ./configure tests around certain flags
find ./ -exec touch -t 200905010101 {} + # because, other makeinfo is being looked up, which we'd like to avoid installing
./configure $CONFIGURE_ARGS
