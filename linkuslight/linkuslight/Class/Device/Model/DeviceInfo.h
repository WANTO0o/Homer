//
//  DeviceInfo.h
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LULDeviceLinkState) {
    LULDeviceLinkStateWiFi,
    LULDeviceLinkStateCloud,
    LULDeviceLinkStateNone
};

typedef NS_ENUM(NSInteger, LULDeviceType) {
    LULDeviceLinkStateColourLight,
    LULDeviceLinkStateWhiteLight,
    LULDeviceLinkStateSocket
};

@interface DeviceInfo : NSObject

@property (nonatomic,copy)NSString *deviceID;
@property (nonatomic,assign)Boolean isOn;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ip;
@property (nonatomic,assign)Boolean hasClockFlag;
@property (nonatomic,assign)Boolean hasStatuFlag;
@property (nonatomic,assign)LULDeviceLinkState linkState;
@property (nonatomic,assign)LULDeviceType deviceType;

@end

@interface GroupInfo : NSObject

@property (nonatomic,copy)NSString *deviceID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)Boolean isOn;
@property (nonatomic,assign)LULDeviceType deviceType;

@end


@interface ScenceInfo : NSObject

@property (nonatomic,copy)NSString *scenceID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)Boolean isOn;
@property (nonatomic,assign)LULDeviceType deviceType;
@property (nonatomic,retain)NSMutableArray *deviceList;

@end
