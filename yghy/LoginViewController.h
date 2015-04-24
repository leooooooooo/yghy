//
//  ViewController.h
//  航贸网
//
//  Created by leo on 14/11/9.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRSideViewController.h"

#import "KeychainItemWrapper.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>{

    KeychainItemWrapper *wrapper;
    KeychainItemWrapper *status;

}
@property (strong,nonatomic) YRSideViewController *sideViewController;
@property (retain, nonatomic) IBOutlet UISwitch *autologinswitch;
@property (retain, nonatomic) IBOutlet UISwitch *keepkeyswitch;
@property (strong, nonatomic) IBOutlet UITextField *ID;
@property (strong, nonatomic) IBOutlet UIButton *signin;
@property (strong, nonatomic) IBOutlet UITextField *PW;
- (IBAction)keyboarddisapper:(id)sender;
- (IBAction)topassword:(id)sender;
- (IBAction)dis:(id)sender;
- (IBAction)signinbt;
- (IBAction)keepkey:(id)sender;
- (IBAction)autologin:(id)sender;


@end

