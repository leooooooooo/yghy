//
//  ContactDetailViewController.m
//  wlkg
//
//  Created by zhangchao on 15/7/28.
//  Copyright (c) 2015年 leo. All rights reserved.
//

#import "ContactDetailViewController.h"
#import "Header.h"

#define ScrollViewOriginX   (0.0)
#define ScrollViewOriginY   (100.0)
#define lineHeight          (28.0)
#define lineBlockHeight     (2.0)

@interface ContactDetailViewController (){
    UITextField    *company;
    
    UIButton    *telephoneField;
    
    UITextField    *emailField;
    
    UITextField    *departField;
    
    UITextField    *dutyField;
    
    UIButton    *bakTelField;
    
    UIButton    *officeTelField;
    
    UIButton    *bakOfficeTelField;
    
    UITextField    *perEmailField;
    
    UITextField    *weiboField;

}

@end

@implementation ContactDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *exit = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:exit];
    
    [Header NavigationConifigInitialize:self];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    
    [self addDetailView];
    [self LoadData];
}

- (void)callAction:(id)sender{//(NSString *)number{
    
    NSString *number =((UIButton *)sender).titleLabel.text;
    if (number.length==8) {
        number = [NSString stringWithFormat:@"0518%@",number];
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",number];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

-(void)LoadData
{
    company.text = self.Person.company;
    departField.text = self.Person.department;
    dutyField.text = self.Person.duty;
    
    [telephoneField setTitle:self.Person.mobilephone forState:UIControlStateNormal];
    [bakTelField setTitle:self.Person.backupmobilephone forState:UIControlStateNormal];
    [officeTelField setTitle:self.Person.telephone forState:UIControlStateNormal];
    [bakOfficeTelField setTitle:self.Person.backuptelephone forState:UIControlStateNormal];
    
    emailField.text = self.Person.workemail;
    perEmailField.text = self.Person.personalemail;
    weiboField.text = self.Person.weibo;
}

-(void)addDetailView
{
    CGFloat originY = 100.0;
    
    UILabel *officePhoneLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    officePhoneLab.text = @"公司:";
    officePhoneLab.font = [UIFont boldSystemFontOfSize:16];
    officePhoneLab.textColor = [UIColor grayColor];
    officePhoneLab.textAlignment = NSTextAlignmentRight;
    officePhoneLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:officePhoneLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *departLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    departLab.text = @"部门:";
    departLab.font = [UIFont boldSystemFontOfSize:16];
    departLab.textColor = [UIColor grayColor];
    departLab.textAlignment = NSTextAlignmentRight;
    departLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:departLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *dutyLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    dutyLab.text = @"职务:";
    dutyLab.font = [UIFont boldSystemFontOfSize:16];
    dutyLab.textColor = [UIColor grayColor];
    dutyLab.textAlignment = NSTextAlignmentRight;
    dutyLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dutyLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    phoneLab.text = @"工作手机:";
    phoneLab.font = [UIFont boldSystemFontOfSize:16];
    phoneLab.textColor = [UIColor grayColor];
    phoneLab.textAlignment = NSTextAlignmentRight;
    phoneLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:phoneLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *bakTelLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    bakTelLab.text = @"备用手机:";
    bakTelLab.font = [UIFont boldSystemFontOfSize:16];
    bakTelLab.textColor = [UIColor grayColor];
    bakTelLab.textAlignment = NSTextAlignmentRight;
    bakTelLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bakTelLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *officeTelLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    officeTelLab.text = @"办公电话:";
    officeTelLab.font = [UIFont boldSystemFontOfSize:16];
    officeTelLab.textColor = [UIColor grayColor];
    officeTelLab.textAlignment = NSTextAlignmentRight;
    officeTelLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:officeTelLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *bakOfficeTel = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    bakOfficeTel.text = @"备用电话:";
    bakOfficeTel.font = [UIFont boldSystemFontOfSize:16];
    bakOfficeTel.textColor = [UIColor grayColor];
    bakOfficeTel.textAlignment = NSTextAlignmentRight;
    bakOfficeTel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bakOfficeTel];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *mailLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    mailLab.text = @"集团邮箱:";
    mailLab.font = [UIFont boldSystemFontOfSize:16];
    mailLab.textColor = [UIColor grayColor];
    mailLab.textAlignment = NSTextAlignmentRight;
    mailLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mailLab];

    originY += lineHeight + lineBlockHeight;
    
    UILabel *perEmailLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - ScrollViewOriginX, originY, 80, lineHeight)];
    perEmailLab.text = @"个人邮箱:";
    perEmailLab.font = [UIFont boldSystemFontOfSize:16];
    perEmailLab.textColor = [UIColor grayColor];
    perEmailLab.textAlignment = NSTextAlignmentRight;
    perEmailLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:perEmailLab];
    
    originY += lineHeight + lineBlockHeight;
    
    UILabel *weiboLab = [[UILabel alloc] initWithFrame:CGRectMake(10 - 5 - ScrollViewOriginX, originY, 85, lineHeight)];
    weiboLab.text = @"云之家微博:";
    weiboLab.font = [UIFont boldSystemFontOfSize:16];
    weiboLab.textColor = [UIColor grayColor];
    weiboLab.textAlignment = NSTextAlignmentRight;
    weiboLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:weiboLab];
    
    originY = 100.0;
    
    company = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    company.backgroundColor = [UIColor clearColor];
    company.font = [UIFont systemFontOfSize:16];
    
    company.textAlignment = NSTextAlignmentLeft;
    company.enabled = NO;
    company.textColor = [UIColor blackColor];
    [self.view addSubview:company];
    
    originY += lineHeight + lineBlockHeight;
    
    departField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    departField.backgroundColor = [UIColor clearColor];
    departField.font = [UIFont systemFontOfSize:16];
    
    departField.textAlignment = NSTextAlignmentLeft;
    departField.enabled = NO;
    departField.textColor = [UIColor blackColor];
    [self.view addSubview:departField];
    
    originY += lineHeight + lineBlockHeight;
    
    dutyField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    dutyField.backgroundColor = [UIColor clearColor];
    dutyField.font = [UIFont systemFontOfSize:16];
    
    dutyField.textAlignment = NSTextAlignmentLeft;
    dutyField.enabled = NO;
    dutyField.textColor = [UIColor blackColor];
    [self.view addSubview:dutyField];
    
    originY += lineHeight + lineBlockHeight;
    
    telephoneField = [[UIButton alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    telephoneField.backgroundColor = [UIColor clearColor];
    telephoneField.titleLabel.font = [UIFont systemFontOfSize:16];
    telephoneField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [telephoneField setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [telephoneField addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telephoneField];
    
    originY += lineHeight + lineBlockHeight;
    
    bakTelField = [[UIButton alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    bakTelField.backgroundColor = [UIColor clearColor];
    bakTelField.titleLabel.font = [UIFont systemFontOfSize:16];
    bakTelField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bakTelField setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bakTelField addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bakTelField];
    
    originY += lineHeight + lineBlockHeight;
    
    
    //[newVersion setTitle:[NSString stringWithFormat:@"最新版本：%@",[(AppDelegate *)[[UIApplication sharedApplication]delegate]Version]] forState:UIControlStateNormal];
   // newVersion.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    //[newVersion setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //newVersion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[newVersion addTarget:self action:@selector(CheckUpdate:) forControlEvents:UIControlEventTouchUpInside];

    
    
    officeTelField = [[UIButton alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    officeTelField.backgroundColor = [UIColor clearColor];
    officeTelField.titleLabel.font = [UIFont systemFontOfSize:16];
    officeTelField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [officeTelField setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [officeTelField addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:officeTelField];
    
    originY += lineHeight + lineBlockHeight;
    
    bakOfficeTelField = [[UIButton alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    bakOfficeTelField.backgroundColor = [UIColor clearColor];
    bakOfficeTelField.titleLabel.font = [UIFont systemFontOfSize:16];
    bakOfficeTelField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bakOfficeTelField setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bakOfficeTelField addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bakOfficeTelField];
    
    originY += lineHeight + lineBlockHeight;
    
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    emailField.backgroundColor = [UIColor clearColor];
    emailField.font = [UIFont systemFontOfSize:16];
    
    emailField.textAlignment = NSTextAlignmentLeft;
    emailField.enabled = NO;
    emailField.textColor = [UIColor blackColor];
    [self.view addSubview:emailField];
    
    originY += lineHeight + lineBlockHeight;
    
    perEmailField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    perEmailField.backgroundColor = [UIColor clearColor];
    perEmailField.font = [UIFont systemFontOfSize:16];
    
    perEmailField.textAlignment = NSTextAlignmentLeft;
    perEmailField.enabled = NO;
    perEmailField.textColor = [UIColor blackColor];
    [self.view addSubview:perEmailField];
    
    originY += lineHeight + lineBlockHeight;
    
    weiboField = [[UITextField alloc] initWithFrame:CGRectMake(100 - ScrollViewOriginX, originY, 210, lineHeight)];
    weiboField.backgroundColor = [UIColor clearColor];
    weiboField.font = [UIFont systemFontOfSize:16];
    
    weiboField.textAlignment = NSTextAlignmentLeft;
    weiboField.enabled = NO;
    weiboField.textColor = [UIColor blackColor];
    [self.view addSubview:weiboField];

    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
