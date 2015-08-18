//
//  NewsListTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/8.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLRefreshHeadController.h"

@interface NewsListTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,CLLRefreshHeadControllerDelegate>
@property (retain,nonatomic) NSMutableArray *List;
@property int mark;
@end
