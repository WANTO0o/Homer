//
//  HomerRemoteCtrl.m
//  linkuslight
//
//  Created by Zex on 2018/1/6.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import "HomerRemoteCtrl.h"
#import "ColorLight.h"
#import <AFNetworking.h>
#import "LULSessionManager.h"

@interface HomerRemoteCtrl()

@property (nonatomic, copy) NSString *apiGateWayURL;
@property (nonatomic, copy) NSString *amznUserID;
@property (nonatomic, assign) AFHTTPSessionManager *httpSessionManager;

@end

@implementation HomerRemoteCtrl

+ (instancetype)sharedManager
{
    //Singleton instance
    static HomerRemoteCtrl *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        //manager.amznUserID = @"amzn1.account.AFPRDTUZWOWR4W2SZHG4DTTNHYXQ";
        //manager.apiGateWayURL = @"https://n32ircd1ha.execute-api.us-east-1.amazonaws.com/v1";
        
        //manager.apiGateWayURL = @"https://oi4dghee2h.execute-api.us-east-1.amazonaws.com/SmartELF_Stage";
        manager.apiGateWayURL = @"https://dnvh8mdbub.execute-api.us-east-1.amazonaws.com/Stage1";
        manager.amznUserID = [[LULSessionManager manager] GetUserData].userID;
        
        manager.httpSessionManager = [AFHTTPSessionManager manager];
        manager.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置JSON序列化
        manager.httpSessionManager.requestSerializer.timeoutInterval = 10.f; // 设置超时时间10s
    });
    
    return manager;
}

-(void)searchDevice {
    //amzn1.account.AEYR2AGOLSGVKYSKXAJTPK7VO3CQ
    NSDictionary *params = @{
                             @"userId": self.amznUserID,
                             @"option": @"GetDevList"
                             };
    
    [_httpSessionManager POST:self.apiGateWayURL parameters:params
                      success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        NSMutableArray *tempDevArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dict = (NSDictionary *)responseObject;
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
            
            ColorLight *tmpLight = [[ColorLight alloc] initWithDeviceInfo:devInfo];
            
            [tempDevArray addObject:tmpLight];
        }
        
        [_delegate remoteSearchDevice:tempDevArray];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DebugLog(@"%@---", error);
        [_delegate transferFailWithMsg:error];
    }];
}

- (void)getDeviceStatus:(NSString *)devId
                success:(void (^)( id response))success
                failure:(void (^)( id response))failure{
    NSDictionary *paramAppliance = @{
                                     @"applianceId" : devId,
                                     };
    NSDictionary *params = @{
                             @"userId" : self.amznUserID,
                             @"option" : @"GetDevInfo",
                             @"appliance" : paramAppliance
                             };
     [self transferHttpSessionWithParameter:params success:success failure:failure];
}

-(void)turnLight:(NSString *)lightID State:(Boolean)state success:(successBlock)success failure:(failureBlock)failure{
    NSLog(@"turnLight");
    
    NSString *optionStr = @"";
    if(state) {
        optionStr = @"TurnOnLight";
    } else {
        optionStr = @"TurnOffLight";
    }
    
    NSDictionary *paramAppliance = @{
                                     @"applianceId" : lightID,
                                     @"applianceTypes" : @"whitelight"
                                     };
    NSDictionary *params = @{
                             @"userId" : self.amznUserID,
                             @"option" : optionStr,
                             @"appliance" : paramAppliance
                             };
    
    [self transferHttpSessionWithParameter:params success:success failure:failure];
}

-(void) setLightHSV:(ColorLight *)light success:(successBlock)success failure:(failureBlock)failure{
    NSString *devId = light.deviceInfo.deviceID;
    NSDictionary *paramColor = @{
                                 @"hue" : [NSNumber numberWithUnsignedInteger:light.Color_H],
                                 @"saturation" : [NSNumber numberWithUnsignedInteger:(light.Color_S/100)],
                                 @"brightness" : [NSNumber numberWithUnsignedInteger:(light.Color_B/100)]
                                 };
    
    NSDictionary *paramAppliance = @{
                                     @"applianceId" : devId,
                                     @"color" : paramColor
                                     };
    
    NSDictionary *params = @{
                             @"userId" : self.amznUserID,
                             @"option" : @"SetColor",
                             @"appliance" : paramAppliance
                             };
    
        [self transferHttpSessionWithParameter:params success:success failure:failure];
}

