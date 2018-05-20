//
//  ScenceManageViewController.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "DeviceInfo.h"
#import "MJRefresh/MJRefresh.h"
#import "CollectionViewCell.h"
#import "LLSelectGroupTypeAlterView.h"
#import "ScenceManageViewController.h"
#import "DeviceListViewController.h"

@interface ScenceManageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *scenceCollectionView;

@property (nonatomic, retain) NSMutableArray *scenceList;
@property (nonatomic, retain) NSMutableArray *scenceTitle;
@property (nonatomic, retain) NSMutableArray *scenceBackground;
@property (nonatomic, retain) NSMutableArray *scenceICom;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray *scenceTypeList;
@end

@implementation ScenceManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.topViewController.navigationItem setTitle:@"SMART ELF"];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //[self.scenceCollectionView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    
    [self transform];
    //[self.scenceCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ScenceCollectionViewCell"];
    
    [self.scenceCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"ScenceCollectionViewCell"];
    [self.scenceCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ScenceCollectionViewCell"];

    //默认【下拉刷新】
    _scenceCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

- (void)initData {
    /*_scenceTitle = [NSMutableArray arrayWithCapacity:1];
    _scenceBackground = [NSMutableArray arrayWithCapacity:1];
    _scenceICom = [NSMutableArray arrayWithCapacity:1];*/
    
    _scenceTitle = [NSMutableArray arrayWithObjects:
                    NSLocalizedString(@"scene_morning", nil),
                    NSLocalizedString(@"scene_sunset", nil),
                    NSLocalizedString(@"scene_night", nil),
                    NSLocalizedString(@"scene_sky", nil),
                    NSLocalizedString(@"scene_romantic", nil),
                    NSLocalizedString(@"scene_movie", nil),
                    nil];
    
    _scenceBackground = [NSMutableArray arrayWithObjects:@"addition_bg_morning",@"addition_bg_sunset",@"addition_bg_night",@"addition_bg_sky",@"addition_bg_romance",@"addition_bg_film", nil];
    _scenceICom = [NSMutableArray arrayWithObjects:@"addition_icon_morning",@"addition_icon_sunset",@"addition_icon_night",@"addition_icon_sky",@"addition_icon_romance",@"addition_icon_film", nil];
    
    _scenceTypeList = [NSMutableArray arrayWithObjects:@(ScenceTypeMorning), @(ScenceTypeSettingSun), @(ScenceTypeSettingMoon), @(ScenceTypeSettingSky), @(ScenceTypeSettingRomantic), @(ScenceTypeSettingMovie), nil];
    self.scenceList = [NSMutableArray arrayWithCapacity:1];
    
    ScenceInfo *scence1 = [[ScenceInfo alloc] init];
    scence1.scenceID = @"";
    scence1.name = @"清晨";
    scence1.deviceType = LULDeviceLinkStateColourLight;
    
    [self.scenceList addObject:scence1];
}

- (void)loadData {
    
    [self.scenceCollectionView reloadData];
    [self endRefresh];
}

#pragma mark - 下拉刷新
- (void)headerRefresh {
    
    [self loadData];
}

#pragma mark - 结束下拉刷新和上拉加载
- (void)endRefresh {
    
    if (_scenceList.count == 0) {
        [self.scenceCollectionView.mj_header endRefreshing];
    }
    
    [self.scenceCollectionView.mj_header endRefreshing];
    
}

- (void) transform {
    /*UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
     style:UIBarButtonItemStyleDone
     target:nil
     action:nil];
     backItem.tintColor = [UIColor whiteColor];
     
     self.navigationItem.backBarButtonItem = backItem;*/
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_leftbar"]
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(gotoMenuView)];
    leftItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    /*UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_addition"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(gotoAddView)];
    rightItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.backBarButtonItem = nil;*/
    
    
}

- (void)gotoMenuView {
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)gotoScenceView:(NSInteger)index {

}

/*
- (void)gotoAddView {
    
    LLInputGroupNameAlterView *lll=[LLInputGroupNameAlterView alterViewWithTitle:@"分组名称" content:@"感谢各位朋友的关注与鼓励"  sure:@"下一步" cancelBtClcik:^{
        //取消按钮点击事件
        NSLog(@"取消");
    } sureBtClcik:^{
        //确定按钮点击事件
        NSLog(@"确定");
        [self gotoSelectGroupTypeView];
    }];
    
    [self.view addSubview:lll];
}*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma Private

- (void)gotoSelectGroupTypeView:(NSInteger)scenceID {
    
    LLSelectGroupTypeAlterView *lsll=[[LLSelectGroupTypeAlterView alloc] initWithTitle:NSLocalizedString(@"info_devType", nil) SureTitle:NSLocalizedString(@"ok", nil) CancelBtClcik:^{
        //取消按钮点击事件
        NSLog(@"取消");
    } SureBtClcik:^(NSInteger selectDeviceTag) {
        //确定按钮点击事件
        NSLog(@"确定");
        switch (selectDeviceTag) {
            case 111:
                NSLog(@"选择彩灯");
                [self showDeviceListView:LULDeviceLinkStateColourLight];
                break;
            case 112:
                NSLog(@"选择白灯");
                [self showDeviceListView:LULDeviceLinkStateWhiteLight];
                break;
            case 113:
                NSLog(@"选择开关");
                [self showDeviceListView:LULDeviceLinkStateSocket];
                break;
            default:
                break;
        }
        
        //[self.scenceCollectionView reloadData];
    }];
    
    [lsll showLLAlertView:self.view];
}

- (void)showDeviceListView:(LULDeviceType)deviceType{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        DeviceListViewController *controller = [[DeviceListViewController alloc] init];
        controller.deviceType = deviceType;
        controller.funcionType = FunctionTypeCreatScence;
        controller.sceneType = [_scenceTypeList[self.selectIndex]integerValue];
        [self setHidesBottomBarWhenPushed:YES];
        
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];

    });
    
}

#pragma Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _scenceTitle.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *sID=@"ScenceCollectionViewCell";

    //ScenceInfo *scence1 = _scenceList[indexPath.row];
    ScenceInfo *scence = _scenceList[0];
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sID forIndexPath:indexPath];
    [cell refreshWithBackground:_scenceBackground[indexPath.row] Icon:_scenceICom[indexPath.row] Title:_scenceTitle[indexPath.row] ScenceInfo:scence];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < _scenceTitle.count) {
        
        NSLog(@"didSelectRowAtIndexRow:%ld",(long)indexPath.row);
        
        /*switch (indexPath.row) {
         case 0:
         break;
         case 1:
         break;
         case 2:
         break;
         default:
         break;
         }*/
        self.selectIndex = indexPath.row;
        //[self gotoSelectGroupTypeView:indexPath.row];
        [self showDeviceListView:LULDeviceLinkStateColourLight];
    };
    
}


@end
