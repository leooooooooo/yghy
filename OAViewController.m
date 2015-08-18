//
//  OAViewController.m
//  yghy
//
//  Created by zhangchao on 15/7/7.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "OAViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@interface OAViewController ()
@property (nonatomic,retain)NSString *urlString;
@property (nonatomic, retain) UIWebView *webView;
@end

@implementation OAViewController

@synthesize contentWebView;
@synthesize showAffixView;
@synthesize showAffix;
@synthesize isEmail;

- (void)viewDidLoad {
    
    
    self.title = @"协同办公";
    
    self.closeBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeWebView)];
    /*
    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"button_close.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(self.view.frame.size.width - 40, 27, 35, 35);
    [self.view addSubview:closeBtn];
     
    closeBtn.hidden = YES;
    */
    showAffix = NO;
    isEmail   = NO;
    
    
    //[self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [super viewDidLoad];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone Simulator; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    // Do any additional setup after loading the view, typically from a nib.
    self.urlString =[NSString stringWithFormat:@"http://218.92.115.51/portal/m/index_sso.jsp?userId=%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]UserName]];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit =YES;
    self.webView.backgroundColor= [UIColor grayColor];
    [self loadWebPageWithString:self.urlString];
    
    self.webView.scrollView.bounces=NO;
    self.webView.scrollView.alwaysBounceVertical = YES;
    
    [self.view addSubview:self.webView];
}

- (void)addWebView
{
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentWebView.scalesPageToFit = YES;
    contentWebView.delegate = self;
    [self.view addSubview:contentWebView];
    
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:@"Mozilla/5.0 (iPhone Simulator; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3", @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
}

- (void)removeWebView
{
    [contentWebView removeFromSuperview];
}

- (void)closeWebView
{
    if (isEmail == YES)
    {
        [contentWebView goBack];
        self.title= @"协同办公";
        showAffix = NO;
        //closeBtn.hidden = YES;
        [self.navigationItem setRightBarButtonItem:nil];

    }
    else
    {
        [showAffixView removeFromSuperview];
        self.title= @"协同办公";
        showAffix = NO;
        //closeBtn.hidden = YES;
        [self.navigationItem setRightBarButtonItem:nil];

    }
}


-(void)Reload
{
    [self loadWebPageWithString:self.urlString];
}


- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSLog(@"%@",url);
    NSString *downString = [url absoluteString];
    NSRange foundObj=[downString rangeOfString:@"downfile" options:NSCaseInsensitiveSearch];
    
    if(foundObj.length > 0)
    {
        NSLog(@"是下载连接");
        NSRange isEmailURL=[downString rangeOfString:@"Email" options:NSCaseInsensitiveSearch];
        
        if (isEmailURL.length > 0)//是邮件模块链接
        {
            isEmail = YES;
            showAffix = NO;
            [self.navigationItem setRightBarButtonItem:self.closeBtn];
            //closeBtn.hidden = NO;
            self.title= @"附件";
            
            return YES;
        }
        else
        {
            isEmail = NO;
            showAffix = YES;
            [self.navigationItem setRightBarButtonItem:self.closeBtn];

            //closeBtn.hidden = NO;
            self.title= @"附件";
            
            showAffixView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
            showAffixView.scalesPageToFit = YES;
            [self.view addSubview:showAffixView];
            
            [showAffixView loadRequest:[NSURLRequest requestWithURL:url]];
            
            return NO;
        }
    }
    else
    {
        NSLog(@"不是下载连接");
        showAffix = NO;
        isEmail = NO;
    }
    
    return YES;
}

@end
