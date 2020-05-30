//
//  PresentViewController.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2020/4/19.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "PresentViewController.h"
#import "UIView+HHTransition.h"

@interface PresentViewController ()

@property (nonatomic, assign) HHPresentStyle style;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, assign) CGPoint touchPoint;

@end

@implementation PresentViewController

+ (instancetype)instanceViewControllerWithStyle:(HHPresentStyle)style {
    PresentViewController *vc = [PresentViewController new];
    vc.style = style;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coverImageView = [UIImageView new];
    [self.view addSubview:self.coverImageView];
    self.coverImageView.image = [UIImage imageNamed:@"landscape.jpg"];
    self.coverImageView.hh_size = CGSizeMake(self.view.hh_width, self.view.hh_width);
    switch (self.style) {
        case HHPresentStyleSlipFromTop:
            self.coverImageView.center = CGPointMake(self.view.hh_width / 2, self.view.hh_height / 2);
            break;
        case HHPresentStyleSlipFromBottom:
        case HHPresentStyleSlipFromLeft:
        case HHPresentStyleSlipFromRight:
        self.coverImageView.hh_origin = CGPointMake(0, self.view.hh_height - self.view.hh_width);
            break;
        case HHPresentStyleCircle:
        case HHPresentStyleTilted:
        case HHPresentStyleErected:
            self.view.backgroundColor = [UIColor redColor];
            self.coverImageView.center = CGPointMake(self.view.hh_width / 2, self.view.hh_height / 2);
            break;
        case HHPresentStyleBackScale:
        self.coverImageView.hh_origin = CGPointMake(0, self.view.hh_height - self.view.hh_width);
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.touchPoint = [touches.anyObject locationInView:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGPoint)hh_touchPointForCircleTransition {
    return self.touchPoint;
}

@end
