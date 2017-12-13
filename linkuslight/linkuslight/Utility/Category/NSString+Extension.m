//  NSString+Extension.m
//  YJL2
//
//  Created by aba on 16/7/20.
//  Copyright © 2016年 wellview. All rights reserved.
//


#import "NSString+Extension.h"

@implementation NSString(Extension)

+ (NSString*)extraNoExtFileNameWithName:(NSString*)fileName fileExt:(NSString*)ext {
    NSArray *subStrArr = [fileName componentsSeparatedByString:ext];
    NSString *result = @"";
    
    if (subStrArr.count == 1) {
        result = fileName;
    } else if (subStrArr.count != 0) {
        for (int i=0; i<subStrArr.count-1; i++) {
            result = [result stringByAppendingString:subStrArr[i]];
        }
    }
    return result;
}

@end
