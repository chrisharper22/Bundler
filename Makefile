TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = Bundler
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

XCODEPROJ_NAME = Bundler
Bundler_XCODE_SCHEME = Bundler
Bundler_CODESIGN_FLAGS = -SBundler.entitlements
Bundler_XCODE_PROJECT = Bundler.xcodeproj

include $(THEOS_MAKE_PATH)/xcodeproj.mk

dev::
	@open -a Xcode Bundler.xcodeproj
