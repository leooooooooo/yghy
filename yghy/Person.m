//
//  Person.m
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        
        self.userID = [dictionary objectForKey:@"userID"];
        self.name = [dictionary objectForKey:@"name"];
        self.company = [dictionary objectForKey:@"company"];
        self.department = [dictionary objectForKey:@"department"];
        self.duty = [dictionary objectForKey:@"duty"];
        self.mobilephone = [dictionary objectForKey:@"mobilephone"];
        self.backupmobilephone = [dictionary objectForKey:@"backupmobilephone"];
        self.telephone = [dictionary objectForKey:@"telephone"];
        self.backuptelephone = [dictionary objectForKey:@"backuptelephone"];
        self.workemail = [dictionary objectForKey:@"workemail"];
        self.personalemail = [dictionary objectForKey:@"personalemail"];
        self.weibo = [dictionary objectForKey:@"weibo"];
    }
    return self;
}

@end
