//
//  UICircularSlider.m
//  linkuslight
//
//  Created by Aba on 17/10/29.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "UIView+Layout.h"
#import "LZCircularSlider.h"
#define  ToRad(ang)  ((M_PI *(ang)) / 180)//度数转化为弧度
#define  ToAng(rad)  ( (180.0 * (rad)) / M_PI )//弧度转化为度数
#define SQR(x)			( (x) * (x) )g

@interface LZCircularSlider ()

{
    int  angle;
    NSInteger radius;
    NSInteger status;//滑块滑动状态(0 未滑动，1滑动)
    NSInteger upStatus;
}

@end

@implementation LZCircularSlider

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        angle =330;
        radius =self.frame.size.width/2-20;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawCircle];
}

-(void)drawCircle{
    
    [self drawUpCircleAtX:self.frame.size.width/2 Y:self.frame.size.height/2];
    //[self drawDownCircleAtX:self.frame.size.width/2 Y:self.frame.size.height/2];
}

- (void)drawUpCircleAtX:(float)x Y:(float)y {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //CGContextAddArc(ctx, x, y, radius,-ToRad(60), ToRad(0), 0);
    CGContextAddArc(ctx, x, y, radius,M_PI_4*2.7, M_PI_4*1.3, 0);
    CGContextSetStrokeColorWithColor(ctx, _unfilledColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //CGContextAddArc(ctx, x, y, radius,ToRad(180), ToRad(angle), 0);
    CGContextAddArc(ctx, x, y, radius,M_PI_4*2.7, M_PI_4*1.3, 0);
    CGContextSetStrokeColorWithColor(ctx, _filledColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //CGContextStrokePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    [self drawUpHandle:ctx];
}

-(void) drawUpHandle:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGPoint handleCenter =  [self pointFromAngle:angle];
    [[UIColor clearColor]set];
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x-_lineWidth/20-10, handleCenter.y-_lineWidth/2-10,10,10));//填充指定的矩形
    UIImage *image = [UIImage imageNamed:@"control_btn_pointer"];
    
    [image drawAtPoint:CGPointMake((handleCenter.x-_lineWidth/2-5),handleCenter.y-_lineWidth/2-5)];
    CGContextRestoreGState(ctx);
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

#pragma mark---UIControl Method
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    NSLog(@"begining......");
    status =1;
    return  YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
    [super continueTrackingWithTouch:touch withEvent:event];
    NSLog(@"continue......");
    CGPoint lastPoint =[touch locationInView:self];
    //    NSLog(@"point ==%@",NSStringFromCGPoint(lastPoint));
    
    /*
     移动手柄到触摸的位置,在没有结束结束触摸的时候，只能有一个能滑动
     */
    /*if (upStatus ==0) {
        
        [self moveDownHandle:lastPoint];
        
    }
    if (downStatus ==0) {
      */
        [self moveUpHandle:lastPoint];
    //}
    
    CGPoint location = [touch locationInView:self];
    location.x = location.x+5;
    UIColor *rgb = [self colorOfPoint:location];
    //http://www.jianshu.com/p/64ca14e560d9
    //http://www.cnblogs.com/zhouxihi/p/6273796.html
    //http://www.jianshu.com/p/4c1d4bcae6de
    //http://liumh.com/2015/07/26/ios-get-color-of-uiview/
    //https://github.com/ivanzoid/ikit/tree/master/UIView%2BColorOfPoint
    //https://github.com/carya/GetViewColor/tree/master/GetViewColor
    DebugLog(@"%@",rgb);
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    //   NSLog(@"upStatus==滑动中=%ld==下半圆弧滑动=%ld",(long)upStatus,downStatus);
    
    return YES;
}
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    NSLog(@"ending..........");
    status =0;
    //    NSLog(@"upStatus==滑动中=%ld==下半圆弧滑动=%ld",(long)upStatus,downStatus);
}

-(void)moveUpHandle:(CGPoint)point{
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
    NSLog(@"centerString====%d",currentAngle);

    if (currentAngle > 60 && currentAngle < 110) {
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

-(CGFloat)valueFromAngle {
    
    return  (angle-180)*(_maximumValue-_minimumValue)/180;
}

@end

