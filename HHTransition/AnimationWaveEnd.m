//
//  AnimationWaveEnd.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "AnimationWaveEnd.h"
#import "QuadrantRecognise.h"

@interface AnimationWaveEnd ()<CAAnimationDelegate>

@property (nonatomic, assign) CGPoint originPoint;
@property (nonatomic, assign)id<UIViewControllerContextTransitioning>transitionContext;

@end


@implementation AnimationWaveEnd

+ (instancetype)animationOrigin:(CGPoint)originPoint
{
    AnimationWaveEnd *waveEnd = [[AnimationWaveEnd alloc] init];
    waveEnd.originPoint = originPoint;
    return waveEnd;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIBezierPath *initPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){_originPoint,CGSizeZero}];
    CGFloat radius = [QuadrantRecognise recogniseWithPoint:_originPoint];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset((CGRect){_originPoint,CGSizeZero}, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = initPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnim.fromValue = (__bridge id _Nullable)(finalPath.CGPath);
    basicAnim.toValue = (__bridge id _Nullable)(initPath.CGPath);
    basicAnim.delegate = self;
    basicAnim.duration = [self transitionDuration:transitionContext];
    
    [maskLayer addAnimation:basicAnim forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    flag?[self.transitionContext completeTransition:YES]:nil;
}

@end
