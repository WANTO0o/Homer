//
//  UIImage+ImageScaleSize.h
//  BYFCApp
//
//  Created by PengLee on 15/1/6.
//  Copyright (c) 2015年 PengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageScaleSize)
//压缩成指定大小的图片
+ (UIImage *)imageByScaleAndCropingForSize:(CGSize)newSize oldImage:(UIImage *)image;
//等比例压缩
+ (UIImage *) imageCompressForSizeImage:(UIImage *)image targetSize:(CGSize)size;
//
+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

+ (NSString *)encodeToBase64String:(UIImage *)image;

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

+ (UIImage *)cycleImageWithCornerRadius:(CGFloat)radius;

- (UIImage *)imageWithCornerRadius:(CGFloat)radius;



@end
