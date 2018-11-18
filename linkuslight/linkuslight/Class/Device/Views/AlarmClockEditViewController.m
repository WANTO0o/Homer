//
//  AlarmClockEditViewController.m
//  linkuslight
//
//  Created by Zex on 2018/11/3.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import "AlarmClockEditViewController.h"
#import "AlarmClockRepeatTableViewCell.h"
#import "AlarmClockTableViewCell.h"

@interface AlarmClockEditViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;

@property (weak, nonatomic) IBOutlet UITableView *repeatTableView;
@property (weak, nonatomic) IBOutlet UILabel *devStateInfo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *devState;

// 重复类型
@property (nonatomic, strong) NSMutableArray *repeatTypes;

@end

@implementation AlarmClockEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self transform];
    
    [self loadData];
}


#pragma mark - Navigation

 - (void) transform {
     UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
     rightItem.tintColor = [UIColor whiteColor];
     
     self.navigationItem.rightBarButtonItem = rightItem;
 }

- (void) loadData {
    if (!_model) {
        _model = [ClockModel new];
    }else {
        self.dataPicker.date = _model.date;
        
        UITableViewCell *cell = [self.repeatTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [self.repeatTableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AlarmClockRepeatTableViewCell *cell = [AlarmClockRepeatTableViewCell cellWithTableView:tableView];
    NSString *name = @"";
    switch (indexPath.row) {
        case 0:
            name = @"每周一"; break;
        case 1:
            name = @"每周二"; break;
        case 2:
            name = @"每周三"; break;
        case 3:
            name = @"每周四"; break;
        case 4:
            name = @"每周五"; break;
        case 5:
            name = @"每周六"; break;
        case 6:
            name = @"每周日"; break;
        default:
            break;
    }
    
    cell.textLabel.text = name;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.repeatTypes removeObject:cell.textLabel.text];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.repeatTypes addObject:cell.textLabel.text];
    }
}

- (void) saveData {
    self.model.date = _dataPicker.date;
    self.model.repeatStrs = self.repeatTypes;
    NSInteger selectedSegIndex = self.devState.selectedSegmentIndex;
    if(selectedSegIndex == 0) {
        self.model.tagStr = @"ON";
    } else if (selectedSegIndex == 1) {
        self.model.tagStr = @"OFF";
    }
    
    if(self.block) {
        self.block(self.model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *) repeatTypes {
    if (!_repeatTypes) {
        _repeatTypes = [NSMutableArray array];
    }
    return _repeatTypes;
}

@end
