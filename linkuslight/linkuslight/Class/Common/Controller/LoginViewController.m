//
//  LoginViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LOLUser.h"
#import "LULSessionManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

#import <LoginWithAmazon/LoginWithAmazon.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initView {
    
    [_loginButton.layer setCornerRadius:8.0];
    
    _loginButton.imageEdgeInsets = UIEdgeInsetsMake(0, _loginButton.titleLabel.frame.size.width-63, 0, -_loginButton.imageView.frame.size.width);
}

- (IBAction)didLoginButtonClicked:(id)sender {
    
    // Make authorize call to SDK to get authorization from the user. While making the call you can specify the scopes for which the user authorization is needed.
    
    // Build an authorize request.
    AMZNAuthorizeRequest *request = [[AMZNAuthorizeRequest alloc] init];
    
    // Requesting 'profile' scopes for the current user.
    request.scopes = [NSArray arrayWithObject:[AMZNProfileScope profile]];
    
    // Make an Authorize call to the Login with Amazon SDK.
    [[AMZNAuthorizationManager sharedManager] authorize:request
                                            withHandler:[self requestHandler]];
    
}

- (AMZNAuthorizationRequestHandler)requestHandler
{
    LOLUser *user = [[LOLUser alloc] init];
    NSLog(@"call requestHandler");
    
    AMZNAuthorizationRequestHandler requestHandler = ^(AMZNAuthorizeResult * result, BOOL userDidCancel, NSError * error) {
        if (error) {
            NSLog(@"error %@", error);
            // If error code = kAIApplicationNotAuthorized, allow user to log in again.
            if(error.code == kAIApplicationNotAuthorized) {
                // Show authorize user button.
                //[self showLogInPage];
            } else {
                // Handle other errors
                NSString *errorMessage = error.userInfo[@"AMZNLWAErrorNonLocalizedDescription"];
                [[[UIAlertView alloc] initWithTitle:@"Search Result" message:[NSString stringWithFormat:@"Error occured with message: %@", errorMessage] delegate:nil cancelButtonTitle:@"I know" otherButtonTitles: nil] show];
            }
        } else if (userDidCancel) {
            // Your code to handle user cancel scenario.
            NSLog(@"UserCancel");
        } else {
            NSLog(@"login success");
            // Authentication was successful. Obtain the user profile data.
            AMZNUser *amznUser = result.user;
            user.amznUser = amznUser;
            user.userID = amznUser.userID;
            DebugLog(@"UserID: %@", user.userID);
            user.userEmail = amznUser.email;
            user.userName = amznUser.name;
            
            NSLog(@"User Name: %@", user.userName);
            NSLog(@"User email: %@", user.userEmail);
            
            [[LULSessionManager manager] SaveUserData:user];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [(AppDelegate*)[UIApplication sharedApplication].delegate showMainPage];
        }
    };
    
    return [requestHandler copy];
}

@end
