//
//  SPSZ_suoLoginModel.m
//  NanjingSPSZ
//
//  Created by Mr.Ling on 2018/5/27.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "SPSZ_suoLoginModel.h"

@implementation SPSZ_suoLoginModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.img_qs forKey:@"img_qs"];
    [aCoder encodeObject:self.img_entry forKey:@"img_entry"];
    [aCoder encodeObject:self.bus_license forKey:@"bus_license"];
    [aCoder encodeObject:self.stall_id forKey:@"stall_id"];
    [aCoder encodeObject:self.img_save forKey:@"img_save"];
    [aCoder encodeObject:self.create_date forKey:@"create_date"];
    [aCoder encodeObject:self.stall_no forKey:@"stall_no"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.stall_tel forKey:@"stall_tel"];
    [aCoder encodeObject:self.cityname forKey:@"cityname"];
    [aCoder encodeObject:self.stall_name forKey:@"stall_name"];
    [aCoder encodeObject:self.deptname forKey:@"deptname"];
    [aCoder encodeObject:self.bus_img forKey:@"bus_img"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.img_qs = [aDecoder decodeObjectForKey:@"img_qs"];
        self.img_entry = [aDecoder decodeObjectForKey:@"img_entry"];
        self.bus_license = [aDecoder decodeObjectForKey:@"bus_license"];
        self.stall_id = [aDecoder decodeObjectForKey:@"stall_id"];
        self.img_save = [aDecoder decodeObjectForKey:@"img_save"];
        self.create_date = [aDecoder decodeObjectForKey:@"create_date"];
        self.stall_no = [aDecoder decodeObjectForKey:@"stall_no"];
        self.stall_name = [aDecoder decodeObjectForKey:@"stall_name"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.stall_tel = [aDecoder decodeObjectForKey:@"stall_tel"];
        self.cityname = [aDecoder decodeObjectForKey:@"cityname"];
        self.deptname = [aDecoder decodeObjectForKey:@"deptname"];
        self.bus_img = [aDecoder decodeObjectForKey:@"bus_img"];
    }
    return self;
}
@end
