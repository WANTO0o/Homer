//
//  MBProgressHUD+Add.m
//  视频客户端
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showMsg:(NSString *)msg imgName:(NSString *)imgName duration:(CGFloat)time toView:(UIView *)view
{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 显示模式,改成customView,即显示自定义图片(mode设置,必须写在customView赋值之前)
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.backgroundColor = [UIColor whiteColor];
    //UIView *centerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width*0.65, kScreen_Width*0.65*0.66)];
    //[centerview setBackgroundColor:[UIColor whiteColor]];
    //centerview.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];

    //[centerview addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]]];
    // 设置要显示 的自定义的图片
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width*0.65, kScreen_Width*0.65*0.66)];
    img.image=[UIImage imageNamed:imgName];
    img.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    hud.customView = img;
    //hud.customView.alpha = 1.0;
    //hud.activityIndicatorColor = [UIColor whiteColor];
    //hud.backgroundColor = [UIColor grayColor];

    //hud.alpha = 0.85;
    //hud.opacity = 0.65;
    // 显示的文字,比如:加载失败...加载中...
    [hud setLabelText:@" "];
    hud.detailsLabel.text = msg;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.detailsLabel.textColor = [UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0];
    // 标志:必须为YES,才可以隐藏,  隐藏的时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:time];
}

@end