-(void) setLightTemperature:(ColorLight *)light success:(successBlock)success failure:(failureBlock)failure{
    NSString *devId = light.deviceInfo.deviceID;
    NSDictionary *paramTemperature = @{
                                       @"value" : [NSNumber numberWithUnsignedInteger:light.Color_Temp]
                                       };
    NSDictionary *paramAppliance = @{
                                     @"applianceId" : devId,
                                     @"colorTemperature" : paramTemperature
                                     };
    NSDictionary *params = @{
                             @"userId" : self.amznUserID,
                             @"option" : @"SetColorTemperature",
                             @"appliance" : paramAppliance
                             };
        [self transferHttpSessionWithParameter:params success:success failure:failure];
}

-(void) setLightBrightness:(ColorLight *)light success:(successBlock)success failure:(failureBlock)failure{
    NSString *devId = light.deviceInfo.deviceID;
    
    NSDictionary *paramBrightness = @{
                                      @"value": [NSNumber numberWithUnsignedInteger:light.Color_Brightness]
                                      };
    NSDictionary *paramAppliance = @{
                                     @"applianceId" : devId,
                                     @"percentageState" : paramBrightness
                                     };
    NSDictionary *params = @{
                             @"userId" : self.amznUserID,
                             @"option" : @"SetPercentage",
                             @"appliance" : paramAppliance
                             };
        [self transferHttpSessionWithParameter:params success:success failure:failure];
}

-(void)addDevice:(DeviceInfo *)devInfo{
    NSArray *paramApplianceTypes = [[NSArray alloc] initWithObjects:@"LIGHT", nil];
    
    NSDictionary *paramDevice = @{
                                  @"applianceId": devInfo.deviceID,
                                  @"applianceTypes" : paramApplianceTypes,
                                  @"friendlyName" : devInfo.name,
                                  @"friendlyDescription" : devInfo.desc,
                                  @"macAddr" : devInfo.macAddr
                                  };
    NSArray *paramAppliances = [[NSArray alloc] initWithObjects:paramDevice, nil];
    NSDictionary *params = @{
                             @"userId" : self.amznUserID,
                             @"option" : @"AddDevice",
                             @"appliances" : paramAppliances
                             };
    
    [self transferHttpSessionWithParameter:params];
}

-(void)delDevice:(DeviceInfo *)devInfo {
    NSDictionary *paramAppliance = @{
                                     @"applianceId": devInfo.deviceID
                                     };
    NSDictionary *params = @{
                             @"userId": self.amznUserID,
                             @"option": @"DelDevice",
                             @"appliance": paramAppliance
                             };
    [self transferHttpSessionWithParameter:params];
}

-(void)updateDeviceInfo:(DeviceInfo *)devInfo {
    NSDictionary *paramAppliance = @{
                                     @"applianceId": devInfo.deviceID,
                                     @"friendlyName": devInfo.name,
                                     @"friendlyDescription": devInfo.desc
                                     };
    NSDictionary *params = @{
                            @"userId": self.amznUserID,
                            @"option": @"UpdateDevInfo",
                            @"appliance": paramAppliance
                            };
    [self transferHttpSessionWithParameter:params];
}

-(void) transferHttpSessionWithParameter:(NSDictionary *)params {
    [_httpSessionManager POST:self.apiGateWayURL parameters:params
                      success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                          DebugLog(@"ok");
                          [_delegate transferSuccess];
                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          DebugLog(@"%@---", error);
                          [_delegate transferFailWithMsg:error];
                      }];
    
    
}



-(void) transferHttpSessionWithParameter:(NSDictionary *)params
                                 success:(void (^)( id response))success
                                 failure:(void (^)( id response))failure{
    [_httpSessionManager POST:self.apiGateWayURL parameters:params
                      success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                          DebugLog(@"ok");
                          success(responseObject);
                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          DebugLog(@"%请求失败@---", error);
                          failure(error);
                      }];
}

@end
