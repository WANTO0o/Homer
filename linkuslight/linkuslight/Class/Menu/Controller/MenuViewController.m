//
//  MenuViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "LULSessionManager.h"
#import "MenuViewController.h"
#import "LoginViewController.h"
#import "MenuUserTableViewCell.h"
#import <LoginWithAmazon/LoginWithAmazon.h>
#import "Uility.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, retain)CAGradientLayer *gradientLayer;
@property (nonatomic,retain)NSMutableArray *menus;
@property (nonatomic,retain)NSMutableArray *menusImg;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self initData];
    //[self showLoginPage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.menuTableView reloadData];
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

#pragma mark Private
- (void)initView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    _menuTableView.tableFooterView = view;
    _menuTableView.backgroundColor = [UIColor clearColor];
    //_menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[_menuTableView setFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height)];
    //_menuTableView.backgroundColor = [UIColor colorWithRed:0.3333 green:0.4667 blue:0.7098 alpha:1.0];
    
    //实现背景渐变
    
    //初始化我们需要改变背景色的UIView，并添加在视图上
    //UIView *theView = [[UIView alloc] initWithFrame:self.menuTableView.frame];
    //[self.menuTableView addSubview:theView];
    
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, kScreen_Width, kScreen_Height);
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.view.layer addSublayer:self.gradientLayer];
    
    //设置渐变区域的起始和终止位置（范围为0-1）
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    self.gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.5255 green:0.7216 blue:0.9804 alpha:1.0].CGColor,
                                  (__bridge id)[UIColor colorWithRed:0.2039 green:0.3216 blue:0.6745 alpha:1.0].CGColor];
    
    //设置颜色分割点（范围：0-1）
    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
    [self.view bringSubviewToFront:_menuTableView];

}

- (void)initData {
    
    _menus = [NSMutableArray arrayWithObjects:@"用户",@"配置",@"帮助",@"关于",@"退出登录", nil];
    _menusImg = [NSMutableArray arrayWithObjects:@"",@"personal_icon_setting",@"personal_icon_regard",@"personal_icon_hape",
                 @"personal_icon_setting", nil];
}

- (void)showLoginPage {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    [self presentViewController:loginNav animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = _menuTableView.contentOffset;
    //if (offset.y <= 0)
    {
        offset.y = 0;
    }
    _menuTableView.contentOffset = offset;
}

#pragma TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menus.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        
        return 60.0;

    } else {
        
        return 260.0;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 0) {
    
        static NSString* identy = @"deviceTableCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.imageView.image = [UIImage imageNamed:_menusImg[indexPath.row]];
            cell.textLabel.text = _menus[indexPath.row];
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:40];
            cell.backgroundColor = [UIColor clearColor];
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

        }
        
        return cell;

    } else {
        
        LOLUser *user = [[LULSessionManager manager] GetUserData];

        MenuUserTableViewCell *cell = [MenuUserTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);

        [cell refreshWithUserInfo:user];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _menus.count) {
        
        switch (indexPath.row) {
            case 0:
                // 用户信息
                break;
            case 1:
                // 配置
                break;
            case 2:
                // 帮助
                break;
            case 3:
                // 关于
            {
                NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
                NSString *ver = [NSString stringWithFormat:@"Version: %@ Build: %@",
                                  [infoDict objectForKey:@"CFBundleShortVersionString"],
                                  [infoDict objectForKey:@"CFBundleVersion"]];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"关于" message:ver preferredStyle:UIAlertControllerStyleAlert];
                //增加确定按钮；
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:true completion:nil];
                break;
            }
            case 4:
                // 退出登录
            {
                [Uility showLoadingToView:self.view];
                [[AMZNAuthorizationManager sharedManager] signOut:^(NSError * _Nullable error) {
                    // Your additional logic after the user authorization state is cleared.
                    [Uility hideLoadingView:self.view];
                    [Uility setAutoLogin:NO];
                    [self showLoginPage];
                }];
                break;
            }
            default:
                NSLog(@"didSelectRowAtIndexRow:%ld",(long)indexPath.row);
                break;
        }
    };
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

@end
