//
//  MessageClassButton.m
//  Main
//
//  Created by lu_sicong on 2014/05/09.
//  Copyright (c) 2014年 Sea. All rights reserved.
//

#import "MessageClassButton.h"

@implementation MessageClassButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        m_btnTitle.frame = CGRectMake(5, frame.size.height - 25, frame.size.width, 20);
        m_btnTitle.textAlignment = NSTextAlignmentLeft;
    }
    return self;
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
