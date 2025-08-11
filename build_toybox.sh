#!/usr/bin/env bash
source scripts/utils.sh

# handle error
set -e
exec 2>&1 > >(tee build.log)
trap 'send_file "$PWD/build.log"' ERR

# Setup path
export PATH="$ANDROID_NDK_PATH:$PATH"

# run setup.sh
./setup.sh
# build boringssl
./build_boringssl.sh
# build toybox
ndk-build -j$(nproc)

# check toybox binary
if [ ! -f "libs/arm64-v8a/toybox" ]; then
    abort "Toybox binary doesnt exist, check build.log"
fi

# build information
DATE=$(TZ=Asia/Makassar date +"%Y%m%d-%H%M")
COMMIT_HASH=$(git rev-parse --short HEAD)
VERSION_CODE=$(git rev-list HEAD --count)
TOYBOX_VER=$(grep -E '^#define TOYBOX_VERSION' ./toybox/toys.h | cut -d' ' -f3 | sed 's/"//g' | tr -d 'TOYBOX_VENDOR')
ZIP="toybox-$TOYBOX_VER-$COMMIT_HASH-$DATE.zip"

# change module properties
sed -i "s/version=.*/version=$TOYBOX_VER ($COMMIT_HASH-$DATE)/" module/module.prop
sed -i "s/versionCode=.*/versionCode=$VERSION_CODE/" module/module.prop

# copy toybox bin
cp -r ./libs module

# zip the module
cd module
zip -r9 "../$ZIP" *
cd ..

# upload files to telegram
send_file "$PWD/$ZIP"
send_file "$PWD/build.log"
