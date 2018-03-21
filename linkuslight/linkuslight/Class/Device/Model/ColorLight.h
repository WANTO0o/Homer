//
//  ColorLight.h
//  linkuslight
//
//  Created by Zex on 2017/12/13.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"



typedef void  (^successBlock)(id resp);
typedef void  (^failureBlock)(NSError *error);

@interface ColorLight : NSObject
//
//@property (nonatomic, assign) uint32_t Color_H;
//@property (nonatomic, assign) uint32_t Color_S;
//@property (nonatomic, assign) uint32_t Color_B;
//// 白光模式的颜色值
//@property (nonatomic, assign) uint16_t Color_Temp;
//// 亮度值，ColorB虽然也是表征亮度，但没有具体使用，只是用于记录HSB中的B值。彩色和白光模式的实际亮度值共用Color_Brightness参数
//@property (nonatomic, assign) uint8_t Color_Brightness;
//// 当前是否打开
//@property (nonatomic, assign) Boolean IsOn;
//@property (nonatomic, assign) LULLightType lightType;
@property (nonatomic, retain) DeviceInfo *deviceInfo;


//@property (nonatomic, copy) successBlock success;
//@property (nonatomic, copy) failureBlock failure;
//获取设备状态
- (void)getDeviceStatusSuccess:(successBlock)success failure:(failureBlock)failure;

-(id) initWithDeviceInfo:(DeviceInfo*) devInfo;
// 开灯
-(void) turnOnSuccess:(successBlock)success failure:(failureBlock)failure;
// 关灯
-(void) turnOffSuccess:(successBlock)success failure:(failureBlock)failure;
// 设置HSB颜色
-(void) setColorH:(uint32_t)colorH S:(uint32_t)colorS B:(uint32_t)colorB Success:(successBlock)success failure:(failureBlock)failure;
// 设置白光色温模式的色温值，
-(void) setColorTemp:(uint16_t)colorTemp Success:(successBlock)success failure:(failureBlock)failure;
// 设置亮度，可调范围为0～100
-(void) setBrightness:(uint8_t)brightness Success:(successBlock)success failure:(failureBlock)failure;

// 以下方法后续应该考虑设计为设备类型通用
// 绑定到云端
-(void) bindToCloudSuccess:(successBlock)success failure:(failureBlock)failure;
-(void) setMacAddr;
-(void) updateName:(NSString *)name AndDesc:(NSString *)desc Success:(successBlock)success failure:(failureBlock)failure;

@end
