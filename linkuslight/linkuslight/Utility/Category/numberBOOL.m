//
//  numberBOOL.m
//  yjl
//
//  Created by aba on 15/11/20.
//  Copyright © 2015年 yanming. All rights reserved.
//

#import "numberBOOL.h"

@implementation numberBOOL

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^((1[0-9][0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma 正则匹配用户密码6-12位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    //NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,12}";
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //BOOL isMatch = [pred evaluateWithObject:password];
    BOOL isMatch = password.length == 0 ? NO : YES;
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,1至3位的中文
+ (BOOL)checkUserNameChinese : (NSString *) userName{
    NSString *pattern=@"^[一-龥]{1,3}";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch=[pred evaluateWithObject:userName];
    return isMatch;
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma 匹配验证码
+ (BOOL)checkPassCode:(NSString *) passcode
{
    //NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,12}";
    //NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //BOOL isMatch = [pred evaluateWithObject:password];
    BOOL isMatch = passcode.length == 6 ? YES : NO;
    return isMatch;
    
}

#pragma 匹配实数
+ (BOOL)checkeDecimalNumber:(NSString*) number
{
    NSString *pattern = @"^([1-9][0-9]*)+(.[0-9]{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

@end
