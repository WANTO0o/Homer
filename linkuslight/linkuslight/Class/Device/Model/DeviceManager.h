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

+(DeviceManager *) sharedManager;

-(void) add:(DeviceInfo *)Device;
-(void) del:(DeviceInfo *)Device;

@end
