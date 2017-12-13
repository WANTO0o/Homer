//
//  LLCircularView.h
//  linkuslight
//
//  Created by aba on 17/11/7.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LULLightSliderType) {
    LULLightSliderTypeWhiteLight,
    LULLightSliderTypeColourLight
};


@protocol LLCircularViewDelegate

- (void)didCircularClicked:(UIColor*)selectedColor Value:(int)currentValue;

@end

@interface LLCircularView : UIControl

@property (nonatomic,retain) id<LLCircularViewDelegate> delegate;

@property (nonatomic, assign) int lineWidth;
@property (nonatomic, assign) NSInteger minimumValue;
@property (nonatomic, assign) NSInteger maximumValue;
@property (nonatomic, assign) int currentValue;

@property (nonatomic, strong) UIColor *filledColor;
@property (nonatomic, strong) UIColor *unfilledColor;

@property (nonatomic, strong) UIFont *labelFont;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIImageView *pointerImageView;
@property (nonatomic) LULLightSliderType LightType;

@end
