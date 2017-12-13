//
//  UIColor-Extensions.h
//  linkuslight
//
//  Created by aba on 17/11/7.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>

struct HSV {
    
    // 色调
    
    CGFloat hu;
    
    // 饱和度
    
    CGFloat sa;
    
    // 明亮度
    
    CGFloat br;
    
    // 透明度
    
    CGFloat al;
    
};

typedef struct HSV HSV;

struct RGB {
    
    // 色调
    
    CGFloat R;
    
    // 饱和度
    
    CGFloat G;
    
    // 明亮度
    
    CGFloat B;
    
    // 透明度
    
    CGFloat al;
    
};

typedef struct RGB RGB;


static void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v )
{
    float min, max, delta;
    min = MIN( r, MIN( g, b ));
    max = MAX( r, MAX( g, b ));
    *v = max;               // v
    delta = max - min;
    if( max != 0 )
        *s = delta / max;       // s
    else {
        // r = g = b = 0        // s = 0, v is undefined
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max )
        *h = ( g - b ) / delta;     // between yellow & magenta
    else if( g == max )
        *h = 2 + ( b - r ) / delta; // between cyan & yellow
    else
        *h = 4 + ( r - g ) / delta; // between magenta & cyan
    *h *= 60;               // degrees
    if( *h < 0 )
        *h += 360;
}

@interface UIColor(Extensions)

@end
