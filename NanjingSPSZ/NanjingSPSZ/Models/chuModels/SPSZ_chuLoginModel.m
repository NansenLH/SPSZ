//
//  SPSZ_chuLoginModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_chuLoginModel.h"

@implementation SPSZ_chuLoginModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.img_qs forKey:@"img_qs"];
    [aCoder encodeObject:self.socialcode forKey:@"socialcode"];
    [aCoder encodeObject:self.companyname forKey:@"companyname"];
    [aCoder encodeObject:self.bus_img forKey:@"bus_img"];
    [aCoder encodeObject:self.cityid forKey:@"cityid"];
    [aCoder encodeObject:self.login_Id forKey:@"login_Id"];
    [aCoder encodeObject:self.img_entry forKey:@"img_entry"];
    [aCoder encodeObject:self.img_save forKey:@"img_save"];
    [aCoder encodeObject:self.stall_no forKey:@"stall_no"];
    [aCoder encodeObject:self.salertype forKey:@"salertype"];
    [aCoder encodeObject:self.cityname forKey:@"cityname"];
    [aCoder encodeObject:self.realname forKey:@"realname"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.img_qs = [aDecoder decodeObjectForKey:@"img_qs"];
        self.socialcode = [aDecoder decodeObjectForKey:@"socialcode"];
        self.companyname = [aDecoder decodeObjectForKey:@"companyname"];
        self.bus_img = [aDecoder decodeObjectForKey:@"bus_img"];
        self.cityid = [aDecoder decodeObjectForKey:@"cityid"];
        self.login_Id = [aDecoder decodeObjectForKey:@"login_Id"];
        self.img_entry = [aDecoder decodeObjectForKey:@"img_entry"];
        self.img_save = [aDecoder decodeObjectForKey:@"img_save"];
        self.stall_no = [aDecoder decodeObjectForKey:@"stall_no"];
        self.salertype = [aDecoder decodeObjectForKey:@"salertype"];
        self.cityname = [aDecoder decodeObjectForKey:@"cityname"];
        self.realname = [aDecoder decodeObjectForKey:@"realname"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    //前面是model中的名字,后面是json中的名字
    return @{@"login_id" : @"id"};
}

- (NSString *)description {
    return [self yy_modelDescription];
}
@end
