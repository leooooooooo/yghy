//
//  MessageButton.h
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TileButtonSize                  120
#define TileSeparatorInset              5

@interface MessageButton : UIButton
{
    UILabel *m_btnTitle;
    
    UIImageView *m_icon;
}

@property (nonatomic, retain) UIImage *appIcon;

@property (nonatomic, retain) UIImage *subIcon;

@property (nonatomic) NSInteger appIndex;

@property (nonatomic, retain) NSString *strBtnTitle;

@end

