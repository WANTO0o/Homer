//
//  DeviceManager.h
//  linkuslight
//
//  Created by Zex on 2018/1/1.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorLight.h"
#import "DeviceInfo.h"

@interface DeviceManager : NSObject

@property (atomic, strong) NSMutableArray *deviceList;
@property (atomic, strong) NSMutableArray *colorLightList;
+(DeviceManager *) sharedManager;

-(void) add:(DeviceInfo *)Device;
-(void) del:(DeviceInfo *)Device;
-(void) replace:(DeviceInfo *)Device;

/**
 整合设备列表
 @param localDevices 本地设备
 @param remoteDevices 网络获取设备
 */
- (void)integrateLocalDevices:(NSMutableArray *)localDevices remoteDevices:(NSMutableArray *)remoteDevices;
@end
