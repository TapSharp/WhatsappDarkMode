#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ClearColor [UIColor clearColor]
#define BlackColor [UIColor blackColor]
#define WhiteColor [UIColor whiteColor]
#define GrayColor RGBA(255.0f, 255.0f, 255.0f, 0.5f)
#define DarkGrayColor RGBA(20.0f, 20.0f, 20.0f, 1.0f)
#define TintColor RGBA(0.0f, 122.0f, 255.0f, 1.0f)

// --------------------------------------------------------------------
// Global Headers
// --------------------------------------------------------------------

@interface LSApplicationProxy
- (id)_initWithBundleUnit:(NSUInteger)arg1 applicationIdentifier:(NSString *)arg2;
+ (id)applicationProxyForIdentifier:(NSString *)arg1;
+ (id)applicationProxyForBundleURL:(NSURL *)arg1;
@end

@interface FBApplicationInfo : NSObject
- (NSURL *)dataContainerURL;
- (NSURL *)bundleURL;
- (NSString *)bundleIdentifier;
- (NSString *)bundleType;
- (NSString *)bundleVersion;
- (NSString *)displayName;
- (id)initWithApplicationProxy:(id)arg1;
@end
