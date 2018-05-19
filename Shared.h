#import <UIKit/UIKit.h>

static inline UIView* UA_UIViewWithColor(UIColor *color) {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

#define UA_rgba(r, g, b, a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:(float)a]
#define UA_rgb(r, g, b) UA_rgba(r, g, b, 1.0f)
#define UA_log( s, ... ) NSLog( @"BlvckLog: <%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )


#define UA_blvckColor [UIColor blackColor]
#define UA_blvckColor100 UA_rgb(10, 10, 10)
#define UA_blvckColor200 UA_rgb(20, 20, 20)
#define UA_blvckColor300 UA_rgb(30, 30, 30)
#define UA_grayColor UA_rgb(55, 55, 55)
#define UA_grayColor100 UA_rgb(77, 77, 77)
#define UA_grayColor200 UA_rgb(99, 99, 99)
#define UA_whiteColor [UIColor whiteColor]
#define UA_redColor [UIColor redColor]
#define UA_clearColor [UIColor clearColor]
#define UA_primaryColor UA_rgb(92, 161, 145)
#define UA_iPhoneBlueColor UA_rgb(0, 122, 255)


extern NSString *kWhatsappBundleIdentifier;
extern NSString *kWhatsappDarkModeBundleIdentifier;
extern NSString* kTwitterUsername;
extern NSString *kDefaultsFirstLaunchKey;


@interface NSUserDefaults (Tweak_Category)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end
