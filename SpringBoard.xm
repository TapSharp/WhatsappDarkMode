#import "Shared.h"
#include <spawn.h>

void RestartWhatsApp() {
	pid_t pid;
	int status;
	const char* args[] = {"killall", "-9", "WhatsApp", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char*   const*)args, NULL);
	waitpid(pid, &status, WEXITED);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    	[[UIApplication sharedApplication] launchApplicationWithIdentifier:kWhatsappBundleIdentifier suspended:NO];
    });
}

void WASettingsChanged(CFNotificationCenterRef center, void * observer, CFStringRef name, const void * object, CFDictionaryRef userInfo) {
    [[UIApplication sharedApplication] _simulateHomeButtonPress];
    RestartWhatsApp();
}

%hook SBRootFolderController
-(void)viewDidLoad {
    %orig;
    AddObserver((__bridge CFStringRef) [kWhatsappDarkModeBundleIdentifier stringByAppendingString:@"/enabled"], WASettingsChanged);
    AddObserver((__bridge CFStringRef) [kWhatsappDarkModeBundleIdentifier stringByAppendingString:@"/disabled"], WASettingsChanged);
}
%end
