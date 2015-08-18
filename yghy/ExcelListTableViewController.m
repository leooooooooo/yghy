
//
//  ExcelListTableViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/18.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ExcelListTableViewController.h"
#import "Header.h"

@interface ExcelListTableViewController ()
{
    int loadCount;
    int Max_Count;
}
@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;
@property (nonatomic,strong) NSURL *FileURL;
@property (nonatomic,retain) UIDocumentInteractionController *documentController;
@end

@implementation ExcelListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Header NavigationConifigInitialize:self];

    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    self.List = [[NSMutableArray alloc]init];
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customXibCellIdentifier];
        
        //头像
        CGRect imageRect = CGRectMake(8, 5, 35, 35);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = 2;
        
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 1;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
        
        //发送者
        CGPoint i =imageRect.origin;
        CGSize j = imageRect.size;
        CGRect nameRect = CGRectMake(i.x+j.width+10, i.y+13, WIDTH/1.3, 10);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont systemFontOfSize:16];
        nameLabel.tag = 1;
        //nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *dic  = [self.List objectAtIndex:indexPath.row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:1]).text = [dic objectAtIndex:1];
    
    //图标
    ((UIImageView *)[cell.contentView viewWithTag:2]).image = [UIImage imageNamed:@"Excel"];
    return cell;
    
}



//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(NSMutableArray *)getArray:(long)page
{
    NSString *URL= [NSString stringWithFormat:@"http://218.92.115.55/yghy/Service/GetShipMovementList.aspx?Pages=%d",loadCount];
    
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *Json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    return [Json objectForKey:@"ShipList"];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *info = [self.List objectAtIndex:indexPath.row];
    
    NSString *urlString =[NSString stringWithFormat:@"http://www.ygmarine.com/upload_archive/%@",[info objectAtIndex:2]];
    NSString *name =[info objectAtIndex:1];
    NSURL *URL = [[NSURL alloc]initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    URL = [self downloadFile:[info objectAtIndex:2] withURL:URL];
    self.FileURL = URL;
    //网页打开
    UIViewController *vc = [[UIViewController alloc]init];
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    webView.scalesPageToFit =YES;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:URL]];
    [vc.view addSubview:webView];
    //查询按钮
    UIBarButtonItem *select = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openInOtherApp)];
    vc.navigationItem.rightBarButtonItem = select;
    select.title = [URL absoluteString];

    vc.title = name;
    [self.navigationController pushViewController:vc animated:YES];
 
}

-(NSURL *)downloadFile:(NSString *)FileName withURL:(NSURL *)URL
{
    //下载文件
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *FilePath = [doc stringByAppendingPathComponent:FileName];
    
    NSLog(FilePath,nil);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Copy the database sql file from the resourcepath to the documentpath
    if (![fileManager fileExistsAtPath:FilePath])
    {
        NSData *data = [NSData dataWithContentsOfURL:URL];
        [data writeToFile:FilePath atomically:YES];//将NSData类型对象data写入文件，文件名为FileName
    }
    return [NSURL fileURLWithPath:FilePath];
}

-(void)openInOtherApp
{
    // Initialize Document Interaction Controller
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:self.FileURL];
    
    // Configure Document Interaction Controller
    [self.documentController setDelegate:self];
    
    // Present Open In Menu
    [self.documentController presentOpenInMenuFromRect:CGRectMake(760, 20, 100, 100) inView:self.view animated:YES];
}

#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}


- (CLLRefreshHeadController *)refreshControll
{
    if (!_refreshControll) {
        _refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:self.tableView viewDelegate:self];
    }
    return _refreshControll;
}

#pragma mark-
#pragma mark- CLLRefreshHeadContorllerDelegate
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}
- (BOOL)keepiOS7NewApiCharacter {
    
    if (!self.navigationController)
        return NO;
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (void)beginPullDownRefreshing {
    Max_Count = 15;
    loadCount = 1;
    
    self.List = [self getArray:loadCount];
    
    if(self.List.count<15)
    {
        Max_Count = loadCount;
    }
    
    NSLog(@"当前页数 %d",loadCount);
    [self performSelector:@selector(endRefresh) withObject:nil];
}
- (void)beginPullUpLoading
{
    NSLog(@"当前页数 %d",loadCount);
    
    [self.List addObjectsFromArray:[self getArray:loadCount]];
    
    [self performSelector:@selector(endLoadMore) withObject:nil];
    
}
//是显示更多
- (BOOL)hasRefreshFooterView {
    if (self.List.count > 0 && loadCount < Max_Count) {
        return YES;
    }
    return NO;
}

- (void)endRefresh {
    loadCount =2;
    
    [self.tableView reloadData];
    
    [self.refreshControll endPullDownRefreshing];
}
- (void)endLoadMore {
    loadCount ++;
    
    [self.tableView reloadData];
    
    [self.refreshControll endPullUpLoading];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.refreshControll startPullDownRefreshing];
}

@end
