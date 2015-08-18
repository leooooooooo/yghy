//
//  MessageButton.m
//  MyAppCenter
//
//  Created by lu_sicong on 2014/03/13.
//  Copyright (c) 2014年 lu_sicong. All rights reserved.
//

#import "MessageButton.h"

#define BtnTitleFrame       CGRectMake(5, TileButtonSize - 20 - 5, 120, 20)

@implementation MessageButton

@dynamic appIcon, strBtnTitle;

@synthesize appIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_btnTitle = [[UILabel alloc] initWithFrame:BtnTitleFrame];
        m_btnTitle.font = [UIFont boldSystemFontOfSize:14];
        m_btnTitle.textColor = [UIColor whiteColor];
        m_btnTitle.backgroundColor = [UIColor clearColor];
        
        [self addSubview:m_btnTitle];
        
        m_icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 90, 90)];
        m_icon.backgroundColor = [UIColor clearColor];
        
        [self addSubview:m_icon];
    }
    return self;
}

- (UIImage *)appIcon
{
    return self.currentBackgroundImage;
}

- (void) setAppIcon:(UIImage *)appIcon
{
    [self setBackgroundImage:appIcon forState:UIControlStateNormal];
}

- (UIImage *)subIcon
{
    return m_icon.image;
}

- (void)setSubIcon:(UIImage *)subIcon
{
    m_icon.image = subIcon;
}

-(NSString *)strBtnTitle
{
    return m_btnTitle.text;
}

- (void) setStrBtnTitle:(NSString *)strBtnTitle
{
    m_btnTitle.text = strBtnTitle;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
