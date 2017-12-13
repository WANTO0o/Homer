//
//  LULSessionManager.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LOLUser.h"
#import "LULSessionManager.h"

@interface LULSessionManager()

@property (nonatomic,retain) LOLUser *user;

@end

@implementation LULSessionManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        //do something
        self.user = nil;
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

@end
