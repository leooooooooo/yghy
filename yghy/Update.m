//
//  Update.m
//  yghy
//
//  Created by zhangchao on 15/6/15.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "Update.h"
#import "Header.h"


@implementation Update


- (void)CheckUpdate:(UIView *)inView{
    self.view = inView;
    UIAlertView *alert;
    if ([[(AppDelegate *)[[UIApplication sharedApplication]delegate]Update]isEqualToString:@"Yes"]) {
        
        alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到新版本%@，请点击更新安装新版本",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Version]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
    }
    else
    {
        alert = [[UIAlertView alloc]initWithTitle:@"更新" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    }
    alert.tag = UpdateAlertViewTag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag)
    {
        case UpdateAlertViewTag:
            switch (buttonIndex)
        {
                
            case 1:[self Update];break;
            default:break;
        }
            break;
            
        default:break;
    }
    
}

- (void)Update
{
    UIWebView *up = [[UIWebView alloc]init];
    NSURL *url =[NSURL URLWithString:[(AppDelegate *)[[UIApplication sharedApplication]delegate]Url]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [up loadRequest:request];
    [self.view addSubview:up];
    NSLog(@"开始更新",nil);
}

-(void)GetUpdateInfo:(UIView *)inView
{
    self.view = inView;
    //1确定地址NSURL
    NSString *urlString = [NSString stringWithFormat:@"http://218.92.115.55/MobilePlatform/Update.aspx"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //2建立请求NSMutableURLRequest（post需要用这个）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //网络访问超时时间
    [request setTimeoutInterval:10.0f];
    //1)post请求方式,网络请求默认是get方法，所以如果我们用post请求，必须声明请求方式。
    [request setHTTPMethod:@"POST"];
    //2)post请求的数据体,post请求中数据体时，如果有中文，不需要转换。因为ataUsingEncoding方法已经实现了转码。
    NSString *bodyStr = [NSString stringWithFormat:@"AppName=%@&DeviceType=iOS&Build=%@",AppName,[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    //将nstring转换成nsdata
    NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"body data %@", body);
    [request setHTTPBody:body];
    
    //这里是非代理的异步请求，异步请求并不会阻止主线程的继续执行，不用等待网络请结束。
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError * error) {
        //这段块代码只有在网络请求结束以后的后续处理。
        UIAlertView *alert;
        if (data != nil) {  //接受到数据，表示工作正常
            //NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *Update = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            delegate.Update = [Update objectForKey:@"Update"];
            NSLog(@"%@", Update);
            
            if([[Update objectForKey:@"Update"]isEqualToString:@"Yes"])
            {
                delegate.Url = [Update objectForKey:@"Url"];
                delegate.Version = [Update objectForKey:@"Version"];
                alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到新版本%@，请点击更新安装新版本",[Update objectForKey:@"Version"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                
                //版本更新button
                UIButton *newVersion = [[UIButton alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height-85, 200, 30)];
                [newVersion setTitle:[NSString stringWithFormat:@"最新版本：%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Version]] forState:UIControlStateNormal];
                newVersion.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                [newVersion setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
                newVersion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [newVersion addTarget:self action:@selector(CheckUpdate) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:newVersion];
                alert.tag =UpdateAlertViewTag;
                [alert show];
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新" message:@"当前已经是最新版本" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
        }
        else
        {
            if(data == nil && error == nil)    //没有接受到数据，但是error为nil。。表示接受到空数据。
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:@"更新失败，网络超时" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            }
            else
            {
                //alert = [[UIAlertView alloc]initWithTitle:@"更新失败" message:error.localizedDescription delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                NSLog(@"%@", error.localizedDescription);  //请求出错。
            }
        }
        
        
    }];
    
}

@end

