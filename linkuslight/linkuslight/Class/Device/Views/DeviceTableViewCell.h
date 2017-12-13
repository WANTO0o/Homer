//
//  DeviceTableViewCell.h
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DeviceInfo.h"

@class DeviceTableViewCell;

@protocol DeviceTableViewCellDelegate

- (void)didCellClicked:(DeviceTableViewCell*)sender;

@end

@interface DeviceTableViewCell : UITableViewCell

@property (nonatomic,retain) id<DeviceTableViewCellDelegate> Delegate;

@property (nonatomic,strong) UIImageView* headImageView;
@property (nonatomic,strong) UILabel* nameLable;
@property (nonatomic) NSInteger index;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)refreshWithDeviceInfo:(DeviceInfo *)device;
- (void)setOnline:(BOOL)isOnline;

@end
