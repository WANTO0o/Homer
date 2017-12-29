//
//  ColorCircleView.h
//  circle Control
//
//  Created by aba on 17/12/28.
//  Copyright © 2017年 aba. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCenter CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
#define kRadius (self.bounds.size.width * 0.5 - 20)

@interface ColorCircleView : UIView

@property (nonatomic ,copy) void (^colorBlock)(UIColor *);

@end
