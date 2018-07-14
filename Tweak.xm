#import "Tweak.h"

NSString *kWhatsappBundleIdentifier = @"net.whatsapp.WhatsApp";

%group BLVCK_WHATSAPP_UIKIT
%hook UINavigationController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    %orig;
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName: UA_whiteColor};

    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = UA_blvckColor;
    self.toolbar.barTintColor = UA_blvckColor;
    self.toolbar.barStyle = UIBarStyleBlack;
    [self.navigationBar setTitleTextAttributes:titleAttributes];

    if (@available(iOS 11.0, *)) {
        [self.navigationBar setLargeTitleTextAttributes:titleAttributes];
    }
}
%end

%hook UITableViewController
-(void) viewDidLoad {
    %orig;
    self.view.backgroundColor = UA_blvckColor;
    self.tableView.backgroundColor = UA_blvckColor;
}
%end

%hook _UIBarBackground
-(void)layoutSubviews {
    %orig;
    UIVisualEffectView* _backgroundEffectView = MSHookIvar<UIVisualEffectView *>(self, "_backgroundEffectView");
    _backgroundEffectView.hidden = YES;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook UITableView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
%end

%hook UITableViewCell
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
    self.textLabel.textColor = UA_whiteColor;

    UIColor *selectedColor = UA_blvckColor200;
	[self setSelectedBackgroundView: UA_UIViewWithColor(selectedColor)];

    // @TODO: Verify in use
    // UITextField *textField = MSHookIvar<UITextField *>(self, "_editableTextField");
    // textField.textColor = UA_whiteColor;
}
%end

%hook UITableViewHeaderFooterView
-(void)layoutSubviews {
    %orig;
    self.backgroundView.backgroundColor = UA_blvckColor;
}
%end

%hook UISearchBar
-(void)layoutSubviews {
    %orig;
    UISearchBarTextField *textField = MSHookIvar<UISearchBarTextField *>(self, "_searchField");
    textField.backgroundColor = UA_blvckColor;

    UIView *bg = MSHookIvar<UIView *>(self, "_background");
    bg.hidden = YES;
}
-(UITextField *)searchField {
    UITextField* field = %orig;
    field.textColor = UA_whiteColor;
    return field;
}
%end

%hook UITabBar
- (void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook UITextView
-(void)layoutSubviews {
    %orig;
    self.keyboardAppearance = UIKeyboardAppearanceDark;
}
%end
%end

%group BLVCK_WHATSAPP_WATUSI
%hook FRFavoriteTableViewCell
-(void)layoutSubviews {
    %orig;
    self.textLabel.textColor = UA_whiteColor;
    self.detailTextLabel.textColor = UA_grayColor200;
}
%end
%end

%group BLVCK_WHATSAPP_VIEWS
%hook WAAutoscrollingLabel
- (void)layoutSubviews {
    %orig;
    self.textColor = UA_grayColor200;
}
%end

%hook WANoChatsView
- (void)layoutSubviews {
    %orig;

    UILabel* _textLabel = MSHookIvar<UILabel *>(self, "_textLabel");
    _textLabel.textColor = UA_whiteColor;
}
%end

%hook WALabel
- (void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
    // self.backgroundColor = UA_clearColor;
}
%end

%hook WABadgedLabel
-(void)layoutSubviews {
    %orig;
    self.color = UA_whiteColor;
    self.backgroundColor = UA_clearColor;
}
%end

%hook WAGroupedTableSectionHeaderView
-(void)layoutSubviews {
    %orig;
    UIView* backgroundView = MSHookIvar<UIView*>(self, "_backgroundView");
    backgroundView.backgroundColor = UA_blvckColor;
}
%end

%hook STUpdateTableViewCell
-(void)layoutSubviews {
    %orig;
    self.contactNameLabel.textColor = UA_whiteColor;
}
%end

%hook STUpdateHeaderView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
    self.nameLabel.textColor = UA_whiteColor;
    self.statusLabel.textColor = UA_whiteColor;
    self.singleNameLabel.textColor = UA_whiteColor;
}
%end

