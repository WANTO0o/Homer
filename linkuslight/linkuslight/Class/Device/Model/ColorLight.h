//
//  ColorLight.h
//  linkuslight
//
//  Created by Zex on 2017/12/13.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"

typedef NS_ENUM(NSInteger, LULLightType) {
    LULLightTypeWhiteLight,
    LULLightTypeColourLight
};

@interface ColorLight : NSObject

@property (nonatomic, assign) uint32_t Color_H;
@property (nonatomic, assign) uint32_t Color_S;
@property (nonatomic, assign) uint32_t Color_B;
// 白光模式的颜色值
@property (nonatomic, assign) uint16_t Color_Temp;
// 亮度值，ColorB虽然也是表征亮度，但没有具体使用，只是用于记录HSB中的B值。彩色和白光模式的实际亮度值共用Color_Brightness参数
@property (nonatomic, assign) uint8_t Color_Brightness;
// 当前是否打开
@property (nonatomic, assign) Boolean IsOn;
@property (nonatomic, assign) LULLightType lightType;

-(id) initWithDeviceInfo:(DeviceInfo*) devInfo;
// 开灯
-(void) turnOn;
// 关灯
-(void) turnOff;
// 设置HSB颜色
-(void) setColorH:(uint32_t)colorH S:(uint32_t)colorS B:(uint32_t)colorB;
// 设置白光色温模式的色温值，
-(void) setColorTemp:(uint16_t)colorTemp;
// 设置亮度，可调范围为0～100
-(void) setBrightness:(uint8_t)brightness;

@end
