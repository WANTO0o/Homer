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

@interface ColorLight()

@property (nonatomic, copy) Device *device;
@property (nonatomic, assign) HomerRemoteCtrl *homerRemoteCtrl;

@end

@implementation ColorLight

-(id) initWithDeviceInfo:(DeviceInfo*) devInfo {
    self = [super init];
    _deviceInfo = devInfo;
    _device = [[Device alloc] initWithIp:_deviceInfo.ip];
    _homerRemoteCtrl = [HomerRemoteCtrl sharedManager];
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

-(void) setColorH:(uint32_t)colorH S:(uint32_t)colorS B:(uint32_t)colorB {
    _Color_H = colorH;
    _Color_S = colorS;
    _Color_B = colorB;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        DebugLog(@"ColorH:%d, ColorS:%d, ColorB:%d", _Color_H, _Color_S, _Color_B);
        [_device controlColorH:colorH S:colorS B:_Color_Brightness];
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightHSV:self];
    }
}

- (void) turnOff {
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
                [self.homerRemoteCtrl turnLight:[self.deviceInfo deviceID] State:false];
                break;
            default:
                break;
        }
    }
}

- (void) turnOn {
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
                [self.homerRemoteCtrl turnLight:[self.deviceInfo deviceID] State:true];
                break;
            default:
                break;
        }
    }
}

-(void) setColorTemp:(uint16_t)colorTemp {
    _Color_Temp = colorTemp;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        [_device controlColorTemperature:colorTemp];
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightTemperature:self];
    }
}

-(void) setBrightness:(uint8_t)brightness {
    _Color_Brightness = brightness;
    if (_deviceInfo.linkState & LULDeviceLinkStateWiFi) {
        DebugLog(@"brightness: %d", _Color_Brightness);
        [_device setColorBrightness:brightness];
    } else if (_deviceInfo.linkState & LULDeviceLinkStateCloud) {
        [self.homerRemoteCtrl setLightBrightness:self];
    }
}

-(void) updateName:(NSString *)name AndDesc:(NSString *)desc {
    DeviceInfo *tmpDevInfo = [[DeviceInfo alloc] init];
    tmpDevInfo.deviceID = self.deviceInfo.deviceID;
    tmpDevInfo.name = name;
    tmpDevInfo.desc = desc;
    [self.homerRemoteCtrl updateDeviceInfo:tmpDevInfo];
}

@end
