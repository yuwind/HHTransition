//
//  PushViewController.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2020/4/19.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "PushViewController.h"
#import "UIView+HHTransition.h"

@interface PushViewController () <HHInteractionMotionProtocol>

@property (nonatomic, assign) HHPushStyle style;
@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation PushViewController

+ (instancetype)instanceViewControllerWithStyle:(HHPushStyle)style {
    PushViewController *vc = [PushViewController new];
    vc.style = style;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.coverImageView = [UIImageView new];
    [self.view addSubview:self.coverImageView];
    self.coverImageView.image = [UIImage imageNamed:@"landscape.jpg"];
    self.coverImageView.hh_size = CGSizeMake(self.view.hh_width, self.view.hh_width);
    if (self.image) {
        self.coverImageView.image = self.image;
    }
    switch (self.style) {
        case HHPushStyleSlipFromTop:
        case HHPushStyleSlipFromBottom:
        case HHPushStyleSlipFromLeft:
        case HHPushStyleSlipFromRight:
            self.coverImageView.center = CGPointMake(self.view.hh_width / 2, self.view.hh_height / 2);
            break;
        case HHPushStyleTilted:
            self.coverImageView.center = CGPointMake(self.view.hh_width / 2, self.view.hh_height / 2);
            break;
        case HHPushStyleDrawer:
            self.coverImageView.center = CGPointMake(self.view.hh_width / 2, self.view.hh_height / 2);
            break;
        case HHPushStyleMotion:
            self.view.backgroundColor = [UIColor whiteColor];
            self.coverImageView.center = CGPointMake(self.view.hh_width / 2, self.view.hh_width / 2);
            break;
        case HHPushStyleTopBack:
            self.view.backgroundColor = [UIColor clearColor];
            self.coverImageView.hh_origin = CGPointMake(0, self.view.hh_height - self.view.hh_width);
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)hh_animationViewForMotionTransition {
    return self.coverImageView;
}

@end
