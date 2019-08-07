//
//  ViewController.m
//  EasyTransition
//
//  Created by 豫风 on 2016/12/28.
//  Copyright © 2016年 豫风. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HHTransition.h"
#import "BackScaleViewController.h"
#import "CircleViewController.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"
#import "InterScaleViewController.h"
#import "TopBackViewController.h"

NSString * presentStyle[] =
{
    @"AnimationStyleCircle",
    @"AnimationStyleBackScale",
    @"AnimationStyleErect",
    @"AnimationStyleTilted",
};

NSString * pushStyle[] =
{
    @"AnimationStyleScale",
    @"AnimationStyleErect",
    @"AnimationStyleTilted",
    @"AnimationStyleBack",
    @"AnimationStyleCube",
    @"AnimationStyleSuckEffect",
    @"AnimationStyleOglFlip",
    @"AnimationStyleRippleEffect",
    @"AnimationStylePageCurl",
    @"AnimationStyleCameralIrisHollowOpen",
    @"AnimationStyleTopBack",
};
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)];
     _touchPoint = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 80);

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Present";
            break;
        case 1:
            return @"Push";
            break;
        default:
            break;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 11;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        
        cell.textLabel.text = presentStyle[indexPath.row];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
        [cell.contentView addSubview:button];
        [button addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = indexPath.row+1234;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 200);
            [cell.contentView addSubview:button];
            [button addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.row+4+1234;
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
            button2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 200);
            [cell.contentView addSubview:button2];
            [button2 addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button2.tag = indexPath.row+5+1234;
        }else{
            
            cell.textLabel.text =pushStyle[indexPath.row];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
            [cell.contentView addSubview:button];
            [button addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.row+5+1234;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 1) {
        return 200.0f;
    }
    return 60.0f;
}

- (void)circleButtonClick:(UIButton *)sender
{
    self.button = sender;
    switch (sender.tag-1234) {
        case 0:{
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self hh_presentCircleVC:circleVC point:_touchPoint completion:nil];
        }
            break;
        case 1://内部只做背部控制器动画，前台动画自己控制
            [self hh_presentVC:[BackScaleViewController new] type:AnimationStyleBackScale completion:nil];
            break;
        case 2:{
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self hh_presentVC:circleVC type:AnimationStyleErect completion:nil];
        }
            break;
        case 3:{
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self hh_presentVC:circleVC type:AnimationStyleTilted completion:nil];
        }
            break;
        case 4:{
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"1.jpg"];
            [self.navigationController hh_pushViewController:interScale style:AnimationStyleScale];
        }
            break;
        case 5:{
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"2.jpg"];
            [self.navigationController hh_pushViewController:interScale style:AnimationStyleScale];
        }
            break;
        case 6:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleErect];
            break;
        case 7:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleTilted];
            break;
        case 8:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleBack];
            break;
        case 9:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleCube];
            break;
        case 10:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleSuckEffect];
            break;
        case 11:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleOglFlip];
            break;
        case 12:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleRippleEffect];
            break;
        case 13:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStylePageCurl];
            break;
        case 14:
            [self.navigationController hh_pushViewController:[CircleViewController new] style:AnimationStyleCameralIrisHollowOpen];
            break;
        case 15:
            [self.navigationController hh_pushViewController:[TopBackViewController new] style:AnimationStyleTopBack];
            break;
        default:
            break;
    }
}

- (UIView *)hh_transitionAnimationView//need to override
{
    return self.button;
}

@end
