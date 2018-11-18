//
//  Uility.h
//  linkuslight
//
//  Created by Mac on 2018/3/5.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Uility : NSObject

/**
 添加加载视图
 @param view 被添加的视图
 */
+ (void)showLoadingToView:(UIView *)view;
/**
 隐藏加载视图
 @param view 被添加的视图
 */
+ (void)hideLoadingView:(UIView *)view;
+ (void)showLoadingToView02:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showMessag:(NSString *)message toView:(UIView *)view;


/**
 设置是否自动登录
 */
+ (void)setAutoLogin:(BOOL)autoLogin;

/**
 获取自动登录状态
 */
+ (BOOL)getAutoLogin;


/**
圆心到点的距离>?半径
 */
+ (BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect;

// 将当前时间字符串转为UTCDate, 输入：2018-03-27 07:44:05
+ (NSDate *)UTCDateFromLocalString:(NSString *)localString;

@end
