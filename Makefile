TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


THEOS_DEVICE_IP= root@localhost
THEOS_DEVICE_PORT=2222

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RED

RED_FILES = Tweak.xm
RED_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

RED_FRAMEWORKS = UIKit
