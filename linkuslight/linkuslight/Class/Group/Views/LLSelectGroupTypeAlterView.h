//
//  LLSelectGroupTypeAlterView.h
//  linkuslight
//
//  Created by Aba on 17/11/4.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^cancelSelectGroupTypeBlock)();

//确定按钮点击事件
typedef void(^sureSelectGroupTypeBlock)(NSInteger selectDeviceTag);

@interface LLSelectGroupTypeAlterView : UIView

@property(nonatomic,copy)cancelSelectGroupTypeBlock cancel_block;
@property(nonatomic,copy)sureSelectGroupTypeBlock sure_block;

/**
 *
 *  @param title       标题
 *  @param content     内容
 *  @param sure        确定按钮内容
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return SZKAlterView
 */
- (instancetype)initWithTitle:(NSString *)title
                        SureTitle:(NSString *)sureTitle
                    CancelBtClcik:(cancelSelectGroupTypeBlock)cancelBlock
                      SureBtClcik:(sureSelectGroupTypeBlock)sureBlock;

- (void)showLLAlertView:(UIView*)parentView;


@end
