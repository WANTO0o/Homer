//
//  DeviceInfo.h
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"
typedef NS_ENUM(NSInteger, LULDeviceLinkState) {
    LULDeviceLinkStateWiFi = 0x01,
    LULDeviceLinkStateCloud = 0x10,
    LULDeviceLinkStateBoth = 0x11,
    LULDeviceLinkStateNone = 0x00
};

typedef NS_ENUM(NSInteger, LULDeviceType) {
    LULDeviceLinkStateColourLight,
    LULDeviceLinkStateWhiteLight,
    LULDeviceLinkStateSocket
};

typedef NS_ENUM(NSInteger, LULLightType) {
    LULLightTypeWhiteLight,
    LULLightTypeColourLight
};
@interface DeviceInfo : NSObject <NSCoding>

@property (nonatomic,copy)NSString *deviceID;
//@property (nonatomic,assign)Boolean isOn;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ip;
@property (nonatomic,assign)Boolean hasClockFlag;
@property (nonatomic,assign)Boolean hasStatuFlag;
@property (nonatomic,assign)LULDeviceLinkState linkState;
@property (nonatomic,assign)LULDeviceType deviceType;
@property (nonatomic,copy)NSString *macAddr;
@property (nonatomic,copy)NSString *desc;


@property (nonatomic, assign) uint32_t Color_H;
@property (nonatomic, assign) uint32_t Color_S;
@property (nonatomic, assign) uint32_t Color_B;
// 白光模式的颜色值
@property (nonatomic, assign) uint16_t Color_Temp;
// 亮度值，ColorB虽然也是表征亮度，但没有具体使用，只是用于记录HSB中的B值。彩色和白光模式的实际亮度值共用Color_Brightness参数
//0~100
@property (nonatomic, assign) uint8_t Color_Brightness;
// 当前是否打开
@property (nonatomic, assign) Boolean IsOn;
@property (nonatomic, assign) LULLightType lightType;

@end

@interface GroupInfo : NSObject

//@property (nonatomic,copy)NSString *deviceID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)Boolean isOn;
@property (nonatomic,assign)LULDeviceType deviceType;
@property (nonatomic,copy) NSMutableArray *deviceArr;
@end


@interface ScenceInfo : NSObject

@property (nonatomic,copy)NSString *scenceID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)Boolean isOn;
@property (nonatomic,assign)LULDeviceType deviceType;
@property (nonatomic,retain)NSMutableArray *deviceList;

@end
