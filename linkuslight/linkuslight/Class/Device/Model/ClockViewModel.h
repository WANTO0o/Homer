//
//  ClockViewModel.h
//  linkuslight
//
//  Created by Zex on 2018/10/29.
//  Copyright © 2018 linkustek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ClockModel;

enum RepeatType {
    EveryMon,
    EveryTue,
    EveryWed,
    EveryThu,
    EveryFri,
    EverySat,
    EverySun
};
typedef enum RepeatType RepeatType;

@interface ClockViewModel : NSObject<NSCoding>

@property (nonatomic, strong) NSMutableArray <ClockModel *>* clockData;

- (void)saveData;
+ (instancetype)readData;

//添加模型
- (void)addClockModel:(ClockModel *)model;
//替换模型
- (void)replaceModelAtIndex:(NSUInteger)index withModel:(ClockModel *)model;
//删除模型
- (void)removeClockModel:(ClockModel *)model;
- (void)removeClockAtIndex:(NSInteger)index;

//开关改变
- (void)changeClockSwitchIsOn:(BOOL)isOn WithModel:(ClockModel *)model;

//收到通知
- (void)reciveNotificationWithIdentifer:(NSString *)identifer;
@end

@interface ClockModel : NSObject<NSCoding>

@property (nonatomic, copy) NSDate *date;

//am,pm
@property (nonatomic, copy) NSString *timeText;
//时间
@property (nonatomic, copy) NSString *timeClock;
//标签
@property (nonatomic, copy) NSString *tagStr;

//重复、标识符
@property (nonatomic, copy) NSString *repeatStr;
@property (nonatomic, copy) NSString *identifer;

@property (nonatomic, strong) NSArray *repeatStrs;
@property (nonatomic, strong) NSArray *identifers;//重复 闹钟 的标识符
//@property (nonatomic, strong) NSDateComponents *dateComponents;

@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) BOOL isLater;
@property (nonatomic, assign) BOOL repeats;

//添加闹钟
//- (void)addUserNotification;
//移除闹钟
//- (void)removeUserNotification;

- (NSDate *)date;
- (void)setDate:(NSDate *)date;

@property (nonatomic, strong) NSMutableArray *repeatArray;

@end


NS_ASSUME_NONNULL_END
