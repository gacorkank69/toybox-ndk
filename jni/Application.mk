APP_ABI := arm64-v8a
APP_PLATFORM := latest
APP_CFLAGS := -Wall -O2 -fomit-frame-pointer -flto
APP_CPPFLAGS := $(APP_CFLAGS) -std=c++23
APP_STL := c++_static
APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true
# Disable all security features
APP_CFLAGS += -fno-unwind-tables -fno-asynchronous-unwind-tables -fno-stack-protector -U_FORTIFY_SOURCE
APP_LDFLAGS := -flto -Wl,--icf=all

ifeq ($(OS),Windows_NT)
APP_SHORT_COMMANDS := true
endif
