//
//  ViewController.m
//  HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "ViewController.h"
#import "HHTransition.h"
#import "PresentViewController.h"
#import "PushViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource,HHPresentCircleProtocol,HHInteractionMotionProtocol>

@property (nonatomic, copy) NSArray *presentStyleArray;
@property (nonatomic, copy) NSArray *pushStyleArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGPoint touchPoint;
@property (nonatomic, strong) UIView *motionView;

@end

@implementation ViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section) {
        [self.navigationController hh_pushViewController:[PushViewController instanceViewControllerWithStyle:indexPath.row + 1] style:indexPath.row + 1];
        return;
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.touchPoint = cell.center;
    [self hh_presentViewController:[PresentViewController instanceViewControllerWithStyle:indexPath.row + 1] presentStyle:indexPath.row + 1 completion:nil];
}

- (void)motionButtonClick:(UIButton *)sender {
    self.motionView = sender;
    PushViewController *vc = [PushViewController instanceViewControllerWithStyle:HHPushStyleMotion];
    vc.image =  sender.imageView.image;
    [self.navigationController hh_pushViewController:vc style:HHPushStyleMotion];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.hh_width, self.view.hh_height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, mISiPhoneX ? 44 : 20)];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section) {
        return self.pushStyleArray.count;
    }
    return self.presentStyleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.presentStyleArray[indexPath.row];
    } else if (indexPath.section == 1){
        if (indexPath.row == 6) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"landscape.jpg"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 200);
            [cell.contentView addSubview:button];
            [button addTarget:self action:@selector(motionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setImage:[UIImage imageNamed:@"landscape2.jpg"] forState:UIControlStateNormal];
            button2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 200);
            [cell.contentView addSubview:button2];
            [button2 addTarget:self action:@selector(motionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *label = [UILabel new];
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.pushStyleArray[indexPath.row];
        } else {
            cell.textLabel.text = self.pushStyleArray[indexPath.row];
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section ? @"Push" : @"Present";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 6) {
        return 200.0f;
    }
    return 60.0f;
}

- (CGPoint)hh_touchPointForCircleTransition {
    return self.touchPoint;
}

- (UIView *)hh_animationViewForMotionTransition {
    return self.motionView;
}

- (NSArray *)presentStyleArray {
    return @[@"HHPresentStyleSlipFromTop",
             @"HHPresentStyleSlipFromBottom",
             @"HHPresentStyleSlipFromLeft",
             @"HHPresentStyleSlipFromRight",
             @"HHPresentStyleCircle",
             @"HHPresentStyleTilted",
             @"HHPresentStyleErected",
             @"HHPresentStyleBackScale",
             @"HHPresentStyleCube",
             @"HHPresentStyleFade",
             @"HHPresentStyleMoveIn",
             @"HHPresentStylePageCurl",
             @"HHPresentStyleTopBack",
    ];
}

- (NSArray *)pushStyleArray {
    return @[@"HHPushStyleSlipFromTop",
             @"HHPushStyleSlipFromBottom",
             @"HHPushStyleSlipFromLeft",
             @"HHPushStyleSlipFromRight",
             @"HHPushStyleTilted",
             @"HHPushStyleDrawer",
             @"HHPushStyleMotion",
             @"HHPushStyleTopBack",
    ];
}

@end
