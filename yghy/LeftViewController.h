//
//  LeftViewController.h
//  LeafSlideMenu
//
//  Created by Wang on 14-7-3.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "Update.h"


@protocol MenuDelegate
@optional
-(void)Reload;
@end
@interface LeftViewController : UITableViewController<UIAlertViewDelegate,UIWebViewDelegate>{

    KeychainItemWrapper *status;
}
@property(assign,nonatomic)id<MenuDelegate>ReloadDelegate;
@property(assign,nonatomic)id<UpdateDelegate>UpdateDelegate;
@end
