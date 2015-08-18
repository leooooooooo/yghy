//
//  ViewController.m
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import "LoginViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "IndexViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"

#define UpdateAlertViewTag 1

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.UpdateDelegate = [[[Update alloc]init]autorelease];
    [self.UpdateDelegate GetUpdateInfo:self.view];
    
    self.ID.layer.cornerRadius=5;
    self.ID.borderStyle=UITextBorderStyleRoundedRect;
    self.PW.layer.cornerRadius=5;
    self.PW.borderStyle=UITextBorderStyleRoundedRect;
    self.signin.layer.cornerRadius=5;
    
    //keychain
    self.keepkeyswitch.on = NO;
    self.autologinswitch.on = NO;
    
    
    
    
    //当前版本
    UILabel *Version = [[[UILabel alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height-65, 200, 30)]autorelease];
    Version.text = [NSString stringWithFormat:@"当前版本：%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    Version.font = [UIFont boldSystemFontOfSize:14];
    Version.textColor = [UIColor whiteColor];
    [self.view addSubview:Version];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number"accessGroup:Bundle];
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    //从keychain里取出帐号密码状态
    NSString *keepkey = [status objectForKey:(id)kSecAttrAccount];
    NSString *autologin = [status objectForKey:(id)kSecValueData];
    
    
    if([keepkey isEqual:@"1"]){
        self.keepkeyswitch.on = YES;
    }
    if([keepkey isEqual:@"0"]){
        self.keepkeyswitch.on = NO;
    }
    if([autologin isEqual:@"1"]){
        self.autologinswitch.on = YES;
    }
    if([autologin isEqual:@"0"]){
        self.autologinswitch.on = NO;
    }
    
    
    
    //从keychain里取出帐号密码
    NSString *password = [wrapper objectForKey:(id)kSecValueData];
    NSString *account = [wrapper objectForKey:(id)kSecAttrAccount];
    
    self.ID.text = account;
    self.PW.text = password;

    
    if ([[status objectForKey:(id)kSecValueData] isEqual:@"1"]) {
        [self signinbt];
    }
    
    if([autologin isEqual:@"1"]){
        self.autologinswitch.on = YES;
    }
    if([autologin isEqual:@"0"]){
        self.autologinswitch.on = NO;
    }

    //跳过登录
    //[self performSegueWithIdentifier:@"login" sender:self];
}


-(IBAction)signinbt{
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/oa/login.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:10.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"Logogram=%@&Password=%@", self.ID.text, self.PW.text];
    //将nstring转换成nsdata
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"body data %@", body);
    [request setHTTPBody:body];
    
    //这里是非代理的异步请求，异步请求并不会阻止主线程的继续执行，不用等待网络请结束。
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
        //这段块代码只有在网络请求结束以后的后续处理。
        if (data != nil) {  //接受到数据，表示工作正常
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *Info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"%@", Info);
            //NSString *a = [Info objectForKey:@"ErrorMessage"];
            //NSLog(a);
            UIAlertView *alert;
            if([[Info objectForKey:@"LoginStatus"] isEqual:@"Success"])
            {
                
                alert = [[UIAlertView alloc]initWithTitle:@"" message:[Info objectForKey:@"Message"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                //保存登录信息
                AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                delegate.UserName=[Info objectForKey:@"UserName"] ;
                
                
                
                IndexViewController *index=[[[IndexViewController alloc]init]autorelease];

                MainViewController *mainViewController=[[[MainViewController alloc]initWithRootViewController:index]autorelease];
                index.NavDelegate = mainViewController;
                
                [self presentViewController:mainViewController animated:YES completion:nil];
                
                
                
                //保存按钮状态
                if(self.keepkeyswitch.isOn)
                {
                    [status setObject:@"1" forKey:(id)kSecAttrAccount];
                }else
                {
                    [status setObject:@"0" forKey:(id)kSecAttrAccount];
                }
                if(self.autologinswitch.isOn){
                    [status setObject:@"1" forKey:(id)kSecValueData];
                }else
                {
                    [status setObject:@"0" forKey:(id)kSecValueData];
                }
                if (self.keepkeyswitch.isOn) {
                    //保存帐号
                    [wrapper setObject:self.ID.text forKey:(id)kSecAttrAccount];
                    //保存密码
                    [wrapper setObject:self.PW.text forKey:(id)kSecValueData];
                }
            }
            else
            {
                alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[Info objectForKey:@"Message"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
            if ([Info objectForKey:@"Message"]!=[NSNull null])
            {
                [alert show];
            }

        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"网络超时" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert;
                alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:error.localizedDescription delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
    }];
}

- (IBAction)keepkey:(id)sender {
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"是");
    }else {
        [wrapper resetKeychainItem];
    }
}

- (IBAction)autologin:(id)sender {
    if(self.autologinswitch.on){
        [status setObject:@"1" forKey:(id)kSecValueData];
    }else
    {
        [status setObject:@"0" forKey:(id)kSecValueData];
    }

}

- (IBAction)keyboarddisapper:(id)sender {
    [self.ID resignFirstResponder];
    [self.PW resignFirstResponder];
}

- (IBAction)topassword:(id)sender {
    [self.PW becomeFirstResponder];
}

- (IBAction)dis:(id)sender {
    [sender resignFirstResponder];
}




- (void)dealloc {
    [_keepkeyswitch release];
    [_autologinswitch release];
    [super dealloc];
}
@end

