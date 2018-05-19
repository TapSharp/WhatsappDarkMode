#import "Shared.h"
#include <spawn.h>

@interface WATableRow: NSObject
@property(nonatomic, copy, readwrite) UITableViewCell *cell;
-(id)initWithCell:(id)arg1;
@end

@interface WATableSection: NSObject
@property(nonatomic, copy, readwrite) NSArray* rows;
-(void)setRows:(NSArray *)rows;
+(id)createCellWithStyle:(NSInteger)style;
@end

@interface WATableViewController: UITableViewController
@end

@interface WAStaticTableViewController: WATableViewController
@end

@interface WASettingsViewController: WAStaticTableViewController {
     WATableSection *_sectionSettings;
}
- (void)darkModeSwitchToggled:(id)sender;
@end
