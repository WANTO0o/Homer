//
//  Constraint.h
//  yijiale
//
//  Created by aba on 16/1/21.
//  Copyright © 2016年 yanming. All rights reserved.
//
/* Constraint_h */

//#ifndef Constraint_h
//#define Constraint_h

#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]
#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define YJLDEFAULT_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]

#define YJLDEFAULT_DESCRIPTION_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0]


#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kBackgroundColor [UIColor colorWithRed:0.3975 green:0.6503 blue:1.0 alpha:1.0]
#define kLightOrangeColor [UIColor colorWithRed:0.9922 green:0.7608 blue:0.0392 alpha:1.0]

#define kPlaceholderColor [UIColor colorWithRed:209.0/255 green:209.0/255 blue:214.0/255 alpha:1.0]

///alertView  宽
#define AlertW 280
#define AlertH 324
///各个栏目之间的距离
#define XLSpace 10.0

#define TextViewPlaceholder @"详情描述"
#define ButtonCornerRadius 5.5

//分页查询中每页数据数量
#define divPageNumber 10

/**
 *  Http Host
 */
//#define kDZHostServer @"http://192.168.2.195:8011/"
#define kDZHostServer @"http://183.221.168.53:8011/"
#define kDZAppKey @"YJL_App_Apple"

/**
 *  PushService
 */ //
#define PushHost @"http://171.221.199.90:8081"
#define PushRegisterDevice @"http://171.221.199.90:8081/androidpn-server-offline-push/notification.do?action=registerDevice&token="
#define PushUnRegisterDevice @"http://171.221.199.90:8081/androidpn-server-offline-push/notification.do?action=removeDevice&token="
#define DZGlobalKey @"CDWS_YjlWygl"

/**
 *  Config
 */
//#define GlobalToken @""

/*
 *  800Li
 */
//#define k800Li_Host @"https://123.56.183.169:9084/vms"
#define k800Li_Host @"http://183.221.168.53:8085/"
#define kDefaultTheme @"乐-生活",@"乐-秀台",@"乐-美食"
#define kDefaultThemeID @"83CE1FE389F8FCBF6E3D7F759EBC3C14",@"B392AA31954D60946EA125CF443BB892",@"E1C13DEBB19115B0E53B74F7166B5E07"

/*
 *  天气
 */
#define kREQUEST_URL_HEAD @"http://api.openweathermap.org/data/2.5/"

#define kWEATHER_API_KEY @"0b0b4a71f90a8dd37c74fe8f38af9f3d"
