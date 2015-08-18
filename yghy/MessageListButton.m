//
//  MessageListButton.m
//  Main
//
//  Created by lu_sicong on 2014/05/09.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MessageListButton.h"

#define BtnTitleFrame       CGRectMake(40, 10, 200, 20)
#define NewsTitleHeight     12

#define newsTitleOriginY    35

@implementation MessageListButton

@synthesize newsArr = m_newsArr;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_btnTitle.frame = BtnTitleFrame;
        m_btnTitle.font = [UIFont boldSystemFontOfSize:18];
        
    }
    return self;
}

- (void) setNewsArr:(NSArray *)newsArr
{
    m_newsArr = newsArr;
    m_btnTitle.text = [NSString stringWithFormat:@"%@ %lu",m_btnTitle.text,(unsigned long)m_newsArr.count];
    
    CGFloat originY = newsTitleOriginY;
    
    NSInteger maxCount = ((self.frame.size.height - originY - 25) / NewsTitleHeight);
    
    for (NSString *title in newsArr) {
        [self addLabel:title andOriginY:originY];
        originY += 16;
        maxCount --;
        
        if (maxCount == 0) {
            break;
        }
    }
    
//    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    countLabel.frame = CGRectMake(118, 10, 50, 20);
//    countLabel.backgroundColor = [UIColor clearColor];
//    countLabel.textColor = [UIColor whiteColor];
//    countLabel.text = [NSString stringWithFormat:@"%d",m_newsArr.count];
//    countLabel.font = [UIFont systemFontOfSize:18];
//    [self addSubview:countLabel];
//    [countLabel release];
}

- (void) addLabel:(NSString *)title andOriginY :(CGFloat) y
{
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tmpLabel.frame = CGRectMake(20, y, self.frame.size.width - 30, 16);
    tmpLabel.backgroundColor = [UIColor clearColor];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.text = [NSString stringWithFormat:@"● %@",title];
    
    tmpLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:tmpLabel];
    
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
