//
//  LeftViewController.m
//  LeafSlideMenu
//
//  Created by Wang on 14-7-3.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "LeftViewController.h"
#import "IndexViewController.h"
#import "Header.h"
#import "AppDelegate.h"


@interface LeftViewController (){
    NSArray *List;
}

@end

static NSString *identifier = @"cell";

@implementation LeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height/3)];
    head.image = [UIImage imageNamed:@"登录"];
    //UIView *head = [[[UIView alloc] autorelease];
    self.tableView.tableHeaderView = head;
    self.tableView.backgroundView=head;//[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"登录"]];
    NSArray *list1 = [[NSArray alloc]initWithObjects:@"重载网络",@"imgname", nil];
    NSArray *list2 = [[NSArray alloc]initWithObjects:@"检查更新",@"imgname", nil];
    NSArray *list3 = [[NSArray alloc]initWithObjects:@"登出",@"imgname", nil];
    List = [[NSArray alloc]initWithObjects:list1,list2,list3, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height/7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [[List objectAtIndex:indexPath.row]objectAtIndex:0];

    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
//    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];

    switch (indexPath.row) {
        case 0:
            [self.ReloadDelegate Reload];
            break;
        case 1:
            [self CheckUpdate];
            break;
        case 2:
            [self Logout];
            break;
    
        default:
            break;
    }
}


-(void)Logout
{
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    [status setObject:@"0" forKey:(id)kSecValueData];
    [super dismissViewControllerAnimated:YES completion:^(void){
        AppDelegate *delegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        delegate.UserName = nil;
    }];

}

- (void)CheckUpdate{
    UIAlertView *alert;
    if ([[(AppDelegate *)[[UIApplication sharedApplication]delegate]Update]isEqualToString:@"Yes"]) {
        
        alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到新版本%@，请点击更新安装新版本",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Version]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
    }
    else
    {
        alert = [[UIAlertView alloc]initWithTitle:@"更新" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    }
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        //Update *up = [[Update alloc]init];
        UIWebView *up = [[UIWebView alloc]init];
        NSURL *url =[NSURL URLWithString:[(AppDelegate *)[[UIApplication sharedApplication]delegate]Url]];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [up loadRequest:request];
        NSLog(@"开始更新",nil);


    }
}


@end
