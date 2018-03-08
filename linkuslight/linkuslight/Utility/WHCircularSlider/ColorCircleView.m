//
//  ColorCircleView.m
//  circle Control
//
//  Created by aba on 17/12/28.
//  Copyright © 2017年 aba. All rights reserved.
//

#import "ColorCircleView.h"
#import "Uility.h"

@interface ColorCircleView ()
@property (nonatomic, assign, getter=isOn) BOOL On;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGPoint pointCenter;
@property (nonatomic ,assign) CGFloat angle;

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIImageView *progressImageView;
@property (nonatomic, strong) CAShapeLayer *outLayer;

@property (nonatomic ,assign) float lineWidth;

@property (nonatomic ,strong)UIImageView *pointImage;
@end

@implementation ColorCircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
 
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawColorImageView];
}

- (void)drawColorImageView{
    _lineWidth = 30;
    if (!self.progressLayer){
        self.progressLayer = [CAShapeLayer layer];
        //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:kCenter radius:kRadius startAngle:0 endAngle:2*M_PI clockwise:1];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:kRadius startAngle:M_PI_4*2.7 endAngle:M_PI_4*1.3 clockwise:YES];
        //path.lineJoinStyle = kCGLineCapRound;
        //path.lineCapStyle = kCGLineCapRound;
        _progressLayer.path = path.CGPath;
        _progressLayer.lineWidth = _lineWidth;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.lineCap = kCALineCapRound;
        
        UIImageView *img = [UIImageView new];
        _progressImageView = img;
        img.image = [UIImage imageNamed:@"allcolorcrycle"];
        img.bounds = self.bounds;
        img.center = kCenter;
        [self addSubview:img];
        img.layer.mask = _progressLayer;
        
        UIImageView *pointImg = [UIImageView new];
        _pointImage = pointImg;
        pointImg.image = [UIImage imageNamed:@"pointer_orange"];
        pointImg.bounds = CGRectMake(0, 0, 30, 30);
        [self addSubview:pointImg];
    }
    
    
    

    
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    CGPoint current = [touches.anyObject locationInView:self];
    double hypotenuse = hypot(fabs(current.x - kCenter.x),fabs(current.y - kCenter.y));
    if (CGRectContainsPoint(self.progressImageView.frame, current) && hypotenuse >= (kRadius - 10)) {
        self.On = YES;
    }else{
        self.On = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    if (self.isOn) {
        _point = [touches.anyObject locationInView:self];
        _angle = atan2((_point.y - kCenter.y), (_point.x - kCenter.x));
        float cc=_angle * 180 / M_PI;
        if (cc > 65 && cc < 115) {
            return;
        }
        _pointCenter = relative(kCenter, kRadius, 0);
        
        if (!CGPointEqualToPoint(_point, CGPointZero)) {
            _angle = atan2((_point.y - kCenter.y), (_point.x - kCenter.x));
            _pointCenter = relative(kCenter, kRadius * cos(_angle), kRadius * sin(_angle));
//            NSLog(@"%f", _angle * 180 / M_PI);
        }
        _pointImage.center = _pointCenter;
        //relative(kCenter, kRadius, 0);
//        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    if (self.isOn) {
        NSLog(@"触摸结束%f", _angle * 180 / M_PI);
        if (self.colorBlock) {
            self.colorBlock([UIColor colorWithHue:(-_angle / M_PI * 0.5 + 0.5) saturation:1 brightness:1 alpha:1]);
        }
        self.On = NO;
    }
}

CGPoint relative(CGPoint point, CGFloat x, CGFloat y)
{
    return CGPointMake(point.x + x, point.y + y);
}

@end
