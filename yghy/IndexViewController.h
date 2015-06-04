//
//  IndexViewController.h
//  yghy
//
//  Created by zhangchao on 15/4/18.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"


@interface IndexViewController : UIViewController<UIWebViewDelegate,MenuDelegate>{
    IBOutlet UIWebView *webView;
    
    UIWebView              *contentWebView;
    UIWebView              *showAffixView;
    UIButton               *closeBtn;
    UILabel                *titleLable;
    
    BOOL                   showAffix;
    BOOL                   isEmail;
    

}
@property (nonatomic, retain) UIButton               *backBtn;
@property (nonatomic, retain) UIWebView              *contentWebView;
@property (nonatomic, retain) UIWebView              *showAffixView;
@property (nonatomic, assign) BOOL                   showAffix;
@property (nonatomic, assign) BOOL                   isEmail;
- (void)loadWebPageWithString:(NSString*)urlString;
- (void)addWebView;
- (void)removeWebView;

@end
