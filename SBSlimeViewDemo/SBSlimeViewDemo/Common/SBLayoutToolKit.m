//
//  SBLayoutToolKit.m
//  SBSlimeViewDemo
//
//  Created by Pandara on 15/10/27.
//  Copyright © 2015年 Pandara. All rights reserved.
//

#import "SBLayoutToolKit.h"

@implementation SBLayoutToolKit

+ (void)setView:(UIView *)view toOrigin:(CGPoint)origin
{
    CGRect frame = view.frame;
    frame.origin = origin;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toSize:(CGSize)size
{
    CGRect frame = view.frame;
    frame.size = size;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toSizeHeight:(CGFloat)height
{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toOriginY:(CGFloat)y
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

+ (void)setView:(UIView *)view toOriginX:(CGFloat)x
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

+ (void)setViews:(NSArray *)views toOriginX:(CGFloat)x
{
    for (UIView *view in views) {
        [SBLayoutToolKit setView:view toOriginX:x];
    }
}

+ (void)setView:(UIView *)view toSizeWidth:(CGFloat)width
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

+ (void)setViews:(NSArray *)views toSizeWidth:(CGFloat)width
{
    for (UIView *view in views) {
        [SBLayoutToolKit setView:view toSizeWidth:width];
    }
}

@end
