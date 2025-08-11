#!/usr/bin/env bash
cd boringssl
cmake -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-35 \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_PATH}/build/cmake/android.toolchain.cmake \
    -DOPENSSL_SMALL=1 \
    -GNinja -B build
cmake --build build
cd ..
