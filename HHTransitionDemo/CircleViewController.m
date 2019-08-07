//
//  ThirdViewController.m
//  EasyTransition
//
//  Created by 豫风 on 2017/2/14.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "CircleViewController.h"
#import "VCTransitionDelegate.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"

@interface CircleViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    if (self.isNeedShow) {
        self.titleLabel.hidden = NO;
        self.alertLabel.hidden = YES;
    }
}

- (IBAction)thirdButtonClick:(id)sender
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    [self hh_dismissWithPoint:[touch locationInView:self.view] completion:nil];
}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}


@end
