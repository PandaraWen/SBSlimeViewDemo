//
//  SBSlimeView.m
//  SBSlimeViewDemo
//
//  Created by Pandara on 15/10/27.
//  Copyright © 2015年 Pandara. All rights reserved.
//

#import "SBSlimeView.h"
#import "SBSlimeDot.h"
#import "Define.h"
#import "SBLayoutToolKit.h"

#define HEADDOT_W 30.0f         //拖拽点
#define TRAILDOT_W_MAX 20.0f    //固定点
#define TRAILDOT_SCALE_MIN 0.25  //允许的最小尺寸占 TRAILDOT_W_MAX 的比例

@interface SBSlimeView()

@property (strong, nonatomic) SBSlimeDot *headDot;
@property (strong, nonatomic) SBSlimeDot *trailDot;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@end

@implementation SBSlimeView
+ (SBSlimeView *)getInstance
{
    SBSlimeView *view = [[SBSlimeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.brokeDistance = 150;
        
        self.shapeLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.layer addSublayer:self.shapeLayer];
        
        self.trailDot.center = CGPointMake(frame.size.width / 2.0f, frame.size.height / 2.0f);
        [self addSubview:self.trailDot];
        
        self.headDot.center = CGPointMake(frame.size.width / 2.0f, frame.size.height / 2.0f);
        [self addSubview:self.headDot];

        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHeadDot:)];
        [self.headDot addGestureRecognizer:panGesture];
        
    }
    
    return self;
}

#pragma mark - Method
- (CGFloat)getDistanceBetweenDots
{
    CGFloat x1 = self.trailDot.center.x;
    CGFloat y1 = self.trailDot.center.y;
    CGFloat x2 = self.headDot.center.x;
    CGFloat y2 = self.headDot.center.y;
    
    CGFloat distance = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    
    return distance;
}

- (void)reloadBezierPath
{
    CGFloat r1 = self.trailDot.frame.size.width / 2.0f;
    CGFloat r2 = self.headDot.frame.size.width / 2.0f;
    
    CGFloat x1 = self.trailDot.center.x;
    CGFloat y1 = self.trailDot.center.y;
    CGFloat x2 = self.headDot.center.x;
    CGFloat y2 = self.headDot.center.y;
    
    CGFloat distance = sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
    
    CGFloat sinDegree = (x2 - x1) / distance;
    CGFloat cosDegree = (y2 - y1) / distance;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosDegree, y1 + r1 * sinDegree);
    CGPoint pointB = CGPointMake(x1 + r1 * cosDegree, y1 - r1 * sinDegree);
    CGPoint pointC = CGPointMake(x2 + r2 * cosDegree, y2 - r2 * sinDegree);
    CGPoint pointD = CGPointMake(x2 - r2 * cosDegree, y2 + r2 * sinDegree);
    CGPoint pointN = CGPointMake(pointB.x + (distance / 2) * sinDegree, pointB.y + (distance / 2) * cosDegree);
    CGPoint pointM = CGPointMake(pointA.x + (distance / 2) * sinDegree, pointA.y + (distance / 2) * cosDegree);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    [path addQuadCurveToPoint:pointC controlPoint:pointN];
    [path addLineToPoint:pointD];
    [path addQuadCurveToPoint:pointA controlPoint:pointM];
    
    self.shapeLayer.path = path.CGPath;
}

- (void)broke
{
    self.shapeLayer.path = nil;
    [UIView animateWithDuration:0.7f delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.trailDot.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)placeHeadDot
{
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.headDot.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Action
- (void)panHeadDot:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            CGPoint location = [panGesture locationInView:self.headDot.superview];
            self.headDot.center = location;
            
            CGFloat distance = [self getDistanceBetweenDots];
            
            if (distance < self.brokeDistance) {
                CGFloat scale = (1 - distance / self.brokeDistance);
                scale = MAX(TRAILDOT_SCALE_MIN, scale);
                self.trailDot.transform = CGAffineTransformMakeScale(scale, scale);
                
                [self reloadBezierPath];
            } else {
                [self broke];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self placeHeadDot];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Setter Getter
- (SBSlimeDot *)headDot
{
    if (!_headDot) {
        _headDot = [[SBSlimeDot alloc] initWithFrame:CGRectMake(0, 0, HEADDOT_W, HEADDOT_W)];
    }
    
    return _headDot;
}

- (SBSlimeDot *)trailDot
{
    if (!_trailDot) {
        _trailDot = [[SBSlimeDot alloc] initWithFrame:CGRectMake(0, 0, TRAILDOT_W_MAX, TRAILDOT_W_MAX)];
    }
    
    return _trailDot;
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = COLOR_BLUE_SB.CGColor;
        _shapeLayer.anchorPoint = CGPointMake(0, 0);
        _shapeLayer.position = CGPointMake(0, 0);
    }
    
    return _shapeLayer;
}

@end















