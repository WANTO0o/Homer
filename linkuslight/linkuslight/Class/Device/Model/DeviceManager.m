//
//  DeviceManager.m
//  linkuslight
//
//  Created by Zex on 2018/1/1.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager

+ (instancetype)sharedManager
{
    //Singleton instance
    static DeviceManager *devManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        devManager = [[self alloc] init];
        devManager.deviceList = [[NSMutableArray alloc] initWithCapacity:0];
    });
    
    return devManager;
}

- (void)add:(DeviceInfo *)Device {
    for (int i = 0; i < _deviceList.count; i++) {
        DeviceInfo *devInfo = _deviceList[i];
        if(devInfo.deviceID == Device.deviceID) {
            if(Device.linkState == LULDeviceLinkStateCloud) {
                devInfo.name = Device.name;
                devInfo.desc = Device.desc;
            }
            devInfo.linkState = LULDeviceLinkStateBoth;
            return;
        }
    }
    [_deviceList addObject:Device];
}

- (void)del:(DeviceInfo *)Device {
    [_deviceList removeObject:Device];
}

@end
