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

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation BackScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];

    UIButton *button = [UIButton new];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}

@end
