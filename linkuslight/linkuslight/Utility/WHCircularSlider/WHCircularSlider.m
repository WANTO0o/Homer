//
//  WHCircularSlider.m
//  circle Control
//
//  Created by aba on 17/12/28.
//  Copyright © 2017年 aba. All rights reserved.
//

#import "WHCircularSlider.h"
#import "ColorCircleView.h"

@interface WHCircularSlider()

@property (nonatomic ,assign) float lineWidth;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end


@implementation WHCircularSlider

-(void)didMoveToSuperview{
    
    if (!self.progressLayer) {
        
        _lineWidth = 30;
        
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
        img.image = [UIImage imageNamed:@"allcolorcrycle"];
        img.bounds = self.bounds;
        img.center = kCenter;
        [self addSubview:img];
        img.layer.mask = _progressLayer;
        
        ColorCircleView *cir = [ColorCircleView new];
        cir.bounds = self.bounds;
        cir.center = kCenter;
        [self addSubview:cir];
        cir.colorBlock = ^(UIColor *color){
            if (self.colBlock) {
                self.colBlock(color);
            }
        };
    }
}

-(void)drawRect:(CGRect)rect{
    
}

@end
