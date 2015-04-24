//
//  IndexViewController.m
//  yghy
//
//  Created by zhangchao on 15/4/18.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "IndexViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"


@interface IndexViewController ()
@property (nonatomic,retain)NSString *urlString;
@end

@implementation IndexViewController



- (void)viewDidLoad {
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [super viewDidLoad];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone Simulator; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    // Do any additional setup after loading the view, typically from a nib.
    self.urlString =[NSString stringWithFormat:@"http://218.92.115.51/portal/m/index_sso.jsp?userId=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName]];
    webView.delegate = self;
    webView.scalesPageToFit =YES;
    webView.backgroundColor= [UIColor grayColor];
    //[webView setFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20)];
    [self loadWebPageWithString:self.urlString];
    
    webView.scrollView.bounces=NO;
    webView.scrollView.alwaysBounceVertical = YES;

    
}

-(void)Reload
{
    [self loadWebPageWithString:self.urlString];
}


- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

//回调
//UIWebView委托方法，开始加载一个url时候调用此方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
}
//UIWebView委托方法，url加载完成的时候调用此方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
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
