//
//  LightControlViewController.h
//  linkuslight
//
//  Created by Aba on 17/10/26.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCircularView.h"
#import "DeviceInfo.h"

@interface LightControlViewController : UIViewController

@property (nonatomic, assign) Boolean isDevice;
@property (nonatomic) LULLightSliderType LightType;
@property (nonatomic, strong) DeviceInfo *DeviceInfo;

@end
