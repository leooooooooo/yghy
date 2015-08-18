//
//  ContactsViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/27.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ContactsViewController.h"



@interface ContactsViewController ()
{
    ContactsTableViewController *ContactsTableVC;
}
@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [Header NavigationConifigInitialize:self];
    
    
    
    [self checkUpdataList];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HEIGHT) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    ContactsTableVC = [[ContactsTableViewController alloc]init];
    ContactsTableVC.List = self.List;
    ContactsTableVC.PushDelegate = self;
    UINavigationController *searchnav = [[UINavigationController alloc]initWithRootViewController:ContactsTableVC];
    searchnav.navigationBarHidden = YES;
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:ContactsTableVC];
    self.searchController.searchResultsUpdater = self;

    [self.searchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tableView];
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
    
    [self Push:info];
}

-(void)Push:(Person *)info
{
    //self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    ContactDetailViewController *vc =[[ContactDetailViewController alloc]init];
    
    vc.Person = info;
    vc.title = info.name;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [nav setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSLog(@"Entering:%@",searchString);

    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ or department CONTAINS[c] %@", searchString,searchString];
    

    ContactsTableVC.List = [NSMutableArray arrayWithArray:[self.List filteredArrayUsingPredicate:preicate]];
    
    //过滤数据
    [ContactsTableVC.tableView reloadData];

    
}



-(void)checkUpdataList
{
    self.CoreDataManager = [[ContactsManager alloc]init];
    //更新时间
    NSString *updateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateDate"];
    
    if (!updateDate) {
        //如果无此对象，表示第一次，那么就读数据写到数据库中
        [self writeDate];
        NSLog(@"首次获取数据");
    }else{
        //有此对象说明只要从数据库中读数据
        NSTimeInterval update = updateDate.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        //8小时一更新
        if ((now - update)>8*60*60) {
            //如果超出八小时就把数据库清空再重新写
            [self.CoreDataManager deleteData];
            [self writeDate];
            NSLog(@"更新数据");
        }else{
            //没有超过8小时就从数据库中读
            NSMutableArray *array = [self.CoreDataManager selectData:999 andOffset:0];
            self.List = [NSMutableArray arrayWithArray:array];
            NSLog(@"读取数据库");
        }
    }
    
}

-(void)writeDate
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] forKey:@"updateDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *URL = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/Contacts/GetPersonContactList.aspx?AppName=%@",AppName];
    NSError *error;
    //加载一个NSURL对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setTimeoutInterval:60.0f];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSArray *array = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    self.List = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        Person *info = [[Person alloc]initWithDictionary:dict];
        [self.List addObject:info];
    }
    //把数据写到数据库
    [self.CoreDataManager insertCoreData:self.List];
    //[newsTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
