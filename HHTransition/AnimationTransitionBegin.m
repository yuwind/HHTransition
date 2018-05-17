//
//  AnimationTransition.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2018/5/17.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "AnimationTransitionBegin.h"
#import "UIView+HHConstraint.h"

@interface AnimationTransitionBegin()<CAAnimationDelegate>

@property (nonatomic, assign) InteractionStyle style;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;

@end
@implementation AnimationTransitionBegin

+ (instancetype)animationStyle:(InteractionStyle)style
{
    AnimationTransitionBegin *animation = [AnimationTransitionBegin new];
    animation.style = style;
    return animation;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    
    self.transitionContext = transitionContext;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    switch (_style) {
        case TransitonStyleCube:{
            animation.type = @"cube";
            animation.subtype = kCATransitionFromRight;
        }
            break;
        case TransitonStyleSuckEffect:{
            animation.type = @"suckEffect";
        }
            break;
        case TransitonStyleOglFlip:{
            animation.type = @"oglFlip";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        case TransitonStyleRippleEffect:{
            animation.type = @"rippleEffect";
        }
            break;
        case TransitonStylePageCurl:{
            animation.type = @"pageUnCurl";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        case TransitonStyleCameralIrisHollowOpen:{
            animation.type = @"cameralIrisHollowOpen";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        default:
            break;
    }
    [transitionContext.containerView.layer addAnimation:animation forKey:@"AnimationTransitionBegin"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    flag?[self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled]:nil;
}

@end
