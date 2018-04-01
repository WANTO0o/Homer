//
//  AppDelegate.m
//  linkuslight
//
//  Created by Aba on 17/10/5.
//  Copyright © 2017年 linkustek. All rights reserved.
//
#import "RESideMenu.h"
#import "EAIntroView.h"
#import "IQKeyboardManager.h"

#import "AppDelegate.h"
#import "LULSessionManager.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "GroupManageViewController.h"
#import "DeviceManageViewController.h"
#import "ScenceManageViewController.h"
#import "LULSessionManager.h"

#import "LightControlViewController.h"
#import <LoginWithAmazon/LoginWithAmazon.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 设置可获取崩溃信息 AiIaJi
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]/*[UIColor colorWithRed:106.0/255.0 green:125.0/255.0  blue:143.0/255.0  alpha:1.0]*/];
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    //[[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //[UINavigationBar appearance].translucent = NO;
    
    [self setKeyBoard];
    
    if([[LULSessionManager manager] NeedLogin])
    {
        [self showLoginPage];
    } else {
        [self showMainPage];
    }
    
    //[self showSocketView];
    
    //[self showMainPage];

    //[self showWelcomePage];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark AmazonLogin
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [AMZNAuthorizationManager handleOpenURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
}

#pragma mark Private
// 设置一个C函数，用来接收崩溃信息
void UncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSLog(@"sm exception thorowed named:%@ callStack:%@ reason is:%@",name,reason,symbols);
}

- (void)setKeyBoard {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    //keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    //keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    //keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离

}

- (void)showMainPage {

    DeviceManageViewController *deviceController = [[DeviceManageViewController alloc] init];
    deviceController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *deviceNav = [[UINavigationController alloc] initWithRootViewController:deviceController];
    deviceNav.tabBarItem.title = NSLocalizedString(@"main_devlist", nil);
    deviceNav.tabBarItem.image = [UIImage imageNamed:@"tab_device list"];
    
    GroupManageViewController *groupController = [[GroupManageViewController alloc] init];
    groupController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *groupNav = [[UINavigationController alloc] initWithRootViewController:groupController];
    groupNav.tabBarItem.title = NSLocalizedString(@"main_group", nil);
    groupNav.tabBarItem.image = [UIImage imageNamed:@"tab_group"];
    
    ScenceManageViewController *scenceViewController = [[ScenceManageViewController alloc] init];
    scenceViewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *scenceNav = [[UINavigationController alloc] initWithRootViewController:scenceViewController];
    scenceNav.tabBarItem.title = NSLocalizedString(@"main_scene", nil);
    scenceNav.tabBarItem.image = [UIImage imageNamed:@"tab_scene"];
    
    UITabBarController *mainTabbar = [[UITabBarController alloc] init];
    mainTabbar.tabBar.tintColor = [UIColor colorWithRed:0.2039 green:0.4196 blue:0.7412 alpha:1.0];
    [mainTabbar setViewControllers:[NSArray arrayWithObjects:deviceNav,groupNav,scenceNav, nil]];
    
    MenuViewController *leftViewController = [[MenuViewController alloc] init];
    //leftViewController.view.backgroundColor = [UIColor colorWithRed:0.4941 green:0.6745 blue:0.949 alpha:1.0];
    RESideMenu *resideVC = [[RESideMenu alloc]initWithContentViewController:mainTabbar leftMenuViewController:[[UINavigationController alloc                                                                                            ] initWithRootViewController: leftViewController] rightMenuViewController:nil];
    resideVC.menuPreferredStatusBarStyle = 1;
    resideVC.contentViewShadowColor = [UIColor blackColor];
    resideVC.contentViewShadowOffset = CGSizeMake(0, 0);
    resideVC.contentViewShadowOpacity = 0.6;
    resideVC.contentViewShadowRadius = 12;
    resideVC.contentViewShadowEnabled = YES;
    
    self.window.rootViewController = resideVC;
    [self.window makeKeyAndVisible];
}

- (void)showLoginPage {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
}

- (void)showWelcomePage {

    NSMutableArray *pages = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *data = [NSMutableArray arrayWithObjects:@"startpage1",@"startpage2",@"startpage3", nil];
    
    for (int i=0; i<data.count; i++) {
        UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        iamgeView.image = [UIImage imageNamed:data[i]];
        /*EAIntroPage *page = [EAIntroPage pageWithCustomView:iamgeView];*/
        EAIntroPage *page = [EAIntroPage page];
        page.bgImageView = iamgeView;
        //page.bgImage = [UIImage imageNamed:data[i]];
        page.showTitleView = NO;
        [pages addObject:page];
    }
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.frame];
    [intro setPages:pages];
    intro.tapToNext = YES;
    [intro showInView:self.window animateDuration:0];
    /*UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, (kScreen_Width-150), 120)];
    [btn setTitle:@"点亮智慧人生" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.3373 green:0.549 blue:0.851 alpha:1.0] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.f;
    btn.layer.cornerRadius = 8;
    btn.layer.borderColor = [[UIColor colorWithRed:0.3686 green:0.5961 blue:0.9294 alpha:1.0] CGColor];
    intro.skipButton = btn;
    intro.skipButtonY = 260.f;
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    intro.showSkipButtonOnlyOnLastPage = YES;*/
    [intro.skipButton setTitle:@"立即体验" forState:UIControlStateNormal];
    //[intro setSkipButtonAlignment:EAViewAlignmentCenter];
    //[intro.skipButton setFrame:CGRectMake((kScreen_Width-280)/2, kScreen_Height-360, 280, 80)];
    //[intro.skipButton setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]];
    [intro scrollPageWithDuration:4];
    [self.window bringSubviewToFront:intro];
   
}

- (void)showSocketView {
    LightControlViewController *controller = [[LightControlViewController alloc] init];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
}

@end
