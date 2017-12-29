//
//  LLCircularView.m
//  linkuslight
//
//  Created by aba on 17/11/7.
//  Copyright © 2017年 linkustek. All rights reserved.
//
#import "UIView+Layout.h"
#import "UIColor-Extensions.h"
#import "UIImage-Extensions.h"

#import "LLCircularView.h"


#define  ToRad(ang)  ((M_PI *(ang)) / 180)//度数转化为弧度
#define  ToAng(rad)  ( (180.0 * (rad)) / M_PI )//弧度转化为度数
#define SQR(x)		 ( (x) * (x) )g

@interface LLCircularView ()
{
    CGFloat angle;
    CGFloat radius;
    CGFloat currentRadian;
    float width;
    float height;
    char *imgPixel;

    
}

@property (nonatomic, retain) UIImage* crycleImg;

@end

@implementation LLCircularView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    
    if (self) {
        angle = 130;
        radius = self.frame.size.width/2-20;
        _LightType = LULLightSliderTypeWhiteLight;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (_LightType == LULLightSliderTypeWhiteLight) {
        [self drawWhiteCircle:rect];
    } else {
        [self drawColourCircle:rect];
    }
}


-(void)drawWhiteCircle:(CGRect)rect {
    
    if (!self.progressLayer) {
        
    //创建背景圆环
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    //清空填充色
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    //设置画笔颜色 即圆环背景色
    trackLayer.strokeColor = [UIColor clearColor].CGColor;
    trackLayer.lineWidth = 40;
    //设置画笔路径
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 20 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 20 startAngle:M_PI_4*2.7 endAngle:M_PI_4*1.3 clockwise:YES];
    
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    path.usesEvenOddFillRule = YES;
    //path 决定layer将被渲染成何种形状
    trackLayer.path = path.CGPath;
    [self.layer addSublayer:trackLayer];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CALayer *gradientLayer = [CALayer layer];
    gradientLayer.frame = self.bounds;
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, width,  height);
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:1.0 green:0.8023 blue:0.038 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.9968 green:0.9338 blue:0.3579 alpha:1.0].CGColor];
    [gradientLayer1 setLocations:@[@0.3, @0.7]];
    //startPoint和endPoint属性，他们决定了渐变的方向。这两个参数是以单位坐标系进行的定义，所以左上角坐标是{0, 0}，右下角坐标是{1, 1}
    //startPoint和pointEnd 分别指定颜色变换的起始位置和结束位置.
    //当开始和结束的点的x值相同时, 颜色渐变的方向为纵向变化
    //当开始和结束的点的y值相同时, 颜色渐变的方向为横向变化
    //其余的 颜色沿着对角线方向变化
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(width/2.0, 0, width,  height);
    gradientLayer2.colors = @[(__bridge id)[UIColor colorWithRed:0.9968 green:0.9338 blue:0.3579 alpha:1.0].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    //[gradientLayer2 setLocations:@[@0.3, @0.8,@1]];
    [gradientLayer2 setLocations:@[@0.3, @0.7]];
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(0, 1);
    [gradientLayer addSublayer:gradientLayer2];
    
    [self.layer addSublayer:gradientLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
    _progressLayer.lineWidth = 30;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = path.CGPath;
    gradientLayer.mask = _progressLayer;
    }
    [self drawHandle];
}


