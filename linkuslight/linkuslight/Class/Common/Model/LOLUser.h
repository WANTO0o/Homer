//
//  LOLUser.h
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LoginWithAmazon/LoginWithAmazon.h>

@interface LOLUser : NSObject

@property (nonatomic,copy)NSString *userID;

@property (nonatomic, strong) AMZNUser *amznUser;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userEmail;

@end
