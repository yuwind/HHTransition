//
//  UIView+HHLayout.h
//  https://github.com/yuwind/HHLayout
//
//  Created by 豫风 on 2017/12/7.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ContentPriority) {
    ContentPriorityDefault,
    ContentPriorityHigh,
    ContentPriorityRequired,
};

@interface UIView (HHLayout)

/**
 非约束方式
 */
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 约束方式
 */
@property (nonatomic, assign, readonly) UIView * top_;
@property (nonatomic, assign, readonly) UIView * left_;
@property (nonatomic, assign, readonly) UIView * bott_;
@property (nonatomic, assign, readonly) UIView * righ_;
@property (nonatomic, assign, readonly) UIView * widt_;
@property (nonatomic, assign, readonly) UIView * heit_;
@property (nonatomic, assign, readonly) UIView * lead_;
@property (nonatomic, assign, readonly) UIView * trai_;
@property (nonatomic, assign, readonly) UIView * cent_;
@property (nonatomic, assign, readonly) UIView * centX;
@property (nonatomic, assign, readonly) UIView * centY;
@property (nonatomic, assign, readonly) UIView * size_;
@property (nonatomic, assign, readonly) UIView * (^rate_wh)(CGFloat);
@property (nonatomic, assign, readonly) UIView * (^rate_hw)(CGFloat);
@property (nonatomic, assign, readonly) UIView * (^widPriority)(ContentPriority);
@property (nonatomic, assign, readonly) UIView * (^higPriority)(ContentPriority);
@property (nonatomic, assign, readonly) UIView * (^equalTo)(UIView *);
@property (nonatomic, assign, readonly) UIView * (^greatThan)(UIView *);
@property (nonatomic, assign, readonly) UIView * (^lessThan)(UIView *);
@property (nonatomic, assign, readonly) UIView * (^constant)(CGFloat);
#warning 必须以nil结尾 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
@property (nonatomic, assign, readonly) UIView * (^constList)(NSNumber *,...);//需要以nil结尾
@property (nonatomic, assign, readonly) UIView * (^offset)(CGFloat);
@property (nonatomic, assign, readonly) UIView * (^on_)(void);
@property (nonatomic, assign, readonly) UIView * (^removeAll)(void);

/**
 快速添加约束
 */
@property (nonatomic, assign, readonly) UIView * (^topLeft_)(CGRect);//左上距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^topRight_)(CGRect);//右上距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^bottomLeft_)(CGRect);//左下距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^bottomRight_)(CGRect);//右上距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^heightTop_)(CGRect);//左上右距离父控件、高度固定
@property (nonatomic, assign, readonly) UIView * (^heightBottom_)(CGRect);//左下右距离父控件、高度固定
@property (nonatomic, assign, readonly) UIView * (^insetFrame_)(CGRect);//约束四周边距,对应左上下右
@property (nonatomic, assign, readonly) UIView * (^around_)(void);//约束等于父视图

/**
 回调约束对象,可后期修改，做动画eg.
 */
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_topCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_leftCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_bottomCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_rightCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_widthCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_heightCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_leadingCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_trailingCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_centerXCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * hh_centerYCS;

@end
