//
//  NSObject+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

#pragma mark Tip M
+ (NSString *)tipFromError:(NSError *)error;
+ (BOOL)showError:(NSError *)error;
+ (void)showHudTipStr:(NSString *)tipStr;
+ (void)showStatusBarQueryStr:(NSString *)tipStr;
+ (void)showStatusBarSuccessStr:(NSString *)tipStr;
+ (void)showStatusBarErrorStr:(NSString *)errorStr;
+ (void)showStatusBarError:(NSError *)error;

#pragma mark BaseURL
+ (NSString *)baseURLStr;
+ (BOOL)baseURLStrIsTest;
+ (void)changeBaseURLStrToTest:(BOOL)isTest;

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName;

#pragma mark NetError
-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

@end
