//
//  Header1.m
//  wlkg
//
//  Created by zhangchao on 15/7/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "Header.h"

@implementation Header

+(void)NavigationConifigInitialize:(UIViewController *)sender
{

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [sender.navigationItem setBackBarButtonItem:backButton];
    [sender.navigationController.navigationBar setTintColor:NavigationBackArrowColor];
    [sender.navigationController.navigationBar setBarTintColor:NavigationBarColor];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:NavigationTitleColor forKey:NSForegroundColorAttributeName];
    sender.navigationController.navigationBar.titleTextAttributes=dict;
}

+(NSArray *)FunctionListInitialize
{
    return [[NSArray alloc]initWithObjects:
            @"公司新闻",@"待办事项",@"通知公告",@"航运动态",@"已办查询",
            nil];

}
@end
