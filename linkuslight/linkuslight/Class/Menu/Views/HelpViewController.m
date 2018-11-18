//
//  HelpViewController.m
//  linkuslight
//
//  Created by Zex on 2018/11/17.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import "HelpViewController.h"
#import "AppDelegate.h"

@interface HelpViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textView.text = @"1. 手机连接至无线wifi \n2. 长按设备使其处于粉色闪烁状态 \n3. 选择添加设备 \n4. 输入wifi密码扫描设备  \n5. 通过设备独立控制相关设备";
    
    [self transform];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) transform {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backUPView)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backUPView {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
