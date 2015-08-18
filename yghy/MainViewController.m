//
//  MainViewController.m
//  yghy
//
//  Created by zhangchao on 15/7/29.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "Header.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)logout{
    status =[[KeychainItemWrapper alloc] initWithIdentifier:@"status"accessGroup:Bundle];
    [status setObject:@"0" forKey:(id)kSecValueData];
    [self dismissViewControllerAnimated:YES completion:^(void){
    AppDelegate *delegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.UserName = nil;
}];
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