-(void)drawColourCircle:(CGRect)rect {
    
    if (!self.progressLayer) {
        
        //创建背景圆环
        CAShapeLayer *trackLayer = [CAShapeLayer layer];
        trackLayer.frame = self.bounds;
        //清空填充色
        trackLayer.fillColor = [UIColor clearColor].CGColor;
        //设置画笔颜色 即圆环背景色
        trackLayer.strokeColor = [UIColor clearColor].CGColor;
        trackLayer.lineWidth = _lineWidth;
        //trackLayer.lineCap = @"round";
        trackLayer.lineCap = kCALineCapRound;
        //设置画笔路径
        //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 20 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:radius startAngle:M_PI_4*2.7 endAngle:M_PI_4*1.3 clockwise:YES];
        
        path.lineJoinStyle = kCGLineCapRound;
        path.lineCapStyle = kCGLineCapRound;
        //path.usesEvenOddFillRule = YES;
        //path 决定layer将被渲染成何种形状
        trackLayer.path = path.CGPath;
        [self.layer addSublayer:trackLayer];
        
        CGFloat width = rect.size.width;
        CGFloat height = rect.size.height;
        
        CALayer *gradientLayer = [CALayer layer];
        gradientLayer.frame = self.bounds;
        
        CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
        gradientLayer1.frame = CGRectMake(width/2.0, 0, width/2.0,  height/2.0);
        gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:0.1255 green:0.9725 blue:0.9961 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0.1333 green:1.0 blue:0.4039 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.8941 green:1.0 blue:0.0392 alpha:1.0].CGColor];
        
        //startPoint和endPoint属性，他们决定了渐变的方向。这两个参数是以单位坐标系进行的定义，所以左上角坐标是{0, 0}，右下角坐标是{1, 1}
        //startPoint和pointEnd 分别指定颜色变换的起始位置和结束位置.
        //当开始和结束的点的x值相同时, 颜色渐变的方向为纵向变化
        //当开始和结束的点的y值相同时, 颜色渐变的方向为横向变化
        //其余的 颜色沿着对角线方向变化
        [gradientLayer1 setLocations:@[@0.2, @0.9]];
        //gradientLayer1.startPoint = CGPointMake(0.2, 0);
        //gradientLayer1.endPoint = CGPointMake(0.2, 0.7);
        gradientLayer1.startPoint = CGPointMake(0, 0);
        gradientLayer1.endPoint = CGPointMake(0, 1);
        [gradientLayer addSublayer:gradientLayer1];
        
        CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
        gradientLayer2.frame = CGRectMake(width/2.0, width/2.0, width/2.0,  height/2.0);
        gradientLayer2.colors = @[(__bridge id)[UIColor colorWithRed:0.9216 green:1.0 blue:0.0353 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.9765 green:0.0 blue:0.0275 alpha:1.0].CGColor];
        //[gradientLayer2 setLocations:@[@0.3, @0.7,@1]];
        [gradientLayer2 setLocations:@[@0.3, @0.7]];
        gradientLayer2.startPoint = CGPointMake(0, 0);
        gradientLayer2.endPoint = CGPointMake(0, 1);
        [gradientLayer addSublayer:gradientLayer2];
        
        CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];
        gradientLayer3.frame = CGRectMake(0, width/2.0, width/2.0,  height/2.0);
        gradientLayer3.colors = @[(__bridge id)[UIColor colorWithRed:0.9804 green:0.0 blue:0.0275 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.8706 green:0.0 blue:1.0 alpha:1.0].CGColor];
        
        gradientLayer3.startPoint = CGPointMake(0.5, 1);
        gradientLayer3.endPoint = CGPointMake(0.5, 0);
        [gradientLayer3 setLocations:@[@0.4,@0.7]];
        [gradientLayer addSublayer:gradientLayer3];
        
        CAGradientLayer *gradientLayer4 = [CAGradientLayer layer];
        gradientLayer4.frame = CGRectMake(0, 0, width/2.0,  height/2.0);
        gradientLayer4.colors = @[(__bridge id)[UIColor colorWithRed:0.7882 green:0.0 blue:0.9922 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.0471 green:0.4235 blue:0.9961 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.1294 green:1.0 blue:0.9882 alpha:1.0].CGColor];
        [gradientLayer4 setLocations:@[@0.1,@0.7]];
        gradientLayer4.startPoint = CGPointMake(0.5, 1);
        gradientLayer4.endPoint = CGPointMake(0.5, 0);
        [gradientLayer addSublayer:gradientLayer4];
        
        [self.layer addSublayer:gradientLayer];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = self.bounds;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
        _progressLayer.lineWidth = _lineWidth;
        _progressLayer.path = path.CGPath;
        _progressLayer.lineCap = kCALineCapRound;
        
        gradientLayer.mask = _progressLayer;
        
        //self.crycleImg = [self imageFromLayer:gradientLayer];
    }
    
    [self drawHandle];
}

