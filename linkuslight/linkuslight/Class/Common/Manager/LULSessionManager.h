//
//  LULSessionManager.h
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LOLUser.h"
#import <Foundation/Foundation.h>

@interface LULSessionManager : NSObject

+ (instancetype)manager;

- (void)SaveUserData:(LOLUser *)user;
- (LOLUser*)GetUserData;

- (Boolean)NeedLogin;


@end
