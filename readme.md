# slime effect in iOS，in obj-c
---
![image](http://7ls0ue.com1.z0.glb.clouddn.com/2015/10/27/ios_slime/SBSlime2.gif)

##The principle

![image](http://7ls0ue.com1.z0.glb.clouddn.com/2015/10/27/ios_slime/slime_rule.png)

##Code in calculating

```obj-c
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
```
## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## SpecialThanks

[@KittenYang](https://github.com/KittenYang/KYCuteView)







