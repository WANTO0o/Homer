//
//  AlarmClockTableVC.m
//  linkuslight
//
//  Created by Zex on 2018/10/29.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import "AlarmClockTableVC.h"
#import "AlarmClockTableViewCell.h"
#import "ClockViewModel.h"
#import "AlarmClockEditViewController.h"
#import "Uility.h"

@interface AlarmClockTableVC ()<UITableViewDelegate, UITableViewDataSource, AlarmClockCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *clockTableView;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@property (nonatomic, strong) ClockViewModel *viewModel;

@end

@implementation AlarmClockTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [_applyBtn setTitle:NSLocalizedString(@"apply", nil) forState:UIControlStateNormal];
    
    [self transform];
    
    [self initData];
}

- (void) transform {
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"back", nil)
     style:UIBarButtonItemStylePlain
     target:nil
     action:nil];
     backItem.tintColor = [UIColor whiteColor];
     
     self.navigationItem.backBarButtonItem = backItem;
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_leftbar"]
//                                                                 style:UIBarButtonItemStyleDone
//                                                                target:self
//                                                                action:@selector(gotoMenuView)];
//    leftItem.tintColor = [UIColor whiteColor];
//
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_addition"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(addAlarmClockView)];
    rightItem.tintColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addAlarmClockView {
    AlarmClockEditViewController *controller = [[AlarmClockEditViewController alloc] init];
    controller.block = ^(ClockModel *model){
        [self.viewModel addClockModel:model];
        [self.clockTableView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)showAlarmClockEditViewWith:(ClockModel *)SelectClockModel {
    AlarmClockEditViewController *controller = [[AlarmClockEditViewController alloc] init];
    controller.model = SelectClockModel;
    controller.block = ^(ClockModel *model){
        [self.viewModel replaceModelAtIndex:self.clockTableView.indexPathForSelectedRow.row withModel:model];
        [self.clockTableView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)initData {
    self.viewModel = [[ClockViewModel alloc] init];
    self.viewModel.clockData = [NSMutableArray array];
    
    for (int i = 0; i < self.clockArray.count; i++) {
        ClockModel *tempModel = self.clockArray[i];
        [_viewModel addClockModel:tempModel];
    }
    
//    ClockModel *model = [[ClockModel alloc] init];
//    model.timeText = @"下午";
//    model.date = [Uility UTCDateFromLocalString:@"2018-07-11 12:11:11"];
//    model.timeClock = @"5:15";
//    model.isOn = true;
//    model.tagStr = @"周一";
//
//    [_viewModel addClockModel:model];
    
    //NSLog(@"ClodckData Count %lu", (unsigned long)_viewModel.clockData.count);
}

- (IBAction)applyClicked:(UIButton *)sender {
    if(self.block) {
        self.block(self.viewModel.clockData);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.clockData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmClockTableViewCell *cell = [AlarmClockTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.viewModel.clockData[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ClockModel *selectModel = self.viewModel.clockData[indexPath.row];
    [self showAlarmClockEditViewWith:selectModel];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel removeClockAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)alarmCell:(AlarmClockTableViewCell *)cell switch:(UISwitch *)switchControl didSelectedAtIndexpath:(NSIndexPath *)indexpath {
    [self.viewModel changeClockSwitchIsOn:switchControl.isOn WithModel:self.viewModel.clockData[indexpath.row]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- getter

- (ClockViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [ClockViewModel readData];
    }
    return _viewModel;
}


@end
