//
//  ScenceDeviceListTableViewCell.m
//  linkuslight
//
//  Created by aba on 17/11/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "DeviceListTableViewCell.h"

@interface DeviceListTableViewCell()

@property (retain, nonatomic) DeviceInfo *deviceInfo;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;

@end

@implementation DeviceListTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)didBCSelectedButtonClicked:(id)sender {
    if (self.Delegate) {
        _deviceInfo.IsOn = !_deviceInfo.IsOn;
        [self.Delegate didCellClicked:self IsOn:_deviceInfo.IsOn];
    }
}

- (IBAction)didSelectedButtonClicked:(id)sender {
    if (self.Delegate) {
        _deviceInfo.IsOn = !_deviceInfo.IsOn;
        [self.Delegate didCellClicked:self IsOn:_deviceInfo.IsOn];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"deviceListTableViewCell";
    
    DeviceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceListTableViewCell" owner:self options:nil] firstObject];
    }
    
    return cell;
    
}

- (void)refreshWithDeviceInfo:(DeviceInfo *)device
{
    
    self.deviceInfo = device;
    self.titleLable.text = device.name;
    
    switch (device.deviceType) {
            
        case LULDeviceLinkStateColourLight:
            _typeImg.image = [UIImage imageNamed:@"group_icon_colour"];
            break;
        case LULDeviceLinkStateWhiteLight:
            _typeImg.image = [UIImage imageNamed:@"group_icon_white"];
            break;
        case LULDeviceLinkStateSocket:
            _typeImg.image = [UIImage imageNamed:@"group_icon_socket"];
            break;
        default:
            break;
    }
    
    if (device.IsOn) {
        [self.statusButton setTitle:@"●" forState:UIControlStateNormal];
        [self.statusButton setTitleColor:[UIColor colorWithRed:255/255.0 green:205/255.0 blue:0/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    } else {
        [self.statusButton setTitle:@"○" forState:UIControlStateNormal];
        [self.statusButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
}

- (void)setOnline:(BOOL)isOnline
{
    
}


@end
