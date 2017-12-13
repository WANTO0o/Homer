//
//  MenuView.h
//  gradeSystem
//
//  Created by jery on 16/1/4.
//  Copyright © 2016年 J.C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property(strong, nonatomic)UIView *view;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)MenuOptionsCount:(NSArray *)countArray;

@end
