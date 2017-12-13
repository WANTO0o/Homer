//
//  PassWordTool.m
//  aba
//
//  Created by CY on 16/1/9.
//  Copyright © 2016年 aba. All rights reserved.
//

#import "PassWordTool.h"
#import "KeychainTool.h"

@implementation PassWordTool
static NSString * const KEY_IN_KEYCHAIN = @"com.yijiale.app.userinfo";
static NSString * const KEY_USERNAME = @"com.yijiale.app.userid";
static NSString * const KEY_PASSWORD = @"com.yijiale.app.password";

+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [KeychainTool save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[KeychainTool load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)saveUserName:(NSString *)userName PassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:userName forKey:KEY_USERNAME];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [KeychainTool save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

/**
 *    @brief    读取用户名
 *
 *    @return    密码内容
 */
+(id)readUserName
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[KeychainTool load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_USERNAME];
}

/**
 *    @brief    删除用户数据
 */
+(void)deleteUserInfo
{
    [KeychainTool delete:KEY_IN_KEYCHAIN];
}

@end
