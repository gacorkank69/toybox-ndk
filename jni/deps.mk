LOCAL_PATH := $(call my-dir)

# libselinux.a
include $(CLEAR_VARS)
LOCAL_MODULE := libselinux
LOCAL_C_INCLUDES := $(LOCAL_PATH)/selinux/libselinux/src $(LOCAL_PATH)/selinux/libselinux/include $(LOCAL_PATH)/core/libcutils/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/selinux/libselinux/include $(LOCAL_PATH)/core/libcutils/include
LOCAL_STATIC_LIBRARIES := libpcre2 liblog libpackagelistparser
LOCAL_CFLAGS := \
    -Wno-implicit-function-declaration -Wno-int-conversion -Wno-unused-function \
    -Wno-macro-redefined -Wno-unused-but-set-variable -D_GNU_SOURCE -DUSE_PCRE2 \
    -DNO_PERSISTENTLY_STORED_PATTERNS -DDISABLE_SETRANS -DDISABLE_BOOL \
    -DNO_MEDIA_BACKEND -DNO_X_BACKEND -DNO_DB_BACKEND -DHAVE_STRLCPY -DHAVE_REALLOCARRAY \
    -Dfgets_unlocked=fgets -D'__fsetlocking(...)=' -DAUDITD_LOG_TAG=1003
LOCAL_SRC_FILES := \
    selinux/libselinux/src/android/android_device.c \
    selinux/libselinux/src/android/android.c \
    selinux/libselinux/src/android/android_seapp.c \
    selinux/libselinux/src/avc.c \
    selinux/libselinux/src/avc_internal.c \
    selinux/libselinux/src/avc_sidtab.c \
    selinux/libselinux/src/booleans.c \
    selinux/libselinux/src/callbacks.c \
    selinux/libselinux/src/canonicalize_context.c \
    selinux/libselinux/src/checkAccess.c \
    selinux/libselinux/src/check_context.c \
    selinux/libselinux/src/compute_av.c \
    selinux/libselinux/src/compute_create.c \
    selinux/libselinux/src/compute_member.c \
    selinux/libselinux/src/context.c \
    selinux/libselinux/src/deny_unknown.c \
    selinux/libselinux/src/disable.c \
    selinux/libselinux/src/enabled.c \
    selinux/libselinux/src/fgetfilecon.c \
    selinux/libselinux/src/freecon.c \
    selinux/libselinux/src/fsetfilecon.c \
    selinux/libselinux/src/get_initial_context.c \
    selinux/libselinux/src/getenforce.c \
    selinux/libselinux/src/getfilecon.c \
    selinux/libselinux/src/getpeercon.c \
    selinux/libselinux/src/hashtab.c \
    selinux/libselinux/src/init.c \
    selinux/libselinux/src/label.c \
    selinux/libselinux/src/label_backends_android.c \
    selinux/libselinux/src/label_file.c \
    selinux/libselinux/src/label_support.c \
    selinux/libselinux/src/lgetfilecon.c \
    selinux/libselinux/src/load_policy.c \
    selinux/libselinux/src/lsetfilecon.c \
    selinux/libselinux/src/mapping.c \
    selinux/libselinux/src/matchpathcon.c \
    selinux/libselinux/src/policyvers.c \
    selinux/libselinux/src/procattr.c \
    selinux/libselinux/src/regex.c \
    selinux/libselinux/src/reject_unknown.c \
    selinux/libselinux/src/selinux_internal.c \
    selinux/libselinux/src/sestatus.c \
    selinux/libselinux/src/setenforce.c \
    selinux/libselinux/src/setfilecon.c \
    selinux/libselinux/src/setrans_client.c \
    selinux/libselinux/src/sha1.c \
    selinux/libselinux/src/stringrep.c

include $(BUILD_STATIC_LIBRARY)

# libpcre2.a
include $(CLEAR_VARS)
LOCAL_MODULE := libpcre2
LOCAL_CFLAGS := -DHAVE_CONFIG_H -DPCRE2_CODE_UNIT_WIDTH=8
LOCAL_C_INCLUDES := $(LOCAL_PATH)/pcre/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := \
    pcre/src/pcre2_auto_possess.c \
    pcre/src/pcre2_chartables.c \
    pcre/src/pcre2_chkdint.c \
    pcre/src/pcre2_compile.c \
    pcre/src/pcre2_config.c \
    pcre/src/pcre2_context.c \
    pcre/src/pcre2_convert.c \
    pcre/src/pcre2_dfa_match.c \
    pcre/src/pcre2_error.c \
    pcre/src/pcre2_extuni.c \
    pcre/src/pcre2_find_bracket.c \
    pcre/src/pcre2_jit_compile.c \
    pcre/src/pcre2_maketables.c \
    pcre/src/pcre2_match_data.c \
    pcre/src/pcre2_match.c \
    pcre/src/pcre2_newline.c \
    pcre/src/pcre2_ord2utf.c \
    pcre/src/pcre2_pattern_info.c \
    pcre/src/pcre2_script_run.c \
    pcre/src/pcre2_serialize.c \
    pcre/src/pcre2_string_utils.c \
    pcre/src/pcre2_study.c \
    pcre/src/pcre2_substitute.c \
    pcre/src/pcre2_substring.c \
    pcre/src/pcre2_tables.c \
    pcre/src/pcre2_ucd.c \
    pcre/src/pcre2_valid_utf.c \
    pcre/src/pcre2_xclass.c
