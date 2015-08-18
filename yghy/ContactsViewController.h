//
//  ContactsViewController.h
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsManager.h"
#import "Person.h"
#import "Header.h"
#import "ContactsTableViewController.h"
#import "ContactDetailViewController.h"

@interface ContactsViewController : UISearchController<UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,PushDelegate>
@property (nonatomic, retain)ContactsManager *CoreDataManager;
@property (nonatomic, retain) NSMutableArray *List;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@end