%hook WAStatusTextView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WAStatusChatSessionCell
-(void)layoutSubviews {
    %orig;
	[self setSelectedBackgroundView: UA_UIViewWithColor(UA_blvckColor100)];
    UILabel* subtitle = MSHookIvar<UILabel*>(self, "_subtitleLabel");
    subtitle.backgroundColor = UA_clearColor;
}
%end

%hook WAStatusScrollView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WAStatusViewerRecipientCell
-(void)layoutSubviews {
    %orig;
    UILabel* dateLabel = MSHookIvar<UILabel*>(self, "_dateLabel");
    UILabel* timeLabel = MSHookIvar<UILabel*>(self, "_timeLabel");
    UILabel* nameLabel = MSHookIvar<UILabel*>(self, "_nameLabel");

    dateLabel.textColor = UA_grayColor200;
    dateLabel.backgroundColor = UA_clearColor;
    timeLabel.textColor = UA_grayColor200;
    timeLabel.backgroundColor = UA_clearColor;
    nameLabel.textColor = UA_whiteColor;
    nameLabel.backgroundColor = UA_clearColor;

	[self setSelectedBackgroundView: UA_UIViewWithColor(UA_blvckColor)];
}
%end

%hook WAStatusViewerSeenByView
-(void)layoutSubviews {
    %orig;
    UILabel *headerLabel = MSHookIvar<UILabel*>(self, "_headerLabel");
    UIView* backgroundView = MSHookIvar<UIView*>(self, "_backgroundView");
    headerLabel.textColor = UA_whiteColor;
    backgroundView.backgroundColor = UA_blvckColor;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WAChatSessionCell
- (void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
	[self setSelectedBackgroundView: UA_UIViewWithColor(UA_blvckColor100)];

    self.senderLabel.textColor = UA_whiteColor;
    self.timeLabel.backgroundColor = UA_clearColor;
    self.nameLabel.color = UA_whiteColor;
    self.nameLabel.backgroundColor = UA_clearColor;
    self.activityLabel.backgroundColor = UA_clearColor;

    self.indicatorsView.highlighted = YES;

    UIImageView *_pinIndicator = MSHookIvar<UIImageView *>(self.indicatorsView, "_pinIndicator");
    _pinIndicator.image = [_pinIndicator.image imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    [_pinIndicator setTintColor:UA_redColor];

    UIImageView *_muteIndicator = MSHookIvar<UIImageView *>(self.indicatorsView, "_muteIndicator");
    _muteIndicator.image = [_muteIndicator.image imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    [_muteIndicator setTintColor:UA_redColor];
}
%end

%hook WAAdjustableSeparatorTableViewCell
-(BOOL)topSeparatorHidden {
    return YES;
}
-(BOOL)bottomSeparatorHidden {
    return YES;
}
%end

%hook WAMessageContainerView
-(void)updateBubbleImageView {
    %orig;
    _WANoHighlightImageView* imageView = MSHookIvar<_WANoHighlightImageView*>(self, "_bubbleImageView");
    imageView.image = [imageView.image imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];

    UIColor *tintColor = self.cellData.message.isFromMe
        ? UA_rgba(204, 255, 204, 0.7)
        : UA_rgba(255, 255, 255, 0.7);

    [imageView setTintColor:tintColor];
}
%end

%hook WADividerCell
-(void)layoutSubviews {
    %orig;
    UIView *backgroundView = MSHookIvar<UIView *>(self, "_backgroundView");
    UIView *blurredBackgroundView = MSHookIvar<UIView *>(self, "_blurredBackgroundView");
    backgroundView.hidden = YES;
    blurredBackgroundView.hidden = YES;
    self.backgroundColor = UA_grayColor;
}
%end

%hook WAReplyContextView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;

    WALabel* _contentLabel = MSHookIvar<WALabel *>(self, "_contentLabel");
    _contentLabel.textColor = UA_whiteColor;
}
%end

%hook _WADraggableInputContainerView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WADateBubbleView
-(void)layoutSubviews {
    %orig;
    self.backgroundView.backgroundColor = UA_clearColor;
}
%end

%hook WAProfilePictureScrollView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WAContactTableViewCell
-(void)layoutSubviews {
    %orig;
    self.nameLabel.color = UA_whiteColor;
}
%end

%hook WAContactPropertyTextField
-(void)layoutSubviews {
    %orig;
    self.textColor = UA_whiteColor;
}
%end

%hook WAContactCardItemTableViewCell
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WACallHistoryTableViewCell
-(void)layoutSubviews {
    %orig;

    self.dateLabel.textColor = UA_grayColor200;
    self.dateLabel.backgroundColor = UA_clearColor;
    self.detailLabel.textColor = UA_grayColor200;
    self.detailLabel.backgroundColor = UA_clearColor;
    self.eventCountLabel.textColor = UA_grayColor200;
    self.eventCountLabel.backgroundColor = UA_clearColor;
    self.displayNameLabel.backgroundColor = UA_clearColor;

    if ( ! [self.displayNameLabel.textColor isEqual:UA_rgb(255, 59, 48)]) {
        self.displayNameLabel.textColor = UA_whiteColor;
    }
}
%end

%hook WAMediaBrowserCollectionView
-(void)layoutSubviews {
    %orig;
    self.backgroundColor = UA_blvckColor;
}
%end

%hook WABackupInfoTableCell
-(void)layoutSubviews {
    %orig;
    self.labelHelperText.textColor = UA_whiteColor;
}
%end

%hook WAReportSpamCell
-(void)layoutSubviews {
    %orig;
    UIView* _backgroundView = MSHookIvar<UIView *>(self, "_backgroundView");
    _backgroundView.hidden = YES;
}
%end

%hook WAWebClientSessionTableViewCell
-(void)layoutSubviews {
    %orig;
    self.lastActiveLabel.textColor = UA_whiteColor;
    self.locationLabel.textColor = UA_whiteColor;
    self.operatingSystemLabel.textColor = UA_whiteColor;
    self.contentView.backgroundColor = UA_blvckColor;
	[self setSelectedBackgroundView: UA_UIViewWithColor(UA_blvckColor)];
}
%end

%hook WASettingsProfileTableViewCell
-(void)layoutSubviews {
    %orig;
    self.nameLabel.textColor = UA_whiteColor;
}
%end

%hook WADiskUsageOverviewCell
-(void)layoutSubviews {
    %orig;
    self.nameTextLabel.textColor = UA_whiteColor;
    self.sizeTextLabel.textColor = UA_grayColor200;
}
%end

%hook WAStatusDetailCell
-(void)layoutSubviews {
    %orig;
    WALabel *titleLabel = MSHookIvar<WALabel *>(self, "_titleLabel");
    titleLabel.textColor = UA_whiteColor;
}
%end
%end

%group BLVCK_WHATSAPP_CONTROLLERS_AND_CLASSES
%hook WACallHistoryViewController
-(void) viewDidLoad {
    %orig;
    UIView* _emptyListView = MSHookIvar<UIView *>(self, "_emptyListView");

    _emptyListView.backgroundColor = UA_blvckColor;

    self.view.backgroundColor = UA_blvckColor;
    self.tableView.backgroundColor = UA_blvckColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
%end
%end

%ctor {
    BOOL blvckIsEnabled = YES;
    BOOL inWhatsAppApp = [[[NSBundle mainBundle] bundleIdentifier] isEqualToString:kWhatsappBundleIdentifier];
    BOOL enabledLocally = [[[NSUserDefaults standardUserDefaults] objectForKey:kDefaultsDarkModeEnabledKey
                                                                          inDomain:kWhatsappDarkModeBundleIdentifier] boolValue];

    if (inWhatsAppApp == YES && blvckIsEnabled == YES && enabledLocally == YES) {
        %init(BLVCK_WHATSAPP_UIKIT);
        %init(BLVCK_WHATSAPP_WATUSI);
        %init(BLVCK_WHATSAPP_VIEWS);
        %init(BLVCK_WHATSAPP_CONTROLLERS_AND_CLASSES);
    }
}
