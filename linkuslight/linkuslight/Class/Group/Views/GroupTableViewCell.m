//
//  GroupTableViewCell.m
//  linkuslight
//
//  Created by Aba on 17/11/4.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "GroupTableViewCell.h"

@interface GroupTableViewCell()

@property (retain, nonatomic) GroupInfo *groupInfo;
@property (weak, nonatomic) IBOutlet UIImageView *deviceImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *clockImg;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UIImageView *linkStateImg;

@end

@implementation GroupTableViewCell

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
    static NSString *identifer = @"groupTableViewCell";
    
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GroupTableViewCell" owner:self options:nil] firstObject];
    }
    
    return cell;
    
}

- (void)refreshWithDeviceInfo:(GroupInfo *)group;
{
    self.groupInfo = group;
    self.titleLable.text = group.name;
    
    switch (group.deviceType) {
        case LULDeviceLinkStateColourLight:
            _deviceImg.image = [UIImage imageNamed:@"group_icon_colour"];
            break;
        case LULDeviceLinkStateWhiteLight:
            _deviceImg.image = [UIImage imageNamed:@"group_icon_white"];

            break;
        case LULDeviceLinkStateSocket:
            _deviceImg.image = [UIImage imageNamed:@"group_icon_socket"];

            break;
        default:
            break;
    }
}

- (void)setOnline:(BOOL)isOnline
{
    
}

@end
