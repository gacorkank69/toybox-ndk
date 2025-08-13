#!/usr/bin/env bash
cd boringssl

cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS="-O3 -pipe" \
    -DCMAKE_CXX_FLAGS="-O3 -pipe" \
    -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK_PATH}/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI=arm64-v8a \
    -DANDROID_PLATFORM=android-35 \
    -DOPENSSL_SMALL=1 \
    -GNinja -B build

cmake --build build
cd ..
