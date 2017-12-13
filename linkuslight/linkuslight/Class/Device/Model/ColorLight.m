//
//  ColorLight.m
//  linkuslight
//
//  Created by Zex on 2017/12/13.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "ColorLight.h"

@implementation ColorLight

- (void) SetColorH:(uint32_t)colorH S:(uint32_t)colorS B:(uint32_t)colorB {
    [_device controlColorH:colorH S:colorS B:colorB];
}

- (void) TurnOff {
    [_device controlColorH:0 S:0 B:0];
}



@end
