//
//  DeviceInfo.m
//  linkuslight
//
//  Created by Aba on 17/10/6.
//  Copyright © 2017年 linkustek. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.deviceID forKey:@"deviceID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.deviceID forKey:@"ip"];
    [aCoder encodeObject:self.name forKey:@"macAddr"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeBool:self.isOn forKey:@"isOn"];
    [aCoder encodeBool:self.hasClockFlag forKey:@"hasClockFlag"];
    [aCoder encodeBool:self.hasStatuFlag forKey:@"hasStatuFlag"];
    [aCoder encodeInt:self.linkState forKey:@"linkState"];
    [aCoder encodeInt:self.deviceType forKey:@"deviceType"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.deviceID = [aDecoder decodeObjectForKey:@"deviceID"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.macAddr = [aDecoder decodeObjectForKey:@"macAddr"];
    self.ip = [aDecoder decodeObjectForKey:@"ip"];
    self.desc = [aDecoder decodeObjectForKey:@"desc"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.linkState = [aDecoder decodeIntForKey:@"linkState"];
    self.deviceType = [aDecoder decodeIntForKey:@"deviceType"];
    self.isOn = [aDecoder decodeBoolForKey:@"isOn"];
    self.hasClockFlag = [aDecoder decodeBoolForKey:@"hasClockFlag"];
    self.hasStatuFlag = [aDecoder decodeBoolForKey:@"hasStatuFlag"];
    return self;
    
}

@end

@implementation GroupInfo
- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.deviceID forKey:@"deviceID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeBool:self.isOn forKey:@"isOn"];
    [aCoder encodeInt:self.deviceType forKey:@"deviceType"];
    [aCoder encodeObject:self.deviceArr forKey:@"deviceArr"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self.deviceID = [aDecoder decodeObjectForKey:@"deviceID"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.deviceArr = [aDecoder decodeObjectForKey:@"deviceArr"];
    self.isOn = [aDecoder decodeBoolForKey:@"isOn"];
    self.deviceType = [aDecoder decodeIntForKey:@"deviceType"];
    return self;
    
}
@end

@implementation ScenceInfo

@end
