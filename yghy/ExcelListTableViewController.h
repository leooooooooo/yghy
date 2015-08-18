//
//  ExcelListTableViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLRefreshHeadController.h"

@interface ExcelListTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,CLLRefreshHeadControllerDelegate,UIDocumentInteractionControllerDelegate>
@property (retain,nonatomic) NSMutableArray *List;


@end
