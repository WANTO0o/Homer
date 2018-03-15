//
//  ScenceDataHelper.m
//  linkuslight
//
//  Created by Mac on 2018/3/12.
//  Copyright © 2018年 linkustek. All rights reserved.
//

#import "DataStoreHelper.h"
#import "YYCache.h"
@interface DataStoreHelper()
@property (nonatomic, strong) YYCache *storeCache;
@end

@implementation DataStoreHelper
+ (instancetype)shareInstance{
    static DataStoreHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[DataStoreHelper alloc]init];
        
    });
    return helper;
}

-(instancetype)init{
    if ([super init]) {
        _storeCache = [YYCache cacheWithName:@"storeCache"];
    }
    return self;
}

- (void)addGroup:(GroupInfo *)group{
    NSMutableArray *groupList = (NSMutableArray *)[self getGroupList];
    [groupList addObject:group];
    [_storeCache setObject:groupList forKey:@"groupListType"];
    
}

- (BOOL)containsGroup:(GroupInfo *)group{
    NSMutableArray *groupList = (NSMutableArray *)[self getGroupList];
    for (GroupInfo *tempGroup in groupList) {
        if ([tempGroup.name isEqualToString:group.name]) {
            return YES;
        }
    }
    return NO;
}

- (void)deleteAllGroup{
    [_storeCache removeObjectForKey:@"groupListType"];
}

- (BOOL)deleteGroup:(GroupInfo *)group{
    NSMutableArray *groupList = (NSMutableArray *)[self getGroupList];
    for (GroupInfo *tempGroup in groupList) {
        if ([tempGroup.name isEqualToString:group.name]) {
            [groupList removeObject:group];
            [_storeCache setObject:groupList forKey:@"groupListType"];
            return YES;
            break;
        }
    }
    return NO;
}

- (BOOL)updateGroup:(GroupInfo *)group{
    NSMutableArray *groupList = (NSMutableArray *)[self getGroupList];
    for (GroupInfo *tempGroup in groupList) {
        if ([tempGroup.name isEqualToString:group.name]) {
            [groupList removeObject:tempGroup];
            [groupList addObject:group];
            [_storeCache setObject:groupList forKey:@"groupListType"];
            return YES;
            break;
        }
    }
    return NO;
}

- (NSMutableArray *)getGroupList{
    if ([_storeCache containsObjectForKey:@"groupListType"]) {
        NSMutableArray *groupList = (NSMutableArray *) [_storeCache objectForKey:@"groupListType"];
        return groupList;
    }else{
        return [NSMutableArray array];
    }
}

@end