/*
-(void)drawColourCircle:(CGRect)rect {
    
    //创建背景圆环
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    //清空填充色
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    //设置画笔颜色 即圆环背景色
    trackLayer.strokeColor = [UIColor clearColor].CGColor;
    trackLayer.lineWidth = _lineWidth;
    //trackLayer.lineCap = @"round";
    trackLayer.lineCap = kCALineCapRound;
    //设置画笔路径
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 20 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 - 20 startAngle:M_PI_4*2.7 endAngle:M_PI_4*1.3 clockwise:YES];

    path.lineJoinStyle = kCGLineCapRound;
    path.lineCapStyle = kCGLineCapRound;
    //path.usesEvenOddFillRule = YES;
    //path 决定layer将被渲染成何种形状
    trackLayer.path = path.CGPath;
    [self.layer addSublayer:trackLayer];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CALayer *gradientLayer = [CALayer layer];
    gradientLayer.frame = self.bounds;
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(width/2.0, 0, width/2.0,  height/2.0);
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:0.7098 green:0.0 blue:0.9059 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.9721 green:0.0304 blue:0.0447 alpha:1.0].CGColor];

    //startPoint和endPoint属性，他们决定了渐变的方向。这两个参数是以单位坐标系进行的定义，所以左上角坐标是{0, 0}，右下角坐标是{1, 1}
    //startPoint和pointEnd 分别指定颜色变换的起始位置和结束位置.
    //当开始和结束的点的x值相同时, 颜色渐变的方向为纵向变化
    //当开始和结束的点的y值相同时, 颜色渐变的方向为横向变化
    //其余的 颜色沿着对角线方向变化
    gradientLayer1.startPoint = CGPointMake(0.2, 0);
    gradientLayer1.endPoint = CGPointMake(0.8, 1);
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(width/2.0, width/2.0, width/2.0,  height/2.0);
    gradientLayer2.colors = @[(__bridge id)[UIColor colorWithRed:0.9721 green:0.1236 blue:0.0983 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:1.0 green:0.906 blue:0.0372 alpha:1.0].CGColor];
    //[gradientLayer2 setLocations:@[@0.3, @0.7,@1]];
    [gradientLayer2 setLocations:@[@0.3, @0.7]];
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(0, 1);
    [gradientLayer addSublayer:gradientLayer2];
    
    CAGradientLayer *gradientLayer3 = [CAGradientLayer layer];
    gradientLayer3.frame = CGRectMake(0, width/2.0, width/2.0,  height/2.0);
    gradientLayer3.colors = @[(__bridge id)[UIColor colorWithRed:0.4549 green:0.9608 blue:0.1098 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.1412 green:0.702 blue:0.8314 alpha:1.0].CGColor];

    gradientLayer3.startPoint = CGPointMake(0.5, 1);
    gradientLayer3.endPoint = CGPointMake(0.5, 0);
    [gradientLayer3 setLocations:@[@0.4,@0.7]];
    [gradientLayer addSublayer:gradientLayer3];
    
    CAGradientLayer *gradientLayer4 = [CAGradientLayer layer];
    gradientLayer4.frame = CGRectMake(0, 0, width/2.0,  height/2.0);
    gradientLayer4.colors = @[(__bridge id)[UIColor colorWithRed:0.1412 green:0.702 blue:0.8314 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:0.7098 green:0.0 blue:0.9059 alpha:1.0].CGColor];
    [gradientLayer4 setLocations:@[@0.2,@0.7]];
    gradientLayer4.startPoint = CGPointMake(0.5, 1);
    gradientLayer4.endPoint = CGPointMake(0.5, 0);
    [gradientLayer addSublayer:gradientLayer4];
    
    [self.layer addSublayer:gradientLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
    _progressLayer.lineWidth = _lineWidth;
    _progressLayer.path = path.CGPath;
    _progressLayer.lineCap = kCALineCapRound;

    gradientLayer.mask = _progressLayer;
    
    [self drawHandle];
}*/

- (void)drawHandle{
    
    CGPoint handleCenter = [self pointFromAngle:angle];
    
    //填充指定的矩形
    
    if (!self.pointerImageView) {
        _pointerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(handleCenter.x-_lineWidth/2, handleCenter.y-_lineWidth/2,30,30)];
        _pointerImageView.image = [UIImage imageNamed:@"pointer_orange"];
        //[self addSubview:_pointerImageView];

    } else {
        //_pointerImageView.frame=CGRectMake(handleCenter.x-_lineWidth/2, handleCenter.y-_lineWidth/2,30,30);
        [self.pointerImageView setFrame:CGRectMake(handleCenter.x-_lineWidth/2, handleCenter.y-_lineWidth/2,30,30)];
    }
    
    if (![self.pointerImageView isDescendantOfView:self]) {
        [self addSubview:_pointerImageView];
    } else {
        [self bringSubviewToFront:_pointerImageView];
    }

    /*
    CGRect frame = self.frame;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGPoint handleCenter =  [self maskPointFromAngle:angle];
    [[UIColor clearColor]set];
    //CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x-_lineWidth/20-10, handleCenter.y-_lineWidth/2-10,10,10));
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x-10, handleCenter.y-10,10,10));

    //填充指定的矩形
    //NSLog(@"frame :%f,%f",frame.size.width,frame.size.height);
    //NSLog(@"handleCenter :%f,%f",handleCenter.x,handleCenter.y);
    
    CGFloat imageRotatedyRadians = 0.0;
    int floatCutValue = 25;

    if (handleCenter.x<frame.size.width/2 && handleCenter.y>frame.size.width/3) {
        imageRotatedyRadians = 0.0;
        floatCutValue = 15;
    }
    
    if (handleCenter.x<frame.size.width/2 && handleCenter.y<frame.size.width/3) {
        imageRotatedyRadians = 90.0;
    }
    
    if (handleCenter.x>frame.size.width/2 && handleCenter.y<frame.size.width/3) {
        imageRotatedyRadians = 90.0;

    }
    
    if (handleCenter.x>frame.size.width/2 && handleCenter.y>frame.size.width/3) {
        imageRotatedyRadians = -90.0;
    }
    
    UIImage *image = [[UIImage imageNamed:@"control_btn_pointer"] imageRotatedByRadians:imageRotatedyRadians];
    //[image drawAtPoint:CGPointMake((handleCenter.x-_lineWidth/2-25),handleCenter.y-_lineWidth/2-25)];
    [image drawAtPoint:CGPointMake((handleCenter.x-floatCutValue),handleCenter.y-floatCutValue)];

    //[image drawAtPoint:CGPointMake(handleCenter.x,handleCenter.y)];

    CGContextRestoreGState(ctx);*/
}

