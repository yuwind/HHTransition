//
//  InterScaleViewController.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2018/4/20.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "InterScaleViewController.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"

@interface InterScaleViewController ()

@property (nonatomic, strong) UIImageView *imageView_;
@property (nonatomic, strong) UILabel *alertLabel;

@end

@implementation InterScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    self.imageView_ = imageView;
    imageView.image = _imageName;
    [self.view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    self.alertLabel = label;
    label.text = @"点击任意点关闭或侧滑查看效果";
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    label.bott_.centX.equalTo(self.view).offset(20).install();
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.alertLabel.hh_bottomCS.constant = -200;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//需要实现
- (UIView *)hh_transitionAnimationView
{
    return self.imageView_;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}


@end
