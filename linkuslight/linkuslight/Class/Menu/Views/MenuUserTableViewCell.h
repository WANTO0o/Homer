//
//  MenuUserTableViewCell.h
//  linkuslight
//
//  Created by Aba on 17/10/8.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LOLUser.h"
#import <UIKit/UIKit.h>
@class MenuUserTableViewCell;

@protocol MenuUserTableViewCellDelegate

- (void)didCellClicked:(MenuUserTableViewCell*)sender;

@end
@interface MenuUserTableViewCell : UITableViewCell

@property (nonatomic,retain) id<MenuUserTableViewCellDelegate> Delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)refreshWithUserInfo:(LOLUser *)user;

@end
