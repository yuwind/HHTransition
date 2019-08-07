//
//  SecondViewController.m
//  EasyTransition
//
//  Created by 豫风 on 2017/2/13.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "BackScaleViewController.h"
#import "VCTransitionDelegate.h"
#import "UIViewController+HHTransition.h"

@interface BackScaleViewController ()

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation BackScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 400)];
    _bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_bottomView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonClick)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.4 animations:^{
        self.bottomView.y = [UIScreen mainScreen].bounds.size.height-self.bottomView.height;
    }];
}

- (void)buttonClick
{
    [UIView animateWithDuration:0.4 animations:^{
        self.bottomView.y = [UIScreen mainScreen].bounds.size.height;
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}

@end
