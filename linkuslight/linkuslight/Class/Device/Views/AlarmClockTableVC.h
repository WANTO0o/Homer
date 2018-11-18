//
//  AlarmClockTableVC.h
//  linkuslight
//
//  Created by Zex on 2018/10/29.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlarmClockTableVC : UIViewController

@property (nonatomic, copy) void(^block)(NSMutableArray *clockArray);

@property (nonatomic, copy) NSMutableArray *clockArray;

@end

NS_ASSUME_NONNULL_END
