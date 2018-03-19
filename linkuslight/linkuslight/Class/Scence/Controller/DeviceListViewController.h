//
//  ScenceDeviceListViewController.h
//  linkuslight
//
//  Created by aba on 17/11/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DeviceInfo.h"
#import "LightControlViewController.h"
#import "DeviceListTableViewCell.h"
typedef NS_ENUM(NSUInteger,FunctionType){
    FunctionTypeCreatGroup,
    FunctionTypeCreatScence,
};


@interface DeviceListViewController : UIViewController

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, assign)LULDeviceType deviceType;
@property (nonatomic, assign)FunctionType funcionType;
@property (nonatomic, assign)ScenceType sceneType;

@end
