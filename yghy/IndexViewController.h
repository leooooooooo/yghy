//
//  IndexViewController.h
//  yghy
//
//  Created by zhangchao on 15/4/18.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavDelegate
@optional
-(void)logout;
@end
@interface IndexViewController : UIViewController
@property (nonatomic,assign) id<NavDelegate> NavDelegate;
@end
