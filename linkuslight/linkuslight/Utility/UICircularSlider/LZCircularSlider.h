//
//  UICircularSlider.h
//  linkuslight
//
//  Created by Aba on 17/10/29.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZCircularSlider : UIControl

@property(nonatomic,assign)int lineWidth;
@property(nonatomic,assign)NSInteger minimumValue;
@property(nonatomic,assign)NSInteger maximumValue;
@property(nonatomic,assign)int currentValue;

@property (nonatomic, strong) UIColor *filledColor;
@property (nonatomic, strong) UIColor *unfilledColor;

@property(nonatomic,strong)UIFont *labelFont;

@end
