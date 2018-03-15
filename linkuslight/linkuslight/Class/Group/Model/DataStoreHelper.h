//
//  ScenceDataHelper.h
//  linkuslight
//
//  Created by Mac on 2018/3/12.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "DeviceManager.h"
@interface DataStoreHelper : NSObject


+ (instancetype)shareInstance;
- (BOOL)containsGroup:(GroupInfo *)group;

/**
 添加分组
 */
- (void)addGroup:(GroupInfo *)group;

/**
 删除分组
 */
- (BOOL)deleteGroup:(GroupInfo *)group;

/**
 删除所有分组
 */
- (void)deleteAllGroup;
/**
更新分组信息
 */
- (BOOL)updateGroup:(GroupInfo *)group;
- (NSArray *)getGroupList;
@end
