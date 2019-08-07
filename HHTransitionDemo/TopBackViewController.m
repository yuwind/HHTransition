//
//  TopBackViewController.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2019/7/19.
//  Copyright © 2019 豫风. All rights reserved.
//

#import "TopBackViewController.h"
#import "UIView+HHLayout.h"
#import "AnimationStyle.h"
#import "UIViewController+HHTransition.h"

@interface TopBackViewController ()

@end

@implementation TopBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *tempColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    
    UIView *closeView = [UIView new];
    [self.view addSubview:closeView];
    closeView.top_.left_.righ_.equalTo(self.view).on_();
    if (KISiPhoneX) {
        closeView.heit_.constant(78).on_();
    }else{
        closeView.heit_.constant(64).on_();
    }
    [closeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTopView:)]];
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = tempColor;
    [self.view addSubview:headerView];
    headerView.top_.left_.righ_.equalTo(closeView.bott_).on_();
    headerView.heit_.constant(45).on_();
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(9, 9)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45);
    maskLayer.path = maskPath.CGPath;
    headerView.layer.mask = maskLayer;
    
    UIView *contentView = [UIView new];
    [self.view addSubview:contentView];
    contentView.backgroundColor = tempColor;
    contentView.top_.equalTo(headerView.bott_).on_();
    contentView.left_.righ_.bott_.equalTo(self.view).on_();
}


/**
 需要调用hh_popBackViewController关闭当前浮层

 */
- (void)didClickTopView:(UITapGestureRecognizer *)gesture
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
