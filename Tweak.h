#import "Shared.h"

// -------------------------------------------------------
// Labels
// -------------------------------------------------------

@interface WAAutoscrollingLabel: UILabel
@end

@interface WANoChatsView: UIView {
    UILabel* _textLabel;
}
@end

@interface WALabel: UILabel
@end

@interface WABadgedLabel: UIView
@property(nonatomic, copy, readwrite) UIColor *color;
@end

// -------------------------------------------------------
// Views
// -------------------------------------------------------

@interface _UIBarBackground: UIView
@end

@interface UISearchBarTextField: UITextField
@end

@interface FRFavoriteTableViewCell: UITableViewCell
@end

@interface _WAChatSessionCellIndicatorsView: UIView {
    UIImageView *_muteIndicator;
    UIImageView *_pinIndicator;
}
@property(nonatomic, readwrite) BOOL highlighted;
@end

@interface WAGroupedTableSectionHeaderView: UITableViewHeaderFooterView {
    UIView *_backgroundView;
}
@property(nonatomic, copy, readwrite) UILabel *titleLabel;
@end

@interface STUpdateTableViewCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* contactNameLabel;
@end

@interface STUpdateHeaderView: UIView
@property(nonatomic, copy, readwrite) UILabel* nameLabel;
@property(nonatomic, copy, readwrite) UILabel* statusLabel;
@property(nonatomic, copy, readwrite) UILabel* singleNameLabel;
@end

@interface WAStatusTextView: UIView
@end

@interface WAStatusChatSessionCell: UITableViewCell {
    UILabel *_subtitleLabel;
    WABadgedLabel *_titleLabel;
}
@end

@interface WAStatusScrollView: UIScrollView
@end

@interface WAStatusViewerSeenByView: UIView {
    UILabel *_headerLabel;
    UIView *_backgroundView;
}
@end

@interface WAStatusViewerRecipientCell: UITableViewCell {
    UILabel *_nameLabel;
    UILabel *_dateLabel;
    UILabel *_timeLabel;
}
@end

@interface WAChatSessionCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel *activityLabel;
@property(nonatomic, copy, readwrite) WALabel *messageLabel;
@property(nonatomic, copy, readwrite) WABadgedLabel *nameLabel;
@property(nonatomic, copy, readwrite) UILabel *senderLabel;
@property(nonatomic, copy, readwrite) UILabel *timeLabel;
@property (nonatomic, copy, readwrite) _WAChatSessionCellIndicatorsView *indicatorsView;
@end

@interface WAAdjustableSeparatorTableViewCell: UITableViewCell
-(BOOL)topSeparatorHidden;
-(BOOL)bottomSeparatorHidden;
@end

@interface _WANoHighlightImageView: UIImageView
@end

@interface WAMessage: NSObject
@property(nonatomic, readwrite) BOOL isFromMe;
@end

@interface WADividerCell: UITableViewCell {
    UIView *_backgroundView;
    UIView *_blurredBackgroundView;
}
@end

@interface WAReplyContextView: UIView {
    WALabel* _contentLabel;
}
@end

@interface WAChatCellData: NSObject
@property(nonatomic,copy,  readwrite) WAMessage* message;
@end

@interface WAMessageContainerView: UIView {
    _WANoHighlightImageView *_bubbleImageView;
}
@property(nonatomic, copy, readwrite) WAChatCellData* cellData;
-(void)updateBubbleImageView;
@end

@interface _WADraggableInputContainerView: UIView
@end

@interface WADateBubbleView: UITableViewHeaderFooterView
@end

@interface WAProfilePictureScrollView: UIScrollView
@end

@interface WAContactNameLabel: WABadgedLabel
@end

@interface WAContactTableViewCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* detailLabel;
@property(nonatomic, copy, readwrite) WAContactNameLabel* nameLabel;
@property(nonatomic, copy, readwrite) UILabel* pushNameLabel;
@property(nonatomic, copy, readwrite) UILabel* statusLabel;
@end

@interface WAContactPropertyTextField: UITextField
@end

@interface WAContactCardItemTableViewCell: UITableViewCell
@end

@interface WACallHistoryViewController: UITableViewController {
    UIView* _emptyListView;
    UILabel *_emptyListViewLabel;
}
@end

@interface WACallHistoryTableViewCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* dateLabel;
@property(nonatomic, copy, readwrite) UILabel* detailLabel;
@property(nonatomic, copy, readwrite) UILabel* displayNameLabel;
@property(nonatomic, copy, readwrite) UILabel* eventCountLabel;
@end

@interface WAMediaBrowserCollectionView: UICollectionView
@end

@interface WABackupInfoTableCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* labelHelperText;
@end

@interface WAReportSpamCell: UITableViewCell {
    UIView* _backgroundView;
}
@end

@interface WAWebClientSessionTableViewCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* lastActiveLabel;
@property(nonatomic, copy, readwrite) UILabel* locationLabel;
@property(nonatomic, copy, readwrite) UILabel* operatingSystemLabel;
@end

@interface WASettingsProfileTableViewCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* nameLabel;
@end

@interface WADiskUsageOverviewCell: UITableViewCell
@property(nonatomic, copy, readwrite) UILabel* nameTextLabel;
@property(nonatomic, copy, readwrite) UILabel* sizeTextLabel;
@end

@interface WAStatusDetailCell: UITableViewCell {
    WALabel *titleLabel;
}
@end
