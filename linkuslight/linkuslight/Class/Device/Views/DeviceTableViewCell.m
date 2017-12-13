//
//  DeviceTableViewCell.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "UIImage+RTTint.h"
#import "DeviceTableViewCell.h"

@interface DeviceTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *lightImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *clockImg;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UIImageView *linkStateImg;

@end

@implementation DeviceTableViewCell

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
    static NSString *identifer = @"deviceTableViewCell";
    
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceTableViewCell" owner:self options:nil] firstObject];
    }
    
    return cell;

}

- (void)refreshWithDeviceInfo:(DeviceInfo *)device
{
    
    self.titleLable.text = device.name;
    
    if (device.hasClockFlag) {
        
        UIImage *clkimg = [UIImage imageNamed:@"addition_icon_alarm"];
        if (device.isOn) {
            self.clockImg.image = clkimg;
        } else {
            self.clockImg.image = [clkimg rt_tintedImageWithColor:[UIColor colorWithRed:0.7922 green:0.8157 blue:0.8392 alpha:1.0]];
        }
    } else {
        self.clockImg.image = nil;
    }
    
    if (device.hasStatuFlag) {
        UIImage *staimg = [UIImage imageNamed:@"addition_icon_morning"];
        if (device.isOn) {
            self.statusImg.image = staimg;
        } else {
            self.statusImg.image = [staimg rt_tintedImageWithColor:[UIColor colorWithRed:0.8681 green:0.8962 blue:0.9261 alpha:1.0]];
        }
    } else {
        self.statusImg.image = nil;
    }

    NSString *lkimgName = @"";
    if (device.linkState == LULDeviceLinkStateWiFi) {
        lkimgName = @"wifi";
    } else if (device.linkState == LULDeviceLinkStateCloud) {
        lkimgName = @"Cloud data";
    } else {
        lkimgName = @"";
    }
    
    UIImage *lkimg = [UIImage imageNamed:lkimgName];
    if (device.isOn) {
        self.linkStateImg.image = lkimg;
    } else {
        self.linkStateImg.image = [lkimg rt_tintedImageWithColor:[UIColor colorWithRed:0.7922 green:0.8157 blue:0.8392 alpha:1.0]];
    }

    
    UIImage *ltimg = [UIImage imageNamed:@"addition_icon_succeed"];
    if (device.isOn) {
        self.lightImg.image = ltimg;
        self.titleLable.textColor = [UIColor blackColor];
    } else {
        self.lightImg.image = [UIImage imageNamed:@"addition_icon_defeated"];
        self.titleLable.textColor = [UIColor colorWithRed:0.7922 green:0.8157 blue:0.8392 alpha:1.0];
    }

}

- (void)setOnline:(BOOL)isOnline
{

}


@end
