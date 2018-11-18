//
//  AlarmClockRepeatTableViewCell.m
//  linkuslight
//
//  Created by Zex on 2018/11/4.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import "AlarmClockRepeatTableViewCell.h"

@implementation AlarmClockRepeatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"AlarmClockTableViewCell";
    
    AlarmClockRepeatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlarmClockRepeatTableViewCell" owner:self options:nil] firstObject];
    }
    
    return cell;
}

@end
