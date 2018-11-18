//
//  AlarmClockEditViewController.h
//  linkuslight
//
//  Created by Zex on 2018/11/3.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlarmClockEditViewController : UIViewController

@property (nonatomic, copy) void(^block)(ClockModel *model);

@property (nonatomic, copy) ClockModel *model;

@end

NS_ASSUME_NONNULL_END
