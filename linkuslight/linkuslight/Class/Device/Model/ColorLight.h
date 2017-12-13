//
//  ColorLight.h
//  linkuslight
//
//  Created by Zex on 2017/12/13.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "Homer.h"

@interface ColorLight : NSObject

@property (nonatomic, copy) Device *device;
@property (nonatomic, copy) DeviceInfo *devInfo;

@end
