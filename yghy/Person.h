//
//  Person.h
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *duty;
@property (nonatomic, strong) NSString *mobilephone;
@property (nonatomic, strong) NSString *backupmobilephone;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *backuptelephone;
@property (nonatomic, strong) NSString *workemail;
@property (nonatomic, strong) NSString *personalemail;
@property (nonatomic, strong) NSString *weibo;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
