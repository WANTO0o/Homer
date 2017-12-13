//
//  ScenceDeviceListTableViewCell.h
//  linkuslight
//
//  Created by aba on 17/11/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DeviceInfo.h"

@class DeviceListTableViewCell;

@protocol DeviceTableViewCellDelegate

- (void)didCellClicked:(DeviceListTableViewCell*)sender IsOn:(Boolean)isOn;

@end


@interface DeviceListTableViewCell : UITableViewCell

@property (nonatomic,retain) id<DeviceTableViewCellDelegate> Delegate;

@property (nonatomic,strong) UIImageView* headImageView;
@property (nonatomic,strong) UILabel* nameLable;
@property (nonatomic,assign) NSInteger index;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)refreshWithDeviceInfo:(DeviceInfo *)device;

@end
