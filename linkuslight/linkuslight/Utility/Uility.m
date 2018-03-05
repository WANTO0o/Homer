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
@end
