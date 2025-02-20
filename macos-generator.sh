#!/bin/sh
###################################
#
# App Icon Generator v0.0.1
#
# Andrey A. Ugolnik
# https://www.ugolnik.info
# andrey@ugolnik.info
#
###################################

set -e

SRC_FILE="$1"
DST_PATH="$2"

info() {
    local green="\033[1;32m"
    local normal="\033[0m"
    echo -e "[${green}INFO${normal}] $1"
}

error() {
    local red="\033[1;31m"
    local normal="\033[0m"
    echo -e "[${red}ERROR${normal}] $1"
}

usage() {
    cat <<EOF
USAGE:
    $0 SourceIcon DestPath

DESCRIPTION:
    This script aim to generate Android TV app icons easier and simply.

    SourceIcon   - The source png Icon. Preferably above 1024x1024.
    DestPath     - The destination Path where the icons and banners generate to.

    This script is depend on ImageMagick. So you must install ImageMagick first
    You can use 'brew install ImageMagick' to install it

EXAMPLE:
    $0 Icon.png Output/
EOF
}

# Check ImageMagick
command -v magick >/dev/null 2>&1 || {
    error >&2 "The ImageMagick is not installed. Please use brew to install it first."
    exit -1
}

# Check param
if [ $# != 2 ]; then
    usage
    exit -1
fi

# Check dst path whether exist.
if [ ! -d "$DST_PATH" ]; then
    mkdir -p "$DST_PATH"
fi

magick "$SRC_FILE" -resize !512x512 "$DST_PATH/icon_512x512.png"
magick "$SRC_FILE" -resize !1024x1024 "$DST_PATH/icon_512x512@2x.png"

magick "$SRC_FILE" -resize !256x256 "$DST_PATH/icon_256x256.png"
magick "$SRC_FILE" -resize !512x512 "$DST_PATH/icon_256x256@2x.png"

magick "$SRC_FILE" -resize !128x128 "$DST_PATH/icon_128x128.png"
magick "$SRC_FILE" -resize !256x256 "$DST_PATH/icon_128x128@2x.png"

magick "$SRC_FILE" -resize !32x32 "$DST_PATH/icon_32x32.png"
magick "$SRC_FILE" -resize !64x64 "$DST_PATH/icon_32x32@2x.png"

magick "$SRC_FILE" -resize !16x16 "$DST_PATH/icon_16x16.png"
magick "$SRC_FILE" -resize !32x32 "$DST_PATH/icon_16x16@2x.png"

info 'Generate Done.'