-(CGPoint)pointFromAngle:(int)angleInt{
    
    //Define the Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //Define The point position on the circumference
    CGPoint result;
    CGFloat y = centerPoint.y + (radius)*sin(ToRad(angleInt));
    CGFloat x = centerPoint.x + (radius)*cos(ToRad(angleInt));
    result =CGPointMake(x, y);
    return result;
}

-(CGPoint)maskPointFromAngle:(int)angleInt{
    
    //Define the Circle center
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //Define The point position on the circumference
    CGPoint result;
    CGFloat y = centerPoint.y + (radius-_lineWidth/3)*sin(ToRad(angleInt));
    CGFloat x = centerPoint.x + (radius-_lineWidth/3)*cos(ToRad(angleInt));
    result =CGPointMake(x, y);
    return result;
}

#pragma mark---UIControl Method

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    //[super beginTrackingWithTouch:touch withEvent:event];
    CGPoint mousepoint = [touch locationInView:self];
    
    if (!CGRectContainsPoint(self.progressLayer.frame, mousepoint))
        return NO;
    
    //[self mapPointToColor:[touch locationInView:self.progressLayer]];
    int currentAngle = [self getCurrentValue:mousepoint];
    if (currentAngle > 60 && currentAngle < 120) {
        return NO;
    }
    angle = currentAngle;
    
    CGPoint handleCenter = [self pointFromAngle:angle];
    CGPoint location = CGPointMake(handleCenter.x-_lineWidth/2+25, handleCenter.y-_lineWidth/2+25);
    //NSLog(@"location.is..%f,%f",location.x,location.y);
    
    UIColor *pointcolor = [self colorOfPoint:location];
    
    struct HSV hsv;
    
    [pointcolor getHue:&hsv.hu saturation:&hsv.sa brightness:&hsv.br alpha:&hsv.al];
    
    if ((ceil(hsv.hu) == 0)&&(ceil(hsv.sa) == 0)/*&&(ceil(hsv.br) == 0)*/) {
        //return NO;
    } else {
        [self getCurentValue:mousepoint];
        
        if (self.delegate) {
            [self.delegate didCircularClicked:pointcolor Value:_currentValue];
        }
    }
    
    [self moveHandle:mousepoint];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return  YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];

    CGPoint lastPoint =[touch locationInView:self];
    int currentAngle = [self getCurrentValue:lastPoint];
    if (currentAngle > 60 && currentAngle < 120) {
        return NO;
    }
    angle = currentAngle;

    CGPoint handleCenter = [self pointFromAngle:angle];
    CGPoint location = CGPointMake(handleCenter.x-_lineWidth/2+23, handleCenter.y-_lineWidth/2+23);
    NSLog(@"location.is..%f,%f",location.x,location.y);

    UIColor *pointcolor = [self colorOfPoint:handleCenter];
    
    struct HSV hsv;
    
    [pointcolor getHue:&hsv.hu saturation:&hsv.sa brightness:&hsv.br alpha:&hsv.al];
    /*if ((ceil(hsv.hu) == 0)&&(ceil(hsv.sa) == 0)&&(ceil(hsv.br) != 0)) {
        
        UIColor *pointcolor1 = [self colorOfPoint:handleCenter];

    }*/
    
    if ((ceil(hsv.hu) == 0)&&(ceil(hsv.sa) == 0)/*&&(ceil(hsv.br) == 0)*/) {
        //return NO;
    } else {
        [self getCurentValue:lastPoint];
        
        if (self.delegate) {
            [self.delegate didCircularClicked:pointcolor Value:_currentValue];
        }
    }
    
    [self moveHandle:lastPoint];

    [self sendActionsForControlEvents:UIControlEventValueChanged];

    return YES;
}

