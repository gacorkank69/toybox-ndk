#!/usr/bin/env bash
source scripts/utils.sh

progress() {
    echo ">> $*"
}

check() {
    local dir="$1"
    local git_clone_args="$2"
    [ "$args" == "--cleanup" ] && rm -rf "$dir" && return 0
    [ -d "$dir" ] && git -C "$dir" pull || git clone --depth=1 $git_clone_args
}

export args="$1"

if [ ! -f toybox.mk ]; then
    abort "toybox.mk doesn't exist in current directory"
fi

# check dependencies
check "toybox" "https://android.googlesource.com/platform/external/toybox toybox"
check "boringssl" "https://boringssl.googlesource.com/boringssl boringssl"
check "jni/pcre" "https://android.googlesource.com/platform/external/pcre jni/pcre"
check "jni/selinux" "https://android.googlesource.com/platform/external/selinux jni/selinux"
check "jni/zlib" "https://android.googlesource.com/platform/external/zlib jni/zlib"
check "jni/logging" "https://android.googlesource.com/platform/system/logging jni/logging"
check "jni/core" "https://android.googlesource.com/platform/system/core jni/core"
check "jni/libbase" "https://android.googlesource.com/platform/system/libbase jni/libbase"
check "jni/libfmt" "https://android.googlesource.com/platform/external/fmtlib jni/libfmt"

if [ "$args" == "--cleanup" ]; then
    rm -rf obj libs
    exit 0
fi

# patch
sed -i "s|pcre.h|pcre2.h|g" jni/selinux/libselinux/src/regex.h
sed -i "s|37|30|g" jni/logging/liblog/include/android/log.h
sed -i "s|BORINGSSL_PATH|$PWD/boringssl|g" jni/deps.mk
for h in jni/selinux/libselinux/src/*.h; do
    cp $h jni/selinux/libselinux/src/android
done

# copy toybox.mk
cp toybox.mk toybox/Android.mk || progress "Failed to copy toybox.mk"
