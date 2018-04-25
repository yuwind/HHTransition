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
#import "UIView+HHConstraint.h"
#import "InterScaleViewController.h"

NSString * presentStyle[] =
{
    @"TransitionStyleCircle",
    @"TransitionStyleBackScale",
    @"TransitionStyleErect",
};

NSString * pushStyle[] =
{
    @"InteractionStyleScale",
    @"InteractionStyleTilted",
    @"InteractionStyleErect",
    @"InteractionStyleBack",
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
            return 3;
            break;
        case 1:
            return 4;
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
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 200);
            [cell.contentView addSubview:button];
            [button addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.row+3+1234;
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
            button2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 200);
            [cell.contentView addSubview:button2];
            [button2 addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button2.tag = indexPath.row+4+1234;
        }else{
            
            cell.textLabel.text =pushStyle[indexPath.row];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
            [cell.contentView addSubview:button];
            [button addTarget:self action:@selector(circleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = indexPath.row+4+1234;
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
            [self.navigationController hh_presentCircleVC:circleVC point:_touchPoint completion:nil];
        }
            break;
        case 1:
            [self.navigationController hh_presentBackScaleVC:[BackScaleViewController new] height:400 completion:nil];
            break;
        case 2:{
            CircleViewController *circleVC = [CircleViewController new];
            circleVC.isNeedShow = YES;
            [self.navigationController hh_presentErectVC:circleVC completion:nil];
        }
            break;
        case 3:{
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"1.jpg"];
            [self.navigationController hh_pushScaleViewController:interScale];
        }
            break;
        case 4:{
            InterScaleViewController *interScale = [InterScaleViewController new];
            interScale.imageName = [UIImage imageNamed:@"2.jpg"];
            [self.navigationController hh_pushScaleViewController:interScale];
        }
            break;
        case 5:
            [self.navigationController hh_pushTiltViewController:[CircleViewController new]];
            break;
        case 6:
            [self.navigationController hh_pushErectViewController:[CircleViewController new]];
            break;
        case 7:
            [self.navigationController hh_pushBackViewController:[CircleViewController new]];
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
