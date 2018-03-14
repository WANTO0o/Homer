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
    _Color_H = colorH;
    _Color_S = colorS;
    _Color_B = colorB;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        DebugLog(@"ColorH:%d, ColorS:%d, ColorB:%d", _Color_H, _Color_S, _Color_B);
        [_device controlColorH:colorH S:colorS B:_Color_Brightness];
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightHSV:self success:success failure:failure];
    }
}

- (void) turnOffSuccess:(successBlock)success failure:(failureBlock)failure {
    DebugLog(@"ColorLight turnOff");
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        switch (_lightType) {
            case LULLightTypeWhiteLight:
                [_device controlColorTemperature:0];
                break;
            case LULLightTypeColourLight:
                [_device controlColorH:0 S:0 B:0];
            default:
                break;
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        switch (self.lightType) {
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
    DebugLog(@"ColorLight turnOn");
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        switch (_lightType) {
            case LULLightTypeWhiteLight:
                [_device controlColorTemperature:_Color_Temp];
                break;
            case LULLightTypeColourLight:
                [_device controlColorH:_Color_H S:_Color_S B:_Color_Brightness];
            default:
                break;
        }
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        switch (self.lightType) {
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
    _Color_Temp = colorTemp;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        [_device controlColorTemperature:colorTemp];
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightTemperature:self success:success failure:failure];
    }
}

-(void) setBrightness:(uint8_t)brightness Success:(successBlock)success failure:(failureBlock)failure{
    _Color_Brightness = brightness;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        DebugLog(@"brightness: %d", _Color_Brightness);
        [_device setColorBrightness:brightness];
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightBrightness:self success:success failure:failure];
    }
}

-(void) updateName:(NSString *)name AndDesc:(NSString *)desc Success:(successBlock)success failure:(failureBlock)failure{
    DeviceInfo *tmpDevInfo = [[DeviceInfo alloc] init];
    tmpDevInfo.deviceID = self.deviceInfo.deviceID;
    tmpDevInfo.name = name;
    tmpDevInfo.desc = desc;
    [self.homerRemoteCtrl updateDeviceInfo:tmpDevInfo];
}

- (void)getDeviceStatusSuccess:(successBlock)success failure:(failureBlock)failure{
    /**直接拷贝获取列表的解析，可能有问题*/
    [self.homerRemoteCtrl getDeviceStatus:self.deviceInfo.deviceID success:^(id response) {
        
        NSDictionary *dict = (NSDictionary *)response;
        DebugLog(@"searchDevice %@", dict);
        
        NSObject *objAppliances = [dict objectForKey:@"appliances"];
        //NSLog(@"%@--%@", [objAppliances class], objAppliances);
        NSArray *dictArray = (NSArray *)objAppliances;
        for (NSObject *obj in dictArray) {
            //NSLog(@"%@", [obj class]);
            NSDictionary *dictItem = (NSDictionary *)obj;
            
            DeviceInfo *devInfo = [[DeviceInfo alloc] init];
            devInfo.linkState = LULDeviceLinkStateCloud;
            devInfo.isOn = true;
            for (NSString *objItem in [dictItem keyEnumerator]) {
                NSString *value = [dictItem valueForKey:objItem];
                DebugLog(@"key:%@ value:%@", objItem, value);
                if([objItem isEqualToString:@"friendlyName"]) {
                    devInfo.name = value;
                } else if([objItem isEqualToString:@"macAddr"]) {
                    devInfo.macAddr = value;
                } else if ([objItem isEqualToString:@"friendlyDescription"]) {
                    devInfo.desc = value;
                } else if ([objItem isEqualToString:@"applianceId"]) {
                    devInfo.deviceID = value;
                } else if ([objItem isEqualToString:@"applianceTypes"]) {
                    // TODO: appliance Types
                }
            }
            
            self.deviceInfo = devInfo;
            success(response);
            break;
        }
        success(response);
    } failure:^(id response) {
        failure(response);
    }];
}


@end
