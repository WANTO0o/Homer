//
//  AlarmClockTableViewCell.h
//  linkuslight
//
//  Created by Zex on 2018/10/29.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class AlarmClockTableViewCell;
@protocol AlarmClockCellDelegate <NSObject>

- (void)alarmCell:(AlarmClockTableViewCell *)cell switch:(UISwitch *)switchControl didSelectedAtIndexpath:(NSIndexPath *)indexpath;

@end

@interface AlarmClockTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeTextLabel; //上午 、下午
@property (weak, nonatomic) IBOutlet UILabel *timeLabel; // 时间
@property (weak, nonatomic) IBOutlet UILabel *timeTagLabel; //标签
@property (weak, nonatomic) IBOutlet UISwitch *timeSwitch;

@property (nonatomic, copy) NSIndexPath *indexPath;
@property (nonatomic, strong) ClockModel *model;

@property (nonatomic, assign) id<AlarmClockCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
