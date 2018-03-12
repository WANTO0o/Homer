//
//  LLInputGroupNameAlterView
//
//  Copyright © aba. All rights reserved.
//

#import <UIKit/UIKit.h>

//取消按钮点击事件
typedef void(^cancelInputGroupNameBlock)();

//确定按钮点击事件
typedef void(^sureInputGroupNameBlock)(NSString *groupName);


@interface LLInputGroupNameAlterView : UIView

@property(nonatomic,copy)cancelInputGroupNameBlock cancel_block;
@property(nonatomic,copy)sureInputGroupNameBlock sure_block;
/**
 *
 *  @param title       标题
 *  @param content     内容
 *  @param cancel      取消按钮内容
 *  @param sure        确定按钮内容
 *  @param cancelBlock 取消按钮点击事件
 *  @param sureBlock   确定按钮点击事件
 *
 *  @return SZKAlterView
 */
- (instancetype)initWithTitle:(NSString *)title
                             SureTitle:(NSString *)sureTitle
                    CancelBtClcik:(cancelInputGroupNameBlock)cancelBlock
                      SureBtClcik:(sureInputGroupNameBlock)sureBlock;

- (void)showLLAlertView:(UIView*)parentView;

@end
