//
//  LLInputGroupNameAlterView.m
//
//  Copyright © aba. All rights reserved.
//

#import "LLInputGroupNameAlterView.h"

@interface  LLInputGroupNameAlterView()
//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UITextField *inputTextField;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;

@end

@implementation LLInputGroupNameAlterView

#pragma mark----实现类方法
- (instancetype)initWithTitle:(NSString *)title
                         SureTitle:(NSString *)sureTitle
                    CancelBtClcik:(cancelInputGroupNameBlock)cancelBlock
                      SureBtClcik:(sureInputGroupNameBlock)sureBlock
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.4];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, 183);
        self.alertView.layer.position = self.center;
        self.sure_block = sureBlock;
        self.cancel_block = cancelBlock;
        [self addSubview:self.alertView];

        self.titleLbl = [self GetAdaptiveLable:CGRectMake(27, 24, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
        self.titleLbl.textAlignment = NSTextAlignmentLeft;
        self.titleLbl.font = [UIFont systemFontOfSize:16];
        self.titleLbl.textColor = [UIColor darkGrayColor];
        [self.alertView addSubview:self.titleLbl];
        
        /*CGFloat titleW = self.titleLbl.bounds.size.width;
        CGFloat titleH = self.titleLbl.bounds.size.height;
        
        self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*XLSpace, titleW, titleH);*/
        
        self.inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(27, 70, AlertW-27*2, 30)];
        self.inputTextField.borderStyle = UITextBorderStyleNone;
        self.inputTextField.backgroundColor = [UIColor whiteColor];
        self.inputTextField.font = [UIFont systemFontOfSize:18];
        self.inputTextField.textColor = [UIColor blackColor];
        [self.alertView addSubview:self.inputTextField];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = CGRectMake(27, 100, AlertW-27*2, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.cancleBtn.frame = CGRectMake(AlertW-39, 11, 28, 28);
        [self.cancleBtn setImage:[UIImage imageNamed:@"group_tab_close"] forState:UIControlStateNormal];
        [self.cancleBtn setTintColor:[UIColor darkGrayColor]];
        self.cancleBtn.tag = 1;
        [self.cancleBtn addTarget:self action:@selector(cancelBtClick:) forControlEvents:UIControlEventTouchUpInside];
        /*UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.cancleBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        self.cancleBtn.layer.mask = maskLayer;*/
        [self.alertView addSubview:self.cancleBtn];
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.sureBtn.frame = CGRectMake(27, 118, AlertW-27*2, 50);
        [self.sureBtn setBackgroundColor:[UIColor colorWithRed:111/255.0 green:172/255.0 blue:242/255.0 alpha:1/1.0]];
        [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        self.sureBtn.tag = 2;
        self.sureBtn.layer.cornerRadius = 5.0;
        
        [self.sureBtn addTarget:self action:@selector(sureBtClick:) forControlEvents:UIControlEventTouchUpInside];
        /*UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.sureBtn.bounds;
        maskLayer.path = maskPath1.CGPath;
        self.sureBtn.layer.mask = maskLayer1;*/
        [self.alertView addSubview:self.sureBtn];
        
        //CGRectGetMaxY(self.cancleBtn.frame):
        //计算高度
        CGFloat alertHeight = 183;//CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        
    }
    
    return self;
    
}

#pragma mark--给属性重新赋值

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 弹出 -
- (void)showLLAlertView:(UIView*)parentView
{
    //UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [parentView addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark----取消按钮点击事件
- (void)cancelBtClick:(NSObject*)sender
{
    [self removeFromSuperview];
    if (self.cancel_block) {
        self.cancel_block();
    }
}
#pragma mark----确定按钮点击事件
- (void)sureBtClick:(NSObject*)sender
{
    [self removeFromSuperview];
    if (self.sure_block) {
        self.sure_block();
    }
    
}


@end
