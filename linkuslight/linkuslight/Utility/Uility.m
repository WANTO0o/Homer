//
//  Uility.m
//  linkuslight
//
//  Created by Mac on 2018/3/5.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import "Uility.h"
#import "MBProgressHUD+Add.h"
#import "MBProgressHUD.h"
@implementation Uility
#pragma mark - LoadingHud
+ (void)showLoadingToView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)showLoadingToView02:(UIView *)view{
    [MBProgressHUD showMessag:@"加载中..." toView:view];
}

+ (void)hideLoadingView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    [MBProgressHUD showError:error toView:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [MBProgressHUD showSuccess:success toView:view];
}

+ (void)showMessag:(NSString *)message toView:(UIView *)view{
    [MBProgressHUD showMessag:message toView:view];
}

+ (void)setAutoLogin:(BOOL)autoLogin{
    [[NSUserDefaults standardUserDefaults] setObject:@(autoLogin) forKey:@"autoLogin"];
}

+ (BOOL)getAutoLogin{
   return  [[NSUserDefaults standardUserDefaults]  objectForKey:@"autoLogin"];
}

//圆心到点的距离>?半径
+ (BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect {
    CGFloat radius = rect.size.width/2.0;
    CGPoint center = CGPointMake(rect.origin.x + radius, rect.origin.y + radius);
    double dx = fabs(point.x - center.x);
    double dy = fabs(point.y - center.y);
    double dis = hypot(dx, dy);
//    DebugLog(@"%ld",dis <= radius);
    return dis <= radius;
    
}
@end
