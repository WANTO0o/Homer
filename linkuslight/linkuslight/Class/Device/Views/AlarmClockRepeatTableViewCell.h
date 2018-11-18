//
//  AlarmClockRepeatTableViewCell.h
//  linkuslight
//
//  Created by Zex on 2018/11/4.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlarmClockRepeatTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
