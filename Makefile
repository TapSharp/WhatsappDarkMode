include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WhatsAppDarkMode
WhatsAppDarkMode_CFLAGS = -fobjc-arc
WhatsAppDarkMode_FILES = SpringBoard.xm Toggle.xm Tweak.xm Welcome.xm

BUNDLE_NAME = WhatsAppDarkModeAssets
WhatsAppDarkModeAssets_INSTALL_PATH = /Library/Application Support/WhatsAppDarkMode

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"

after-uninstall::
	install.exec "killall -9 SpringBoard"
