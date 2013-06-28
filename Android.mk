LOCAL_PATH := $(call my-dir)
LIBAV_PATH := $(LOCAL_PATH)

ifeq ($(TARGET_ARCH),arm)
        ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
		LIBAV_CONFIG := Android_config
        else
		LIBAV_CONFIG := Android_config_no_neon
        endif
else
	LIBAV_CONFIG := Android_config_$(TARGET_ARCH)
endif

include $(LIBAV_PATH)/libavcodec/Android.mk
#include $(LIBAV_PATH)/libswscale/Android.mk
include $(LIBAV_PATH)/libavutil/Android.mk
#include $(LIBAV_PATH)/libavfilter/Android.mk
include $(LIBAV_PATH)/libavformat/Android.mk
#include $(LIBAV_PATH)/libavresample/Android.mk
