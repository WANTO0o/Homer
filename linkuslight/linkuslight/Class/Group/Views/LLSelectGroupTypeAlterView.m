//
//  LLSelectGroupTypeAlterView.m
//  linkuslight
//
//  Created by Aba on 17/11/4.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LLSelectGroupTypeAlterView.h"

@interface LLSelectGroupTypeAlterView()

//弹窗
@property (nonatomic,retain) UIView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//竖线
@property (nonatomic,retain) UIView *verLineView;
//彩灯选中按钮
@property (nonatomic,retain) UIButton *mutlightBtn;
@property (nonatomic,retain) UIButton *mutlightBCBtn;

//白灯选中按钮
@property (nonatomic,retain) UIButton *whitelightBtn;
@property (nonatomic,retain) UIButton *whitelightBCBtn;

//插座选中按钮
@property (nonatomic,retain) UIButton *socketBtn;
@property (nonatomic,retain) UIButton *socketBCBtn;

@property (nonatomic,assign) NSInteger selectDeviceTag;

@end

@implementation LLSelectGroupTypeAlterView
#pragma mark----实现类方法
- (instancetype)initWithTitle:(NSString *)title
                    SureTitle:(NSString *)sureTitle
                CancelBtClcik:(cancelSelectGroupTypeBlock)cancelBlock
                  SureBtClcik:(sureSelectGroupTypeBlock)sureBlock
{
    if (self == [super init]) {
        
        _selectDeviceTag=0;
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, AlertH);
        self.alertView.layer.position = self.center;
        self.sure_block = sureBlock;
        self.cancel_block = cancelBlock;
        [self addSubview:self.alertView];
        
        self.titleLbl = [self GetAdaptiveLable:CGRectMake(27, 24, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
        self.titleLbl.textAlignment = NSTextAlignmentLeft;
        self.titleLbl.font = [UIFont systemFontOfSize:15];
        self.titleLbl.textColor = [UIColor darkGrayColor];
        [self.alertView addSubview:self.titleLbl];
        
        //彩灯
        UIImageView *mutlightimg = [[UIImageView alloc] initWithFrame:CGRectMake(27, 73, 47, 47)];
        mutlightimg.backgroundColor = [UIColor clearColor];
        mutlightimg.image = [UIImage imageNamed:@"group_icon_colour"];
        [self.alertView addSubview:mutlightimg];
        
        UILabel *mutlightLab = [self GetAdaptiveLable:CGRectMake(87, 76, 150, 47) AndText:title andIsTitle:YES];
        mutlightLab.textAlignment = NSTextAlignmentLeft;
        mutlightLab.font = [UIFont systemFontOfSize:15];
        mutlightLab.textColor = [UIColor darkGrayColor];
        mutlightLab.text = NSLocalizedString(@"dev_colorlight", nil);
        [self.alertView addSubview:mutlightLab];
        
        self.mutlightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.mutlightBtn.frame = CGRectMake(AlertW-55, 89, 23, 23);
        [self.mutlightBtn setTitle:@"○" forState:UIControlStateNormal];
        [self.mutlightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.mutlightBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        self.mutlightBtn.tag = 111;
        [self.mutlightBtn addTarget:self action:@selector(didDeviceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.mutlightBtn];
        self.mutlightBCBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.mutlightBCBtn.frame = CGRectMake(0, 73, AlertW, 47);
        [self.mutlightBCBtn setTitle:@"" forState:UIControlStateNormal];
        [self.mutlightBCBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.mutlightBCBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        self.mutlightBCBtn.tag = 111;
        [self.mutlightBCBtn addTarget:self action:@selector(didDeviceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.mutlightBCBtn];
        
        UIView *mutlightlineView = [[UIView alloc] init];
        mutlightlineView.frame = CGRectMake(27, 123, AlertW-27*2, 1);
        mutlightlineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:mutlightlineView];
        
        //白灯
        UIImageView *whitelightimg = [[UIImageView alloc] initWithFrame:CGRectMake(27, mutlightlineView.frame.origin.y+7, 47, 47)];
        whitelightimg.backgroundColor = [UIColor clearColor];
        whitelightimg.image = [UIImage imageNamed:@"group_icon_white"];
        [self.alertView addSubview:whitelightimg];
        
        UILabel *whitelightLab = [self GetAdaptiveLable:CGRectMake(87, mutlightlineView.frame.origin.y+10, 150, 47) AndText:title andIsTitle:YES];
        whitelightLab.textAlignment = NSTextAlignmentLeft;
        whitelightLab.font = [UIFont systemFontOfSize:15];
        whitelightLab.textColor = [UIColor darkGrayColor];
        whitelightLab.text = NSLocalizedString(@"dev_whitelight", nil);
        [self.alertView addSubview:whitelightLab];
        
        self.whitelightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.whitelightBtn.frame = CGRectMake(AlertW-55, mutlightlineView.frame.origin.y+19, 23, 23);
        [self.whitelightBtn setTitle:@"○" forState:UIControlStateNormal];
        [self.whitelightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.whitelightBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        self.whitelightBtn.tag = 112;
        [self.whitelightBtn addTarget:self action:@selector(didDeviceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.whitelightBtn];
        self.whitelightBCBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.whitelightBCBtn.frame = CGRectMake(0, mutlightlineView.frame.origin.y+7, AlertW, 47);
        [self.whitelightBCBtn setTitle:@"" forState:UIControlStateNormal];
        [self.whitelightBCBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.whitelightBCBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        self.whitelightBCBtn.tag = 112;
        [self.whitelightBCBtn addTarget:self action:@selector(didDeviceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.whitelightBCBtn];
        UIView *whitelightlineView = [[UIView alloc] init];
        whitelightlineView.frame = CGRectMake(27, whitelightimg.frame.origin.y+whitelightimg.frame.size.height+3, AlertW-27*2, 1);
        whitelightlineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:whitelightlineView];
        
        //开关
        UIImageView *socketimg = [[UIImageView alloc] initWithFrame:CGRectMake(27, whitelightlineView.frame.origin.y+7, 47, 47)];
        socketimg.backgroundColor = [UIColor clearColor];
        socketimg.image = [UIImage imageNamed:@"group_icon_socket"];
        [self.alertView addSubview:socketimg];
        
        UILabel *socketLab = [self GetAdaptiveLable:CGRectMake(87, whitelightlineView.frame.origin.y+10, 150, 47) AndText:title andIsTitle:YES];
        socketLab.textAlignment = NSTextAlignmentLeft;
        socketLab.font = [UIFont systemFontOfSize:15];
        socketLab.textColor = [UIColor darkGrayColor];
        socketLab.text = NSLocalizedString(@"dev_plug", nil);
        [self.alertView addSubview:socketLab];
        
        self.socketBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.socketBtn.frame = CGRectMake(AlertW-55, whitelightlineView.frame.origin.y+19, 23, 23);
        [self.socketBtn setTitle:@"○" forState:UIControlStateNormal];
        [self.socketBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.socketBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        self.socketBtn.tag = 113;
        [self.socketBtn addTarget:self action:@selector(didDeviceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.socketBtn];
        self.socketBCBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.socketBCBtn.frame = CGRectMake(0, whitelightlineView.frame.origin.y+7, AlertW, 47);
        [self.socketBCBtn setTitle:@"" forState:UIControlStateNormal];
        [self.socketBCBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.socketBCBtn.titleLabel.font = [UIFont systemFontOfSize:23];
        self.socketBCBtn.tag = 113;
        [self.socketBCBtn addTarget:self action:@selector(didDeviceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.socketBCBtn];
        
        UIView *socketlineView = [[UIView alloc] init];
        socketlineView.frame = CGRectMake(27, socketimg.frame.origin.y+whitelightimg.frame.size.height+3, AlertW-27*2, 1);
        socketlineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:socketlineView];
        
        self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.cancleBtn.frame = CGRectMake(AlertW-39, 11, 28, 28);
        [self.cancleBtn setImage:[UIImage imageNamed:@"group_tab_close"] forState:UIControlStateNormal];
        [self.cancleBtn setTintColor:[UIColor darkGrayColor]];
        self.cancleBtn.tag = 108;
        [self.cancleBtn addTarget:self action:@selector(cancelBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.cancleBtn];
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.sureBtn.frame = CGRectMake(27, AlertH-68, AlertW-27*2, 40);
        [self.sureBtn setBackgroundColor:[UIColor colorWithRed:111/255.0 green:172/255.0 blue:242/255.0 alpha:1/1.0]];
        [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        self.sureBtn.tag = 109;
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
        /*CGFloat alertHeight = 424;//CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;*/
        
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
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
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
- (void)didDeviceButtonClicked:(id)sender {
    
    UIButton *selBtn = (UIButton*)sender;
    
    _selectDeviceTag = selBtn.tag;
    
    switch (_selectDeviceTag) {
        case 111:
            [self.mutlightBtn setTitle:@"●" forState:UIControlStateNormal];
            [self.mutlightBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:205/255.0 blue:0/255.0 alpha:1/1.0] forState:UIControlStateNormal];
            
            [self.whitelightBtn setTitle:@"○" forState:UIControlStateNormal];
            [self.whitelightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [self.socketBtn setTitle:@"○" forState:UIControlStateNormal];
            [self.socketBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 112:
            [self.mutlightBtn setTitle:@"○" forState:UIControlStateNormal];
            [self.mutlightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [self.whitelightBtn setTitle:@"●" forState:UIControlStateNormal];
            [self.whitelightBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:205/255.0 blue:0/255.0 alpha:1/1.0] forState:UIControlStateNormal];
            
            [self.socketBtn setTitle:@"○" forState:UIControlStateNormal];
            [self.socketBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 113:
            [self.mutlightBtn setTitle:@"○" forState:UIControlStateNormal];
            [self.mutlightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [self.whitelightBtn setTitle:@"○" forState:UIControlStateNormal];
            [self.whitelightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [self.socketBtn setTitle:@"●" forState:UIControlStateNormal];
            [self.socketBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:205/255.0 blue:0/255.0 alpha:1/1.0] forState:UIControlStateNormal];
            break;
        default:
            break;
    }

}


- (void)cancelBtClick:(id)sender
{
    [self removeFromSuperview];
    self.cancel_block();
}
#pragma mark----确定按钮点击事件
- (void)sureBtClick:(id)sender
{
    if (_selectDeviceTag==0) {
        kTipAlert(@"请您选择组设备类型");
    }
    
    [self removeFromSuperview];
    self.sure_block(_selectDeviceTag);
    
}
@end
