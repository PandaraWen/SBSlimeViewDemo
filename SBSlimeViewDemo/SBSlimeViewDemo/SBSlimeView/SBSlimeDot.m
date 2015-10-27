//
//  SBSlimeDot.m
//  SBSlimeViewDemo
//
//  Created by Pandara on 15/10/27.
//  Copyright © 2015年 Pandara. All rights reserved.
//

#import "SBSlimeDot.h"
#import "Define.h"

@implementation SBSlimeDot

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_BLUE_SB;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.layer.cornerRadius = frame.size.width / 2.0f;
}

@end
