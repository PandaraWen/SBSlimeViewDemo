//
//  SBLayoutToolKit.h
//  SBSlimeViewDemo
//
//  Created by Pandara on 15/10/27.
//  Copyright © 2015年 Pandara. All rights reserved.
//

@import UIKit;

@interface SBLayoutToolKit : NSObject

+ (void)setView:(UIView *)view toOrigin:(CGPoint)origin;
+ (void)setView:(UIView *)view toSize:(CGSize)size;
+ (void)setView:(UIView *)view toSizeWidth:(CGFloat)width;
+ (void)setView:(UIView *)view toOriginX:(CGFloat)x;
+ (void)setViews:(NSArray *)views toOriginX:(CGFloat)x;
+ (void)setViews:(NSArray *)views toSizeWidth:(CGFloat)width;
+ (void)setView:(UIView *)view toSizeHeight:(CGFloat)height;
+ (void)setView:(UIView *)view toOriginY:(CGFloat)y;

@end
