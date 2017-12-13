//
//  HLAlertView.h
//  linkuslight
//
//  Created by Aba on 17/10/28.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertResult)(NSInteger index);

@interface HLAlertView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showXLAlertView;

@end
