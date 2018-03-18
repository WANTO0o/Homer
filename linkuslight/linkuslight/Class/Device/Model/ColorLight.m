//
//  ColorLight.m
//  linkuslight
//
//  Created by Zex on 2017/12/13.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "ColorLight.h"
#import "Homer.h"
#import "AFNetworking.h"
#import "HomerRemoteCtrl.h"

@interface ColorLight()<HomerRemoteCtrlDelegate>

@property (nonatomic, copy) Device *device;
@property (nonatomic, assign) HomerRemoteCtrl *homerRemoteCtrl;

@end

@implementation ColorLight

-(id) initWithDeviceInfo:(DeviceInfo*) devInfo {
    self = [super init];
    _deviceInfo = devInfo;
    _device = [[Device alloc] initWithIp:_deviceInfo.ip];
    _homerRemoteCtrl = [HomerRemoteCtrl sharedManager];//    _homerRemoteCtrl.delegate = self;
    return self;
}

-(void) bindToCloud {
    if(_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        DebugLog(@"Device already bind to cloud");
        return;
    }
    
    [self setMacAddr];
    [self.homerRemoteCtrl addDevice:_deviceInfo];
}

-(void)setMacAddr {
    int hexNum = [_deviceInfo.deviceID intValue];
    NSString *macAddr = [NSString stringWithFormat:@"ESP_%08X", hexNum];
    _deviceInfo.macAddr = macAddr;
    DebugLog(@"MacAddr %@", macAddr);
}

-(void) setColorH:(uint32_t)colorH S:(uint32_t)colorS B:(uint32_t)colorB Success:(successBlock)success failure:(failureBlock)failure{
    self.deviceInfo.Color_H = colorH;
    self.deviceInfo.Color_S = colorS;
    self.deviceInfo.Color_B = colorB;
//    _Color_S = colorS;
//    _Color_B = colorB;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        DebugLog(@"ColorH:%d, ColorS:%d, ColorB:%d", colorH, colorS, colorB);
        [_device controlColorH:colorH S:colorS B:self.deviceInfo.Color_Brightness];
        if (success != nil) {
            success(@"");
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightHSV:self success:success failure:failure];
    }
}

- (void) turnOffSuccess:(successBlock)success failure:(failureBlock)failure {
    _deviceInfo.IsOn = NO;
    DebugLog(@"ColorLight turnOff");
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        if (success != nil) {
            success(@"");
        }
        switch (self.deviceInfo.lightType) {
            case LULLightTypeWhiteLight:
                [_device controlColorTemperature:0];
                break;
            case LULLightTypeColourLight:
                [_device controlColorH:0 S:0 B:0];
            default:
                break;
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        switch (self.deviceInfo.lightType) {
            case LULLightTypeWhiteLight:
            case LULLightTypeColourLight:
                [self.homerRemoteCtrl turnLight:[self.deviceInfo deviceID] State:false  success:success failure:failure];
                break;
            default:
                break;
        }
    }
}

-(void) turnOnSuccess:(successBlock)success failure:(failureBlock)failure {
    _deviceInfo.IsOn = YES;
    DebugLog(@"ColorLight turnOn");
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        if (success != nil) {
            success(@"");
        }
        switch (self.deviceInfo.lightType) {
            case LULLightTypeWhiteLight:
                [_device controlColorTemperature:_deviceInfo.Color_Temp];
                break;
            case LULLightTypeColourLight:
                [_device controlColorH:_deviceInfo.Color_H S:_deviceInfo.Color_S B:_deviceInfo.Color_Brightness];
            default:
                break;
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        switch (self.deviceInfo.lightType) {
            case LULLightTypeWhiteLight:
            case LULLightTypeColourLight:
                [self.homerRemoteCtrl turnLight:[self.deviceInfo deviceID] State:true success:success failure:failure];
                break;
            default:
                break;
        }
    }
}

-(void) setColorTemp:(uint16_t)colorTemp Success:(successBlock)success failure:(failureBlock)failure{
    _deviceInfo.Color_Temp = colorTemp;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        [_device controlColorTemperature:colorTemp];
        if (success != nil) {
            success(@"");
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightTemperature:self success:success failure:failure];
    }
}

-(void) setBrightness:(uint8_t)brightness Success:(successBlock)success failure:(failureBlock)failure{
    _deviceInfo.Color_Brightness = brightness;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        DebugLog(@"brightness: %d", brightness);
        [_device setColorBrightness:brightness];
        if (success != nil) {
            success(@"");
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightBrightness:self success:success failure:failure];
    }
}

-(void) updateName:(NSString *)name AndDesc:(NSString *)desc Success:(successBlock)success failure:(failureBlock)failure{
    DeviceInfo *tmpDevInfo = [[DeviceInfo alloc] init];
    tmpDevInfo.deviceID = self.deviceInfo.deviceID;
    tmpDevInfo.name = name;
    tmpDevInfo.desc = desc;
    [self.homerRemoteCtrl updateDeviceInfo: tmpDevInfo Success:success failure:failure];
}

- (void)getDeviceStatusSuccess:(successBlock)success failure:(failureBlock)failure{
    /**直接拷贝获取列表的解析，可能有问题*/
    [self.homerRemoteCtrl getDeviceStatus:self.deviceInfo.deviceID success:^(id response) {
//        {
//            brightness = 38;
//            color =     {
//                brightness = "0.38"; 明亮度
//                hue = 344; //色调
//                saturation = 1; 饱和度
//            };
//            colorTemperatureInKelvin = 0;
//            powerState = ON;
//            ret = ok;
//        }
       
        NSDictionary *dict = (NSDictionary *)response;
        DebugLog(@"searchDevice %@", dict);
        if ([dict[@"ret"] isEqualToString:@"ok"]) {
            if ( [dict[@"powerState"] isEqualToString:@"ON"]) {
                self.deviceInfo.IsOn = YES;
            }else{
                self.deviceInfo.IsOn = NO;
            }
            _deviceInfo.Color_Temp = [dict[@"colorTemperatureInKelvin"] unsignedIntValue];
            if (_deviceInfo.Color_Temp == 0) {
                _deviceInfo.lightType = LULLightTypeColourLight;
            }else{
                _deviceInfo.lightType = LULLightTypeWhiteLight;
            }
            _deviceInfo.Color_Brightness = [dict[@"brightness"] unsignedIntValue];
            NSDictionary *colorDict =dict[@"color"];
            _deviceInfo.Color_H = [colorDict[@"hue"] unsignedIntValue];
            _deviceInfo.Color_S = [colorDict[@"saturation"] unsignedIntValue] *100;
            _deviceInfo.Color_B = [colorDict[@"brightness"] unsignedIntValue] *100;
//            self.Color_Brightness = [colorDict[@"hue"] unsignedIntValue];
//            self. = colorDict[@"hue"];
//            if () {
//                
//            }
//            if (self.Color_Brightness) {
//
//            }
//            NSObject *objAppliances = [dict objectForKey:@"appliances"];
            //NSLog(@"%@--%@", [objAppliances class], objAppliances);
//                success(response);
//                break;
            }
        success(response);
    } failure:^(id response) {
        failure(response);
    }];
}


@end
