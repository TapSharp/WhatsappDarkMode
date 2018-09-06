#import "Toggle.h"

NSString* kDefaultsDarkModeEnabledKey = @"dark_mode_enabled";
NSString* kDefaultsDarkModeAutoEnabledKey = @"dark_mode_auto_enabled";
NSString *kWhatsAppDarkModeBundlePath = @"/Library/Application Support/WhatsAppDarkMode/WhatsAppDarkModeAssets.bundle/";

%group WHATSAPP_DARK_MODE_TOGGLE
%hook WASettingsViewController
-(void)viewDidLoad {
    %orig;

    WATableSection *sectionSettings = MSHookIvar<WATableSection *>(self, "_sectionSettings");
    NSMutableArray *rows = [sectionSettings.rows mutableCopy];

    NSBundle *assets = [[NSBundle alloc] initWithPath:kWhatsAppDarkModeBundlePath];
    // UIImage *iconImage = [UIImage imageNamed:@"icon" inBundle:assets compatibleWithTraitCollection:nil];

    BOOL enabled = [[[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsDarkModeEnabledKey
                                                               inDomain:kWhatsappDarkModeBundleIdentifier] boolValue];

    UISwitch *enabledSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [enabledSwitch setOn:enabled animated:NO];
    [enabledSwitch addTarget:self action:@selector(darkModeSwitchToggled:) forControlEvents:UIControlEventValueChanged];

    UITableViewCell *enabledCell = [%c(WATableSection) createCellWithStyle:0];
    enabledCell.textLabel.text = @"Dark Mode";
    enabledCell.selectionStyle = UITableViewCellSelectionStyleNone;
    enabledCell.accessoryView = enabledSwitch;
    enabledCell.imageView.image = [UIImage imageNamed:@"enabled" inBundle:assets compatibleWithTraitCollection:nil];;
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:enabledCell] atIndex:0];

    BOOL autoEnabled = [[[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsDarkModeAutoEnabledKey
                                                                   inDomain:kWhatsappDarkModeBundleIdentifier] boolValue];

    UISwitch *autoEnabledSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [autoEnabledSwitch setOn:autoEnabled animated:NO];
    [autoEnabledSwitch addTarget:self action:@selector(autoDarkModeSwitchToggled:) forControlEvents:UIControlEventValueChanged];

    UITableViewCell *autoSwitchCell = [%c(WATableSection) createCellWithStyle:0];
    autoSwitchCell.textLabel.text = @"Automatically Enable";
    autoSwitchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    autoSwitchCell.accessoryView = autoEnabledSwitch;
    autoSwitchCell.imageView.image = [UIImage imageNamed:@"enabled" inBundle:assets compatibleWithTraitCollection:nil];;
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:autoSwitchCell] atIndex:1];

    UITableViewCell *customCell2 = [%c(WATableSection) createCellWithStyle:0];
    customCell2.textLabel.text = @"PayPal Donation";
    customCell2.selectionStyle = UITableViewCellSelectionStyleDefault;
    customCell2.imageView.image = [UIImage imageNamed:@"paypal" inBundle:assets compatibleWithTraitCollection:nil];
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:customCell2] atIndex:2];

    UITableViewCell *customCell3 = [%c(WATableSection) createCellWithStyle:0];
    customCell3.textLabel.text = @"Issues & Suggestions";
    customCell3.selectionStyle = UITableViewCellSelectionStyleDefault;
    customCell3.imageView.image = [UIImage imageNamed:@"SettingsTellFriendIcon"];
    [rows insertObject:[[%c(WATableRow) alloc] initWithCell:customCell3] atIndex:3];

    [sectionSettings setRows:rows];
}

- (NSIndexPath *)tableView:(UITableView *)tableView  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.row == 2 && [cell.textLabel.text isEqualToString:@"PayPal Donation"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/oreogundipe"]];
    }

    if (indexPath.row == 3 && [cell.textLabel.text isEqualToString:@"Issues & Suggestions"]) {
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

    UIAlertController *alertCtrl = [self restartAlert:switchControl.on];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

%new
- (void)autoDarkModeSwitchToggled:(id)sender {
    UISwitch *switchControl = sender;

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:switchControl.on]
                                              forKey:kDefaultsDarkModeAutoEnabledKey
                                            inDomain:kWhatsappDarkModeBundleIdentifier];

    UIAlertController *alertCtrl = [self restartAlert:switchControl.on];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

%new
- (UIAlertController*)restartAlert:(BOOL)enabled {
    UIAlertController* alertCtrl = [UIAlertController alertControllerWithTitle:@"Restart WhatsApp"
                                                                       message:@"You need to restart WhatsApp for your changes to take effect!"
                                                                preferredStyle:UIAlertControllerStyleAlert];

    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleCancel handler:nil]];

    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"Restart"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
        NSString *suffix = enabled ? @"/enabled" : @"/disabled";
        PostNotification((__bridge CFStringRef) [kWhatsappDarkModeBundleIdentifier stringByAppendingString:suffix]);
    }]];

    return alertCtrl;
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
