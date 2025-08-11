APP_ABI := arm64-v8a
APP_PLATFORM := latest

APP_CFLAGS := \
    -Wall -Oz -flto \
    -ffunction-sections -fdata-sections \
    -fno-unwind-tables -fno-asynchronous-unwind-tables \
    -fno-stack-protector -U_FORTIFY_SOURCE

APP_CPPFLAGS := $(APP_CFLAGS) -std=c++23
APP_STL := c++_static

APP_LDFLAGS := \
    -flto \
    -Wl,--gc-sections \
    -Wl,--icf=all \
    -Wl,--strip-all
