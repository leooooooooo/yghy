//
//  Update.h
//  yghy
//
//  Created by zhangchao on 15/6/15.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define UpdateAlertViewTag 1

@protocol UpdateDelegate <NSObject>
@required
@optional
-(void)CheckUpdate:(UIView *)inView;
-(void)GetUpdateInfo:(UIView *)inView;
@end

@interface Update : NSObject<UpdateDelegate>
@property(retain,nonatomic)UIView *view;
@end

