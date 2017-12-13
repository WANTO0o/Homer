//
//  GroupTableViewCell.h
//  linkuslight
//
//  Created by Aba on 17/11/4.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceInfo.h"

@class GroupTableViewCell;

@protocol GroupTableViewCellDelegate

- (void)didCellClicked:(GroupTableViewCell*)sender;

@end

@interface GroupTableViewCell : UITableViewCell

@property (nonatomic,retain) id<GroupTableViewCellDelegate> Delegate;

@property (nonatomic,strong) UIImageView* headImageView;
@property (nonatomic,strong) UILabel* nameLable;
@property (nonatomic,assign) NSInteger index;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)refreshWithDeviceInfo:(GroupInfo *)group;


@end
