export THEOS_DEVICE_IP = 192.168.3.18
INSTALL_TARGET_PROCESSES = SpringBoard

ifeq ($(ROOTLESS),1)
THEOS_PACKAGE_SCHEME=rootless
endif

ifeq ($(THEOS_PACKAGE_SCHEME), rootless)
TARGET = iphone:clang:latest:15.0
else
TARGET = iphone:clang:latest:14.0
endif

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RecorderBubble
MY_Bridging_Header = -include Sources/$(TWEAK_NAME)C/include/Tweak.h

$(TWEAK_NAME)_FILES = $(shell find Sources/$(TWEAK_NAME) -name '*.swift') $(shell find Sources/$(TWEAK_NAME)C -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = SpringBoard ReplayKit
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/$(TWEAK_NAME)C/include
$(TWEAK_NAME)_CFLAGS += -fobjc-arc -ISources/$(TWEAK_NAME)C/include $(MY_Bridging_Header)

include $(THEOS_MAKE_PATH)/tweak.mk
