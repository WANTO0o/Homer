//
//  LULSessionManager.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LOLUser.h"
#import "LULSessionManager.h"
#import <AFNetworking.h>

@interface LULSessionManager()

@property (nonatomic,retain) LOLUser *user;
@property (nonatomic, copy) NSString *apiGateWayURL;
@property (nonatomic, assign) AFHTTPSessionManager *httpSessionManager;

@end

@implementation LULSessionManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        //do something
        self.user = nil;
        self.apiGateWayURL = @"https://dnvh8mdbub.execute-api.us-east-1.amazonaws.com/Stage1";
        
        self.httpSessionManager = [AFHTTPSessionManager manager];
        self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer]; // 设置JSON序列化
        self.httpSessionManager.requestSerializer.timeoutInterval = 10.f; // 设置超时时间10s
    }
    
    return self;
}

+ (instancetype)manager
{
    static id manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LULSessionManager alloc] init];
    });
    
    return manager;
}

- (void)SaveUserData:(LOLUser *)user
{
    _user = user;
}

- (LOLUser*)GetUserData
{
    return _user;
}

- (Boolean)NeedLogin
{
    if (!_user) {
        return true;
    } else {
        return false;
    }
}

-(void) addUser:(LOLUser *)userInfo success:(void (^)(id))success failure:(void (^)(id))failure
{
    NSLog(@"turnLight");
    
    NSString *optionStr = @"";
    
    
//    NSDictionary *paramAppliance = @{
//                                     @"applianceId" : userInfo.userID,
//                                     @"applianceTypes" : @"whitelight"
//                                     };
//    NSDictionary *params = @{
//                             @"userId" : userInfo.userID,
//                             @"option" : optionStr,
//                             @"appliance" : paramAppliance
//                             };
//
//    [self transferHttpSessionWithParameter:params success:success failure:failure];
}

-(void) transferHttpSessionWithParameter:(NSDictionary *)params
                                 success:(void (^)( id response))success
                                 failure:(void (^)( id response))failure{
    [_httpSessionManager POST:self.apiGateWayURL parameters:params
                      success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                          DebugLog(@"httpResponse success: %@", responseObject);
                          if(success != nil) {
                              success(responseObject);
                          }
                      }  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          DebugLog(@"httpResponse fail: %@", error);
                          if (failure != nil) {
                              failure(error);
                          }
                      }];
}

@end
