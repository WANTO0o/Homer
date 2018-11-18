//
//  AlarmClockTableViewCell.m
//  linkuslight
//
//  Created by Zex on 2018/10/29.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import "AlarmClockTableViewCell.h"

@implementation AlarmClockTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"AlarmClockTableViewCell";
    
    AlarmClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlarmClockTableViewCell" owner:self options:nil] firstObject];
    }
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ClockModel *)model {
    _model = model;
    self.timeLabel.text = model.timeClock;
    self.timeTextLabel.text = model.timeText;
    self.timeSwitch.on = model.isOn;
    if (model.repeatStr.length > 0 && ![model.repeatStr isEqualToString:@"永不"]) {
        self.timeTagLabel.text = [NSString stringWithFormat:@"%@，%@", model.tagStr,model.repeatStr];
    }else {
        self.timeTagLabel.text = model.tagStr;
    }
}

@end
