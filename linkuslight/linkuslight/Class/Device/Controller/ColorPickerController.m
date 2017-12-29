//
//  ColorPickerController.m
//  linkuslight
//
//  Created by aba on 2017/12/28.
//  Copyright © 2017年 linkustek. All rights reserved.
//
//#import "Canvas.h"
#import "ColorPickerController.h"

@interface ColorPickerController ()
@property(strong, nonatomic)UIView *rightbgView;

@end

@implementation ColorPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initView];
}

- (void)initView
{
    //[self.view setBackgroundColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
    
    self.rightbgView = [[UIView alloc] initWithFrame:CGRectMake(130, 130, 30, 30)];
    
    [self.view addSubview:self.rightbgView];
}

#pragma mark - 点击结束
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    
    UITouch* touch = [touches anyObject];
    // tap点击的位置
    CGPoint point = [touch locationInView:self.imgView];
    
    // 1.调用自定义方法,从【点】中取颜色
    UIColor *selectedColor = [self getPixelColorAtLocation:point];
    // 2.告诉代理,解析出来的颜色
    [_pickedColorDelegate pickedColor:selectedColor];
}


// 核心代码:关于下面两个方法更多的详细资料,敬请查阅【iOS Developer Library 】
#pragma mark - 核心代码,将图片写入内存,再依据【点】中取颜色
- (UIColor *) getPixelColorAtLocation:(CGPoint)point
{
    UIColor *color = nil;
    // 得到取色图片的引用
    CGImageRef colorImage = _imgView.image.CGImage;
    
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    
    // 调用自定义方法:从_imgView里面的image的引用,创建并返回对应的上下文
    CGContextRef contexRef = [self createARGBBitmapContextFromImage:colorImage];
    // 如果创建该图片对应的上下文失败
    if (contexRef == NULL){
        NSLog(@"取色图片--创建对应的上下文失败~");
        return nil;
    }
    // 准备将【取色图片】写入刚才创建出来的上下文
    size_t w = CGImageGetWidth(colorImage);        // problem!
    size_t h = CGImageGetHeight(colorImage);
    CGRect rect = {{0,0},{w,h}};
    //log_rect(rect)
    // 调试输出rect:--{{0, 0}, {225, 250}}
    
    int bytesPerRow = CGBitmapContextGetBytesPerRow(contexRef);
    //log_int(bytesPerRow) //调试输出int:--900
    
    
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    // 将位图写入(渲染)已经分配好的内存区域
    CGContextDrawImage(contexRef, rect, colorImage);
    
    // 得到位图上下文 内存数据块的首地址,用指针记住,作为基地址
    unsigned char* dataPoint = CGBitmapContextGetData (contexRef);
    NSLog(@"----首地址,指针%p",dataPoint);
    // ----首地址,指针0x8b3f000
    
    
    
    if (dataPoint != NULL) {
        //offset 即:根据触摸点的xy,定位到位图内存空间中的一个特定像素
        //4 的意思是每一个像素点,占4个字节
        // w是每一行所有点的总数
        // 根据所在行,所在列,算出在内存块中的偏移地址,然后乘以4,因为每一个点在内存中占四个字节
        int offset = 4*((w*round(point.y))+round(point.x));
        // alpha 为内存基地址+偏移地址
        int alpha =  dataPoint[offset];
        // red 为内存基地址+偏移地址+1   其他类似
        int red = dataPoint[offset+1];
        int green = dataPoint[offset+2];
        int blue = dataPoint[offset+3];
        
        NSLog(@"偏移地址: %i colors: RGBA %i %i %i  %i",offset,red,green,blue,alpha);
        // offset: 150908 colors: RGB A 255 0 254  255
        
        // 根据RGBA 生成颜色对象
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        
        self.rightbgView.backgroundColor = color;
    }
    
    // 操作完成后,释放上下文对象
    CGContextRelease(contexRef);
    // 从内存中释放掉 加载到内存的图像数据
    if (dataPoint) {
        free(dataPoint);
    }
    
    return color;
}
// 自定义方法2:通过_imgView里面的image的引用,创建并返回对应的上下文
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage
{
    
    // 要创建的上下文
    CGContextRef    context = NULL;
    // 色彩空间
    CGColorSpaceRef colorSpace;
    // 位图数据在内存空间的首地址
    void *          bitmapData;
    // 每一行的字节数
    int             bitmapBytesPerRow;
    // 图片总的占的字节数
    int             bitmapByteCount;
    
    
    // 得到图片的宽度和高度,将要使用整个图片,创建上下文
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // 每一行占多少字节. 本取色图片中的每一个像素点占4个字节;
    // 红 绿 蓝 透明度 各占一个字节(8位  取值范围0~255)
    // 每一行的字节数,因为每一个像素点占4个字节(包含RGBA)(其中一个R就是一个字节,占8位,取值是2的8次方 0~255)
    bitmapBytesPerRow   = (pixelsWide * 4);
    // 图片总的占的字节数
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // 使用指定的 色彩空间(RGB)
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        fprintf(stderr, "创建并分配色彩空间 出错\n");
        return NULL;
    }
    
    // This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    // 为取色图片数据  分配所有的内存空间
    // 所有画到取色图片上下文的操作,都将被渲染到此内存空间
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "内存空间分配失败~");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // 创建位图上下文. 使用 pre-multiplied ARGB, ARGB中的每一个成员都占8个bit位,即一字节,一个像素共占4个字节
    // 无论原取色图片的格式是什么(CMYK或Grayscale),都将通过CGBitmapContextCreate方法,转成指定的ARGB格式
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "位图上下文创建失败~");
    }
    
    // 在返回上下文之前 必须记得释放 色彩空间
    CGColorSpaceRelease( colorSpace );
    
    return context;
}


- (void)initimg {
    
    
    
}

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
