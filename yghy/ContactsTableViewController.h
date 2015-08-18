//
//  ContactsTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
@protocol PushDelegate <NSObject>
@optional
- (void)Push:(Person *)info;
@end

@interface ContactsTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *List;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) id<PushDelegate> PushDelegate;
@end
