//
//  PassWordTool.h
//  aba
//
//  Created by CY on 16/1/9.
//  Copyright © 2016年 aba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassWordTool : NSObject
/**
 *    @brief    存储密码
 *
 *    @param     password     密码内容
 */
+(void)savePassWord:(NSString *)password;

/**
 *    @brief    读取密码
 *
 *    @return    密码内容
 */
+(id)readPassWord;


/**
 *    @brief    存储账号密码
 *
 *    @param     password     密码内容
 */
+(void)saveUserName:(NSString *)userName PassWord:(NSString *)password;

/**
 *    @brief    读取密码
 *
 *    @return    密码内容
 */
+(id)readUserName;

/**
 *    @brief    删除用户数据
 */
+(void)deleteUserInfo;
@end
