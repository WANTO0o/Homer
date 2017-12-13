//
//  numberBOOL.h
//  yjl
//
//  Created by aba on 15/11/20.
//  Copyright © 2015年 yanming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface numberBOOL : NSObject

#pragma 正则匹配手机号

+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma 正则匹配用户密码6-12位数字和字母组合

+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配用户姓名,1至3位的中文

+ (BOOL)checkUserNameChinese : (NSString *) userName;


#pragma 正则匹配用户身份证号

+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma 正则匹员工号,12位的数字

+ (BOOL)checkEmployeeNumber : (NSString *) number;

#pragma 正则匹配URL

+ (BOOL)checkURL : (NSString *) url;

#pragma 匹配验证码

+ (BOOL)checkPassCode:(NSString *) passcode;

#pragma 匹配实数

+ (BOOL)checkeDecimalNumber:(NSString *) number;
//

@end
