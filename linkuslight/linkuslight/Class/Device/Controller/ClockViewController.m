//
//  ClockViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/26.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIButton *openTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *closeTimeButton;
@property (weak, nonatomic) IBOutlet UITextField *timeHourTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *timeMinTextField;
@property (weak, nonatomic) IBOutlet UIButton *onceButton;
@property (weak, nonatomic) IBOutlet UIButton *everyTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *everyHourButton;
@property (weak, nonatomic) IBOutlet UIButton *everyDayButton;
@property (weak, nonatomic) IBOutlet UIButton *onceDoneButton;
@property (weak, nonatomic) IBOutlet UIButton *everyDoneButton;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.topViewController.navigationItem setTitle:NSLocalizedString(@"timer_title", nil)];
    //self.navigationController.navigationBar.tintColor = nil;
    //self.navigationController.navigationBar.backgroundColor = nil;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //self.navigationController.navigationBar.clipsToBounds = YES;
    //[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didOpenTimeButtonClicked:(id)sender {
    [self turnClockOn:YES];
}

- (IBAction)didCloseTimeButtonClicked:(id)sender {
    [self turnClockOn:NO];
}

- (IBAction)didOnceButtonClicked:(id)sender {
    [self setFrequency:0];
}

- (IBAction)didEveryTimeButtonClicked:(id)sender {
    [self setFrequency:1];
}

- (IBAction)didEreryHourButtonClicked:(id)sender {
    [self setFrequency:2];
}

- (IBAction)didEveryDayButtonClicked:(id)sender {
    [self setFrequency:3];
}

- (IBAction)didOnceDoneButtonClicked:(id)sender {
    [self setTrigger:YES];
}

- (IBAction)didEveryDoneButtonClicked:(id)sender {
    [self setTrigger:NO];
}

- (IBAction)didDoneButtonClicked:(id)sender {
    //_timeHourTextFiled;
    //_timeMinTextField;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark Private

- (void)initView
{
    [self transform];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]];
    /*UIColor *color = [UIColor whiteColor];
     _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: color}];
     
     UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
     UIImageView* xImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_addition_password_not"]];
     xImageView.highlightedImage = [UIImage imageNamed:@"icon_addition_password"];
     xImageView.frame = CGRectMake(0, 0,30,30);
     [rightVeiw addSubview:xImageView];
     _passwordTextField.rightView = rightVeiw;
     _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
     xImageView.userInteractionEnabled = YES;
     UITapGestureRecognizer *xImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xImageViewClick:)];
     [xImageView addGestureRecognizer:xImageViewTap];
     
     [_doneButton.layer setCornerRadius:8.0];*/
    
    [_doneButton.layer setCornerRadius:10.0];
    
    [_openTimeButton.layer setCornerRadius:14.0];
    [_openTimeButton.layer setBorderWidth:1.0f];
    [_openTimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    [_closeTimeButton.layer setCornerRadius:14.0];
    [_closeTimeButton.layer setBorderWidth:1.0f];
    [_closeTimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    [_onceButton.layer setCornerRadius:14.0];
    [_onceButton.layer setBorderWidth:1.0f];
    [_onceButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_everyTimeButton.layer setCornerRadius:14.0];
    [_everyTimeButton.layer setBorderWidth:1.0f];
    [_everyTimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_everyHourButton.layer setCornerRadius:14.0];
    [_everyHourButton.layer setBorderWidth:1.0f];
    [_everyHourButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_everyDayButton.layer setCornerRadius:14.0];
    [_everyDayButton.layer setBorderWidth:1.0f];
    [_everyDayButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_onceDoneButton.layer setCornerRadius:14.0];
    [_onceDoneButton.layer setBorderWidth:1.0f];
    [_onceDoneButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_everyDoneButton.layer setCornerRadius:14.0];
    [_everyDoneButton.layer setBorderWidth:1.0f];
    [_everyDoneButton.layer setBorderColor:[UIColor whiteColor].CGColor];

}

- (void)turnClockOn:(Boolean)isOn {
    if (isOn) {
        [_openTimeButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_openTimeButton setBackgroundColor:[UIColor whiteColor]];
        [_openTimeButton.layer setBorderColor:kLightOrangeColor.CGColor];

        [_closeTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeTimeButton setBackgroundColor:kBackgroundColor];
        [_closeTimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];

    } else {
        [_openTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_openTimeButton setBackgroundColor:kBackgroundColor];
        [_openTimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];

        [_closeTimeButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_closeTimeButton setBackgroundColor:[UIColor whiteColor]];
        [_closeTimeButton.layer setBorderColor:kLightOrangeColor.CGColor];

    }
}

- (void)setFrequency:(int)frequency {
    if (frequency == 0) {
        [_onceButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_onceButton setBackgroundColor:[UIColor whiteColor]];
        [_onceButton.layer setBorderColor:kLightOrangeColor.CGColor];

    } else {
        [_onceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_onceButton setBackgroundColor:kBackgroundColor];
        [_onceButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    
    if (frequency == 1) {
        [_everyTimeButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_everyTimeButton setBackgroundColor:[UIColor whiteColor]];
        [_everyTimeButton.layer setBorderColor:kLightOrangeColor.CGColor];

    } else {
        [_everyTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_everyTimeButton setBackgroundColor:kBackgroundColor];
        [_everyTimeButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    
    if (frequency == 2) {
        [_everyHourButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_everyHourButton setBackgroundColor:[UIColor whiteColor]];
        [_everyHourButton.layer setBorderColor:kLightOrangeColor.CGColor];
    } else {
        [_everyHourButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_everyHourButton setBackgroundColor:kBackgroundColor];
        [_everyHourButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    
    if (frequency == 3) {
        [_everyDayButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_everyDayButton setBackgroundColor:[UIColor whiteColor]];
        [_everyDayButton.layer setBorderColor:kLightOrangeColor.CGColor];
    } else {
        [_everyDayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_everyDayButton setBackgroundColor:kBackgroundColor];
        [_everyDayButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
}

- (void)setTrigger:(Boolean)isOn {
    if (isOn) {
        [_onceDoneButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_onceDoneButton setBackgroundColor:[UIColor whiteColor]];
        [_onceDoneButton.layer setBorderColor:kLightOrangeColor.CGColor];

        [_everyDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_everyDoneButton setBackgroundColor:kBackgroundColor];
        [_everyDoneButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    } else {
        [_onceDoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_onceDoneButton setBackgroundColor:kBackgroundColor];
        [_onceDoneButton.layer setBorderColor:[UIColor whiteColor].CGColor];

        [_everyDoneButton setTitleColor:kLightOrangeColor forState:UIControlStateNormal];
        [_everyDoneButton setBackgroundColor:[UIColor whiteColor]];
        [_everyDoneButton.layer setBorderColor:kLightOrangeColor.CGColor];

    }
}


- (void)transform {
    
    self.navigationItem.backBarButtonItem = nil;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_button"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(backUPView)];
    leftItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                  initWithTitle:NSLocalizedString(@"item_more", nil)
                                  style:UIBarButtonItemStyleDone
                                  target:self
                                  action:@selector(showmenu)];
    rightItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.backBarButtonItem = nil;
    
}

- (void)backUPView {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) showmenu {
    
}

@end
