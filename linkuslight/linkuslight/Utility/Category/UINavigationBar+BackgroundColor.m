//
//  UINavigationBar+BackgroundColor.m
//  linkuslight
//
//  Created by Aba on 17/10/25.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <objc/runtime.h>
#import "UINavigationBar+BackgroundColor.h"

@implementation UINavigationBar (BackgroundColor)static char overlayKey;

- (UIView *)overlay
{    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        // insert an overlay into the view hierarchy
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        [self insertSubview:self.overlay belowSubview:self.backIndicatorImage];
        
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
{

    
}

@end