/*
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    //NSLog(@"continue......");
    CGPoint lastPoint =[touch locationInView:self];
    CGPoint location = [touch locationInView:self];
    location.x = location.x;
    UIColor *pointcolor = [self colorOfPoint:location];
    
    //http://www.jianshu.com/p/64ca14e560d9
    //http://www.cnblogs.com/zhouxihi/p/6273796.html
    //http://www.jianshu.com/p/4c1d4bcae6de
    //http://liumh.com/2015/07/26/ios-get-color-of-uiview/
    //https://github.com/ivanzoid/ikit/tree/master/UIView%2BColorOfPoint
    //https://github.com/carya/GetViewColor/tree/master/GetViewColor
    
    struct HSV hsv;
    [pointcolor getHue:&hsv.hu saturation:&hsv.sa brightness:&hsv.br alpha:&hsv.al];
    
    if ((ceil(hsv.hu) == 0)&&(ceil(hsv.sa) == 0)&&(ceil(hsv.br) == 0)) {
        //return NO;
    } else {
        [self getCurentValue:lastPoint];
        
        if (self.delegate) {
            [self.delegate didCircularClicked:pointcolor Value:_currentValue];
        }
    }
    [self moveHandle:lastPoint];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    return YES;
}*/

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)moveHandle:(CGPoint)point{
    
    [self getCurentValue:point];
    int currentAngle = [self getCurrentValue:point];
    if (currentAngle > 60 && currentAngle < 120) {
        return;
    }
    angle = currentAngle;
    _currentValue = [self valueFromAngle];
    if (_currentValue==0) {
        _currentValue =1;
    }
    
    [self setNeedsDisplay];
}

static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    //    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    //    v.x /= vmag;
    //    v.y /= vmag;
    float result = 0 ;
    double radians = atan2(v.y,v.x);
    result = ToAng(radians);
    return (result >=0  ? result : result + 360.0);
}

- (CGFloat)valueFromAngle {
    return  (angle-180)*(_maximumValue-_minimumValue)/180;
}


- (CGFloat)getCurrentValue:(CGPoint)point{
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
    return currentAngle;
    
}

#define kRadius MIN(self.bounds.size.width, self.bounds.size.height)/2.0

- (void)getCurentValue:(CGPoint)point {
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
    if (currentAngle > 60 && currentAngle < 120) {
        return;
    }

    if (point.x>kRadius) {
        if (point.y>kRadius){
            currentAngle = currentAngle+360;
        }
    }
    
    currentAngle=currentAngle-120;
    //NSLog(@"currentAngle====%d",currentAngle);

    CGFloat curentProcess = currentAngle/300.0f;
    _currentValue = (1-curentProcess) * (int)(_maximumValue-_minimumValue)+_minimumValue;
    //NSLog(@"_currentValue====%d",_currentValue);

    /*
    //CGFloat curentValue = 0;
    CGFloat f = pow(point.x-kRadius, 2)+pow(point.y - kRadius, 2);
    if (pow(kRadius, 2)>f&&f>pow(kRadius-30, 2)) {
        
        CGFloat calculationRadian = acos(ABS(point.x-kRadius)/sqrt(pow(point.x-kRadius, 2)+pow(point.y-100, 2)));
        
        if (point.x>kRadius) {
            if (point.y<kRadius){
                currentRadian = -calculationRadian;
            }else{
                currentRadian = calculationRadian;
            }
        }else{
            if (point.y<kRadius) {
                if (calculationRadian + M_PI < M_PI*4/3){
                    currentRadian = calculationRadian + M_PI;
                }else{
                }
            }else{
                currentRadian = M_PI - calculationRadian;
            }
        }
        _currentValue = ((M_PI*5/6 - currentRadian)/(M_PI*12/6)) * _maximumValue;

        //_currentValue = ((M_PI*4/3 - currentRadian)/(M_PI*11/6)) * _maximumValue;
    }*/
}

#pragma color

- (UIImage *)imageFromLayer:(CALayer *)layer
{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    UIGraphicsBeginImageContextWithOptions([layer frame].size, NO, [UIScreen mainScreen].scale);
    else
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end

