//
//  Header.h
//  iLygport
//
//  Created by leo on 15/1/5.
//  Copyright (c) 2015年 leo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"


#define Bundle @"29TSL4289R.com.lyg.yghy"  //应用ID
#define NavigationBarColor [UIColor colorWithRed:0.16 green:0.69 blue:0.85 alpha:0.5]  //导航栏颜色
#define NavigationTitleColor [UIColor whiteColor]  //导航标题颜色
#define NavigationBackArrowColor [UIColor whiteColor] //导航栏返回键头颜色
#define AppName @"YGHY"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define PAGE1 @"首页"
#define PAGE2 @"签到"
#define PAGE3 @"我的应用"
#define PAGE4 @"最新消息"
#define isValid(object)     (object && ![object isEqual:[NSNull null]])   //判断当前对象是否有效
#define extern (AppDelegate *)[[UIApplication sharedApplication]delegate]  //全局变量


@interface Header : NSObject
+(void)NavigationConifigInitialize:(UIViewController *)sender;  //初始化导航
+(NSArray *)FunctionListInitialize;
@end
