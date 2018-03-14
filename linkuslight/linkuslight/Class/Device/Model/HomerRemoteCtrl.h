//
//  HomerRemoteCtrl.h
//  linkuslight
//
//  Created by Zex on 2018/1/6.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorLight.h"

@protocol HomerRemoteCtrlDelegate <NSObject>

@required
-(void) remoteSearchDevice:(NSMutableArray *)devList;
-(void) transferSuccess;
-(void) transferFailWithMsg:(NSError *)failMsg;

@end

@interface HomerRemoteCtrl : NSObject

+(HomerRemoteCtrl *) sharedManager;

@property (assign) id<HomerRemoteCtrlDelegate> delegate;

-(void) searchDevice;
- (void)getDeviceStatus:(NSString *)deviceId
                success:(void (^)( id response))success
                failure:(void (^)( id response))failure;

-(void) turnLight:(NSString *)lightID
            State:(Boolean)state
          success:(successBlock)success
          failure:(failureBlock)failure;

-(void) setLightHSV:(ColorLight *)light
            success:(successBlock)success
            failure:(failureBlock)failure;

-(void) setLightTemperature:(ColorLight *)light
                    success:(successBlock)success
                    failure:(failureBlock)failure;

-(void) setLightBrightness:(ColorLight *)light
                   success:(successBlock)success
                   failure:(failureBlock)failure;

// 以下方法可基于设备通用，因此不传入ColorLight
-(void) addDevice:(DeviceInfo *)devInfo;
-(void) delDevice:(DeviceInfo *)devInfo;
-(void) updateDeviceInfo:(DeviceInfo *)devInfo;

@end
