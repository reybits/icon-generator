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

# magick "$SRC_FILE" -resize 512x512 "$DST_PATH/iTunesArtwork.png"
magick "$SRC_FILE" -resize !1024x1024 "$DST_PATH/iTunesArtwork@2x.png"

magick "$SRC_FILE" -resize !20x20 "$DST_PATH/Icon-20.png"
magick "$SRC_FILE" -resize !40x40 "$DST_PATH/Icon-20@2x.png"
magick "$SRC_FILE" -resize !60x60 "$DST_PATH/Icon-20@3x.png"

magick "$SRC_FILE" -resize !29x29 "$DST_PATH/Icon-29.png"
magick "$SRC_FILE" -resize !58x58 "$DST_PATH/Icon-29@2x.png"
magick "$SRC_FILE" -resize !87x87 "$DST_PATH/Icon-29@3x.png"

magick "$SRC_FILE" -resize !40x40 "$DST_PATH/Icon-40.png"
magick "$SRC_FILE" -resize !80x80 "$DST_PATH/Icon-40@2x.png"
magick "$SRC_FILE" -resize !120x120 "$DST_PATH/Icon-40@3x.png"

# magick "$SRC_FILE" -resize !60x60 "$DST_PATH/Icon-60.png"
magick "$SRC_FILE" -resize !120x120 "$DST_PATH/Icon-60@2x.png"
magick "$SRC_FILE" -resize !180x180 "$DST_PATH/Icon-60@3x.png"

magick "$SRC_FILE" -resize !76x76 "$DST_PATH/Icon-76.png"
magick "$SRC_FILE" -resize !152x152 "$DST_PATH/Icon-76@2x.png"

# magick "$SRC_FILE" -resize !57x57 "$DST_PATH/Icon-57.png"
# magick "$SRC_FILE" -resize !114x114 "$DST_PATH/Icon-57@2x.png"

magick "$SRC_FILE" -resize !167x167 "$DST_PATH/Icon-83.5@2x.png"

# magick "$SRC_FILE" -resize !72x72 "$DST_PATH/Icon-72.png"
# magick "$SRC_FILE" -resize !144x144 "$DST_PATH/Icon-72@2x.png"

# magick "$SRC_FILE" -resize !50x50 "$DST_PATH/Icon-50.png"
# magick "$SRC_FILE" -resize !100x100 "$DST_PATH/Icon-50@2x.png"

info 'iOS icons ready.'
