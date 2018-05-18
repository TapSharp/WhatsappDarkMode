include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WhatsAppDarkMode
WhatsAppDarkMode_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WhatsApp"

after-uninstall::
	install.exec "killall -9 WhatsApp"
