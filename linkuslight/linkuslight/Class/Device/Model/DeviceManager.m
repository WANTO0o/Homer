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

-(void) replace:(DeviceInfo *)Device{
    for (NSInteger index = 0; index < self.deviceList.count; index++) {
        DeviceInfo *deviceInfo = self.deviceList[index];
        if ([Device.deviceID isEqualToString:deviceInfo.deviceID]) {
            [self.deviceList replaceObjectAtIndex:index withObject:Device];
            break;
        }
    }
}

/**
 整合设备列表
 @param localDevices 本地设备
 @param remoteDevices 网络获取设备
 */
- (void)integrateLocalDevices:(NSMutableArray *)localDevices remoteDevices:(NSMutableArray *)remoteDevices{
    BOOL repeat = NO;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (DeviceInfo *localDevice in localDevices) {
        for (DeviceInfo *remoteDevice in remoteDevices) {
            if ([localDevice.deviceID isEqualToString:remoteDevice.deviceID]) {
                repeat = YES;
                remoteDevice.ip = localDevice.ip;
                remoteDevice.linkState = LULDeviceLinkStateBoth;
                break;
            }
        }
        if (!repeat) {
            [tempArr addObject:localDevice];
        }
    }
    [tempArr addObjectsFromArray:remoteDevices];
    _deviceList = tempArr;
    DebugLog(@"设备列表：%@",_deviceList);
}


@end
