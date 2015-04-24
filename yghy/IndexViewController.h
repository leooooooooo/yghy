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
}
- (void)loadWebPageWithString:(NSString*)urlString;


@end
