//
//  OAViewController.h
//  yghy
//
//  Created by zhangchao on 15/7/7.
//  Copyright (c) 2015年 zhangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OAViewController : UIViewController<UIWebViewDelegate>{
    
    UIWebView              *contentWebView;
    UIWebView              *showAffixView;
    UILabel                *titleLable;
    
    BOOL                   showAffix;
    BOOL                   isEmail;
    
    
}
@property(nonatomic,retain)    UIBarButtonItem               *closeBtn;
@property (nonatomic, retain) UIButton               *backBtn;
@property (nonatomic, retain) UIWebView              *contentWebView;
@property (nonatomic, retain) UIWebView              *showAffixView;
@property (nonatomic, assign) BOOL                   showAffix;
@property (nonatomic, assign) BOOL                   isEmail;
- (void)loadWebPageWithString:(NSString*)urlString;
- (void)addWebView;
- (void)removeWebView;

@end
