//
//  LightControlViewController.h
//  linkuslight
//
//  Created by Aba on 17/10/26.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCircularView.h"
#import "DeviceInfo.h"

typedef NS_ENUM(NSUInteger,LightControlDeviceType) {
    LightControlDeviceTypeSingle,   //操作单个设备
    LightControlDeviceTypeGroup,    //操作分组设备
};
@interface LightControlViewController : UIViewController

@property (nonatomic, assign) Boolean isDevice;
@property (nonatomic) LULLightSliderType LightType;
@property (nonatomic, strong) DeviceInfo *DeviceInfo;
@property (nonatomic, strong) GroupInfo *groupInfo;
@property (nonatomic, assign) LightControlDeviceType  lightControlDeviceType;

@property (nonatomic, copy) void(^deleteDeviceBlock)(DeviceInfo *);
@end
