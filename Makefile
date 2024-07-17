export TARGET = iphone:clang:latest:16.0
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard MediaRemoteUI

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MusicPlayerColor

MusicPlayerColor_FILES = Tweak.x
MusicPlayerColor_LIBRARIES = gcuniversal
MusicPlayerColor_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += musicplayercolorsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
