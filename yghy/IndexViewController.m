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

@synthesize contentWebView;
@synthesize showAffixView;
@synthesize showAffix;
@synthesize isEmail;

- (void)viewDidLoad {
    
    UIImageView *navBarImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 54)];
    navBarImg.image = [UIImage imageNamed:@"titleBar_bg.png"];
    [self.view addSubview:navBarImg];
    
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80, 20, 150, 50)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"协同办公";
    [self.view addSubview:titleLable];

    closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"button_close.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(self.view.frame.size.width - 40, 27, 35, 35);
    [self.view addSubview:closeBtn];
    closeBtn.hidden = YES;
    
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
    webView.delegate = self;
    webView.scalesPageToFit =YES;
    webView.backgroundColor= [UIColor grayColor];
    [webView setFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    [self loadWebPageWithString:self.urlString];
    
    webView.scrollView.bounces=NO;
    webView.scrollView.alwaysBounceVertical = YES;


}

- (void)addWebView
{
    contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70)];
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
        titleLable.text = @"协同办公";
        showAffix = NO;
        closeBtn.hidden = YES;
    }
    else
    {
        [showAffixView removeFromSuperview];
        titleLable.text = @"协同办公";
        showAffix = NO;
        closeBtn.hidden = YES;
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
            
            closeBtn.hidden = NO;
            titleLable.text = @"附件";
            
            return YES;
        }
        else
        {
            isEmail = NO;
            showAffix = YES;
            closeBtn.hidden = NO;
            titleLable.text = @"附件";
            
            showAffixView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height - 70)];
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
