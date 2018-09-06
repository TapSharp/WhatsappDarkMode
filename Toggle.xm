#import "Toggle.h"

NSString* kDefaultsDarkModeEnabledKey = @"dark_mode_enabled";
NSString *kWhatsAppDarkModeBundlePath = @"/Library/Application Support/WhatsAppDarkMode/WhatsAppDarkModeAssets.bundle/";

%group WHATSAPP_DARK_MODE_TOGGLE
%hook WASettingsViewController
-(void)viewDidLoad {
    %orig;

    WATableSection *sectionSettings = MSHookIvar<WATableSection *>(self, "_sectionSettings");
    NSMutableArray *rows = [sectionSettings.rows mutableCopy];

    NSBundle *assets = [[NSBundle alloc] initWithPath:kWhatsAppDarkModeBundlePath];
    // UIImage *iconImage = [UIImage imageNamed:@"icon" inBundle:assets compatibleWithTraitCollection:nil];

    BOOL enabledLocally = [[[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsDarkModeEnabledKey
                                                                      inDomain:kWhatsappDarkModeBundleIdentifier] boolValue];

    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchView setOn:enabledLocally animated:NO];
    [switchView addTarget:self action:@selector(darkModeSwitchToggled:) forControlEvents:UIControlEventValueChanged];

    UITableViewCell *customCell = [%c(WATableSection) createCellWithStyle:0];
    customCell.textLabel.text = @"Dark Mode";
    customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    customCell.accessoryView = switchView;
    customCell.imageView.image = [UIImage imageNamed:@"enabled" inBundle:assets compatibleWithTraitCollection:nil];;
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:customCell] atIndex:0];

    UITableViewCell *customCell2 = [%c(WATableSection) createCellWithStyle:0];
    customCell2.textLabel.text = @"PayPal Donation";
    customCell2.selectionStyle = UITableViewCellSelectionStyleDefault;
    customCell2.imageView.image = [UIImage imageNamed:@"paypal" inBundle:assets compatibleWithTraitCollection:nil];
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:customCell2] atIndex:1];

    UITableViewCell *customCell3 = [%c(WATableSection) createCellWithStyle:0];
    customCell3.textLabel.text = @"Issues & Suggestions";
    customCell3.selectionStyle = UITableViewCellSelectionStyleDefault;
    customCell3.imageView.image = [UIImage imageNamed:@"SettingsTellFriendIcon"];
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:customCell3] atIndex:2];

    [sectionSettings setRows:rows];
}

- (NSIndexPath *)tableView:(UITableView *)tableView  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 1 && [cell.textLabel.text isEqualToString:@"PayPal Donation"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/oreogundipe"]];
    }

    if (indexPath.row == 2 && [cell.textLabel.text isEqualToString:@"Issues & Suggestions"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/neoighodaro"]];
    }

    return %orig;
}

%new
- (void)darkModeSwitchToggled:(id)sender {
    UISwitch *switchControl = sender;

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:switchControl.on]
                                              forKey:kDefaultsDarkModeEnabledKey
                                            inDomain:kWhatsappDarkModeBundleIdentifier];

    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Restart WhatsApp"
                                                                    message:@"You need to restart WhatsApp for your changes to take effect!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleCancel handler:nil]];
    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Restart"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
        NSString *notificationSuffix = switchControl.on ? @"/enabled" : @"/disabled";
        PostNotification((__bridge CFStringRef) [kWhatsappDarkModeBundleIdentifier stringByAppendingString:notificationSuffix]);
    }]];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
%end
%end


%ctor {
    BOOL featureNowWorks = YES;
    BOOL inWhatsAppApp = [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:kWhatsappBundleIdentifier] ||
        [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:kWhatsapp2BundleIdentifier] ||
        [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:kWhatsapp3BundleIdentifier];

    if (inWhatsAppApp == YES && featureNowWorks == YES) {
        %init(WHATSAPP_DARK_MODE_TOGGLE);
    }
}