include $(BUILD_STATIC_LIBRARY)

# libz.a
include $(CLEAR_VARS)
LOCAL_MODULE := libz
LOCAL_CFLAGS := \
    -DHAVE_HIDDEN \
    -DZLIB_CONST \
    -DCHROMIUM_ZLIB_NO_CASTAGNOLI \
    -DADLER32_SIMD_NEON \
    -DCRC32_ARMV8_CRC32 \
    -DINFLATE_CHUNK_READ_64LE \
    -DARMV8_OS_LINUX
LOCAL_C_INCLUDES := $(LOCAL_PATH)/zlib
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := \
    zlib/adler32.c \
    zlib/adler32_simd.c \
    zlib/compress.c \
    zlib/cpu_features.c \
    zlib/crc32.c \
    zlib/crc32_simd.c \
    zlib/crc_folding.c \
    zlib/deflate.c \
    zlib/gzclose.c \
    zlib/gzlib.c \
    zlib/gzread.c \
    zlib/gzwrite.c \
    zlib/infback.c \
    zlib/inffast.c \
    zlib/inflate.c \
    zlib/inftrees.c \
    zlib/trees.c \
    zlib/uncompr.c \
    zlib/zutil.c
include $(BUILD_STATIC_LIBRARY)

# libpackagelistparser.a
include $(CLEAR_VARS)
LOCAL_MODULE := libpackagelistparser
LOCAL_C_INCLUDES := $(LOCAL_PATH)/core/libpackagelistparser/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_STATIC_LIBRARIES := liblog
LOCAL_SRC_FILES := core/libpackagelistparser/packagelistparser.cpp
include $(BUILD_STATIC_LIBRARY)

# liblog.a
include $(CLEAR_VARS)
LOCAL_MODULE := liblog
LOCAL_CPPFLAGS := -DLIBLOG_LOG_TAG=1006 -DSNET_EVENT_LOG_TAG=1397638484 -DANDROID_DEBUGGABLE=0 -DWexit-time-destructors
LOCAL_C_INCLUDES := $(LOCAL_PATH)/logging/liblog/include $(LOCAL_PATH)/core/libcutils/include $(LOCAL_PATH)/core/libutils/include $(LOCAL_PATH)/core/libsystem/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_STATIC_LIBRARIES := libbase
LOCAL_SRC_FILES := \
    logging/liblog/log_event_list.cpp \
    logging/liblog/log_event_write.cpp \
    logging/liblog/logger_name.cpp \
    logging/liblog/logger_read.cpp \
    logging/liblog/logger_write.cpp \
    logging/liblog/logprint.cpp \
    logging/liblog/properties.cpp \
    logging/liblog/event_tag_map.cpp \
    logging/liblog/log_time.cpp \
    logging/liblog/pmsg_reader.cpp \
    logging/liblog/pmsg_writer.cpp \
    logging/liblog/logd_reader.cpp \
    logging/liblog/logd_writer.cpp
include $(BUILD_STATIC_LIBRARY)

# libbase.a
include $(CLEAR_VARS)
LOCAL_MODULE := libbase
LOCAL_CPPFLAGS := -D_FILE_OFFSET_BITS=64
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libbase/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_STATIC_LIBRARIES := libfmt
LOCAL_SRC_FILES := \
    libbase/abi_compatibility.cpp \
    libbase/chrono_utils.cpp \
    libbase/cmsg.cpp \
    libbase/file.cpp \
    libbase/hex.cpp \
    libbase/logging.cpp \
    libbase/mapped_file.cpp \
    libbase/parsebool.cpp \
    libbase/parsenetaddress.cpp \
    libbase/posix_strerror_r.cpp \
    libbase/process.cpp \
    libbase/properties.cpp \
    libbase/result.cpp \
    libbase/stringprintf.cpp \
    libbase/strings.cpp \
    libbase/threads.cpp \
    libbase/test_utils.cpp
include $(BUILD_STATIC_LIBRARY)

# libfmt.a
include $(CLEAR_VARS)
LOCAL_MODULE := libfmt
LOCAL_CPPFLAGS := -UNDEBUG
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libfmt/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := libfmt/src/format.cc
include $(BUILD_STATIC_LIBRARY)

# libcrypto.a
include $(CLEAR_VARS)
LOCAL_MODULE := libcrypto
LOCAL_EXPORT_C_INCLUDES := BORINGSSL_PATH/include
LOCAL_SRC_FILES := BORINGSSL_PATH/build/libcrypto.a
include $(PREBUILT_STATIC_LIBRARY)
