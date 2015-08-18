//
//  ContactsTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "Header.h"
#import "ContactDetailViewController.h"

@interface ContactsTableViewController ()

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Header NavigationConifigInitialize:self];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -44, WIDTH, HEIGHT+44)];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    back.backgroundColor = [UIColor lightGrayColor];
    [super.view addSubview:back];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil)
    {
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //Date
        CGRect DateRect = CGRectMake(20,11,120,22);
        CGPoint i = DateRect.origin;
        //CGSize j = DateRect.size;
        UILabel *DateLabel = [[UILabel alloc]initWithFrame:DateRect];
        DateLabel.font = [UIFont systemFontOfSize:16];
        DateLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        DateLabel.textAlignment= NSTextAlignmentLeft;
        
        [cell.contentView addSubview:DateLabel];
        
        //Fund
        CGRect FundRect = CGRectMake(WIDTH-220, i.y, 200, 22);
        UILabel *FundLabel = [[UILabel alloc]initWithFrame:FundRect];
        //i = FundRect.origin;
        //j = FundRect.size;
        FundLabel.font = [UIFont systemFontOfSize:16];
        FundLabel.tag = 2;
        FundLabel.textAlignment= NSTextAlignmentRight;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:FundLabel];
        
    }
    
    
    
    //Date
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [(Person *)[self.List objectAtIndex:indexPath.row]name];
    //Fund
    ((UILabel *)[cell.contentView viewWithTag:2]).text = [(Person *)[self.List objectAtIndex:indexPath.row]department];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *info = [self.List objectAtIndex:indexPath.row];
    
    [self.PushDelegate Push:info];

}

@end
