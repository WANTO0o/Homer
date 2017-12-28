//
//  ColorPickerController.h
//  linkuslight
//
//  Created by aba on 2017/12/28.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate

-(void)pickedColor:(UIColor*)selectedColor;

@end

@interface ColorPickerController : UIViewController

#pragma mark - 属性列表
// xib上的imgView
@property (nonatomic,retain) IBOutlet UIImageView *imgView;
// 代理用weak
@property (weak) id<ColorPickerDelegate> pickedColorDelegate;

#pragma mark - 方法列表
// 核心,根据位图引用 创建基于该位图的上下文对象
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)inImage;
// 核心,根据触摸点,从上下文中取出对应位置像素点的颜色值
- (UIColor*) getPixelColorAtLocation:(CGPoint)point;

@end
