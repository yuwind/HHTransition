//
//  UIView+HHLayout.m
//  https://github.com/yuwind/HHLayout
//
//  Created by 豫风 on 2017/12/7.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "UIView+HHLayout.h"
#import <objc/runtime.h>

static char * const topConstraintKey        = "topConstraintKey";
static char * const leftConstraintKey       = "leftConstraintKey";
static char * const bottomConstraintKey     = "bottomConstraintKey";
static char * const rightConstraintKey      = "rigthConstraintKey";
static char * const widthConstraintKey      = "widthConstraintKey";
static char * const heightConstraintKey     = "heightConstraintKey";
static char * const leadingConstraintKey    = "leadingConstraintKey";
static char * const trailingConstraintKey   = "trailingConstraintKey";
static char * const centerXConstraintKey    = "centerXConstraintKey";
static char * const centerYConstraintKey    = "centerYConstraintKey";
static char * const layoutArrayMKey         = "layoutArrayMKey";
static char * const equalToArrayMKey        = "equalToArrayMKey";
static char * const offsetArrayMKey         = "offsetArrayMKey";
static char * const relativeViewKey         = "relativeViewKey";
static char * const isWidthSelfKey          = "isWidthSelfKey";
static char * const isHeightSelfKey         = "isHeightSelfKey";

@interface UIView ()

@property (nonatomic, strong) NSLayoutConstraint *hh_topCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_leftCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_bottomCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_rightCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_widthCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_heightCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_leadingCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_trailingCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_centerXCS;
@property (nonatomic, strong) NSLayoutConstraint *hh_centerYCS;

@property (nonatomic, strong) NSMutableArray <NSNumber *>*layoutArrayM;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*equalToArrayM;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*offsetArrayM;
@property (nonatomic, strong) UIView *relativeView;
@property (nonatomic, assign) BOOL isWidthSelf;
@property (nonatomic, assign) BOOL isHeightSelf;

@end

static NSInteger relation_ = 0;

@implementation UIView (HHLayout)

- (void)setX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    self.frame = tempFrame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setMaxX:(CGFloat)maxX
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = maxX - self.width;
    self.frame = tempFrame;
}

- (CGFloat)maxX
{
    return self.x+self.width;
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = maxY - self.height;
    self.frame = tempFrame;
}
- (CGFloat)maxY
{
    return self.y+self.height;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint centerPoint = self.center;
    centerPoint.x = centerX;
    self.center = centerPoint;
}
-(CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint centerPoint = self.center;
    centerPoint.y = centerY;
    self.center = centerPoint;
}


- (void)setRelativeView:(UIView *)relativeView
{
    objc_setAssociatedObject(self, relativeViewKey, relativeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)relativeView
{
    return objc_getAssociatedObject(self, relativeViewKey);
}
- (void)setOffsetArrayM:(NSMutableArray<NSNumber *> *)offsetArrayM
{
    objc_setAssociatedObject(self, offsetArrayMKey, offsetArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<NSNumber *> *)offsetArrayM
{
    NSMutableArray *offsetArrayM = objc_getAssociatedObject(self, offsetArrayMKey);
    if (offsetArrayM) {
        return offsetArrayM;
    }
    offsetArrayM = [NSMutableArray array];
    self.offsetArrayM = offsetArrayM;
    return offsetArrayM;
}
- (void)setLayoutArrayM:(NSMutableArray<NSNumber *> *)layoutArrayM
{
    objc_setAssociatedObject(self, layoutArrayMKey, layoutArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<NSNumber *> *)layoutArrayM
{
    NSMutableArray *layoutArrayM = objc_getAssociatedObject(self, layoutArrayMKey);
    if (layoutArrayM) {
        return layoutArrayM;
    }
    layoutArrayM = [NSMutableArray array];
    self.layoutArrayM = layoutArrayM;
    return layoutArrayM;
}
- (void)setEqualToArrayM:(NSMutableArray<NSNumber *> *)equalToArrayM
{
    objc_setAssociatedObject(self, equalToArrayMKey, equalToArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<NSNumber *> *)equalToArrayM
{
    NSMutableArray *equalToArrayM = objc_getAssociatedObject(self, equalToArrayMKey);
    if (equalToArrayM) {
        return equalToArrayM;
    }
    equalToArrayM = [NSMutableArray array];
    self.equalToArrayM = equalToArrayM;
    return equalToArrayM;
}
- (void)setHh_topCS:(NSLayoutConstraint *)hh_topCS
{
    objc_setAssociatedObject(self, topConstraintKey, hh_topCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_topCS
{
    return objc_getAssociatedObject(self, topConstraintKey);
}
- (void)setHh_leftCS:(NSLayoutConstraint *)hh_leftCS
{
    objc_setAssociatedObject(self, leftConstraintKey, hh_leftCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_leftCS
{
    return objc_getAssociatedObject(self, leftConstraintKey);
}
- (void)setHh_bottomCS:(NSLayoutConstraint *)hh_bottomCS
{
    objc_setAssociatedObject(self, bottomConstraintKey, hh_bottomCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_bottomCS
{
    return objc_getAssociatedObject(self, bottomConstraintKey);
}
- (void)setHh_rightCS:(NSLayoutConstraint *)hh_rightCS
{
    objc_setAssociatedObject(self, rightConstraintKey, hh_rightCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_rightCS
{
    return objc_getAssociatedObject(self, rightConstraintKey);
}
- (void)setHh_widthCS:(NSLayoutConstraint *)hh_widthCS
{
    objc_setAssociatedObject(self, widthConstraintKey, hh_widthCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_widthCS
{
    return objc_getAssociatedObject(self, widthConstraintKey);
}
- (void)setHh_heightCS:(NSLayoutConstraint *)hh_heightCS
{
    objc_setAssociatedObject(self, heightConstraintKey, hh_heightCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_heightCS
{
    return objc_getAssociatedObject(self, heightConstraintKey);
}
- (void)setHh_leadingCS:(NSLayoutConstraint *)hh_leadingCS
{
    objc_setAssociatedObject(self, leadingConstraintKey, hh_leadingCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_leadingCS
{
    return objc_getAssociatedObject(self, leadingConstraintKey);
}
- (void)setHh_trailingCS:(NSLayoutConstraint *)hh_trailingCS
{
    objc_setAssociatedObject(self, trailingConstraintKey, hh_trailingCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_trailingCS
{
    return objc_getAssociatedObject(self, trailingConstraintKey);
}
- (void)setHh_centerXCS:(NSLayoutConstraint *)hh_centerXCS
{
    objc_setAssociatedObject(self, centerXConstraintKey, hh_centerXCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_centerXCS
{
    return objc_getAssociatedObject(self, centerXConstraintKey);
}
- (void)setHh_centerYCS:(NSLayoutConstraint *)hh_centerYCS
{
    objc_setAssociatedObject(self, centerYConstraintKey, hh_centerYCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)hh_centerYCS
{
    return objc_getAssociatedObject(self, centerYConstraintKey);
}

- (void)setIsWidthSelf:(BOOL)isWidthSelf
{
    objc_setAssociatedObject(self, isWidthSelfKey, @(isWidthSelfKey), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isWidthSelf
{
    return [objc_getAssociatedObject(self, isWidthSelfKey) boolValue];
}

- (void)setIsHeightSelf:(BOOL)isHeightSelf
{
    objc_setAssociatedObject(self, isHeightSelfKey, @(isHeightSelfKey), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isHeightSelf
{
    return [objc_getAssociatedObject(self, isHeightSelfKey) boolValue];
}

- (UIView *)top_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeTop)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeTop)];
    }
    return self;
}
- (UIView *)left_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeLeft)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeLeft)];
    }
    return self;
}
- (UIView *)bott_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeBottom)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeBottom)];
    }
    return self;
}
- (UIView *)righ_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeRight)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeRight)];
    }
    return self;
}
- (UIView *)widt_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeWidth)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeWidth)];
    }
    return self;
}
- (UIView *)heit_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeHeight)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeHeight)];
    }
    return self;
}
- (UIView *)lead_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeLeading)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeLeading)];
    }
    return self;
}
- (UIView *)trai_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeTrailing)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeTrailing)];
    }
    return self;
}
- (UIView *)cent_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterX)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterX)];
    }
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterY)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterY)];
    }
    return self;
}
- (UIView *)centX
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterX)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterX)];
    }
    return self;
}
- (UIView *)centY
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterY)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterY)];
    }
    return self;
}
- (UIView *)size_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeWidth)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeWidth)];
    }
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeHeight)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeHeight)];
    }
    return self;
}

- (UIView *(^)(CGFloat))rate_wh
{
    return ^UIView *(CGFloat rate_wh){
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:rate_wh constant:0];
        [self addConstraint:constraint];
        return self;
    };
}
- (UIView *(^)(CGFloat))rate_hw
{
    return ^UIView *(CGFloat rate_wh){
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:rate_wh constant:0];
        [self addConstraint:constraint];
        return self;
    };
}

- (UIView *(^)(ContentPriority))widPriority  //值越高，越不容易拉伸
{
    return ^UIView *(ContentPriority priority){
        switch (priority) {
            case ContentPriorityDefault:
                [self setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
                [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
                break;
            case ContentPriorityHigh:
                [self setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
                [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
                break;
            case ContentPriorityRequired:
                [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
                break;
            default:
                break;
        }
        return self;
    };
}

- (UIView *(^)(ContentPriority))higPriority  //值越高，越不容易拉伸
{
    return ^UIView *(ContentPriority priority){
        switch (priority) {
            case ContentPriorityDefault:
                [self setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
                [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
                break;
            case ContentPriorityHigh:
                [self setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
                [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
                break;
            case ContentPriorityRequired:
                [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
                [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
                break;
        }
        return self;
    };
}

- (UIView *(^)(UIView *))lessThan
{
    return ^UIView *(UIView *view){
        relation_ = -1;
        self.relativeView = view;
        return self;
    };
}
- (UIView *(^)(UIView *))equalTo
{
    return ^UIView *(UIView *view){
        self.relativeView = view;
        return self;
    };
}
- (UIView *(^)(UIView *))greatThan
{
    return ^UIView *(UIView *view){
        relation_ = 1;
        self.relativeView = view;
        return self;
    };
}

- (UIView *(^)(CGFloat))constant
{
    return ^UIView *(CGFloat equal){
        [self.equalToArrayM addObject:@(equal)];
        return self;
    };
}

- (UIView *(^)(NSNumber *, ...))constList
{
    return ^UIView *(NSNumber *first,...){
        va_list args;
        va_start(args, first);
        for (NSNumber *constant = first; constant!=nil&&[constant isKindOfClass:[NSNumber class]]; constant = va_arg(args, NSNumber *)) {
            [self.equalToArrayM addObject:constant];
        }
        va_end(args);
        return self;
    };
}

- (UIView *(^)(CGFloat))offset
{
    return ^UIView *(CGFloat offset){
        [self.offsetArrayM addObject:@(offset)];
        return self;
    };
}

- (UIView *(^)(CGRect))topLeft_
{
    return ^UIView *(CGRect rect){
        self.top_.left_.widt_.heit_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        on_();
        return self;
    };
}
- (UIView *(^)(CGRect))topRight_
{
    return ^UIView *(CGRect rect){
        self.top_.righ_.widt_.heit_.
        constant(rect.origin.y).constant(-rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        on_();
        return self;
    };
}

- (UIView *(^)(CGRect))bottomLeft_
{
    return ^UIView *(CGRect rect){
        self.bott_.left_.widt_.heit_.
        constant(-rect.origin.y).constant(rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        on_();
        return self;
    };
}
- (UIView *(^)(CGRect))bottomRight_
{
    return ^UIView *(CGRect rect){
        self.bott_.righ_.widt_.heit_.
        constant(-rect.origin.y).constant(-rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        on_();
        return self;
    };
}
- (UIView *(^)(CGRect))heightTop_
{
    return ^UIView *(CGRect rect){
        self.top_.left_.heit_.righ_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(rect.size.height).constant(-rect.size.width).
        on_();
        return self;
    };
}
- (UIView *(^)(CGRect))heightBottom_
{
    return ^UIView *(CGRect rect){
        self.bott_.left_.heit_.righ_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(rect.size.height).constant(-rect.size.width).
        on_();
        return self;
    };
}
- (UIView *(^)(CGRect))insetFrame_
{
    return ^UIView *(CGRect rect){
        self.top_.left_.bott_.righ_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(-rect.size.width).constant(-rect.size.height).
        on_();
        return self;
    };
}
- (UIView *(^)(void))around_
{
    return ^UIView *(){
        self.left_.top_.bott_.righ_.equalTo(self.superview).on_();
        return self;
    };
}

- (UIView *(^)(void))removeAll
{
    return ^UIView *(){
        [self removeAllConstraint_];
        return self;
    };
}

- (void)removeAllConstraint_
{
    if (self.hh_widthCS) {
        if (self.isWidthSelf) {
            [self removeConstraint:self.hh_widthCS];
        }else{
            [self.superview removeConstraint:self.hh_widthCS];
        }
        self.hh_widthCS = nil;
    }
    if (self.hh_heightCS) {
        if (self.isHeightSelf) {
            [self removeConstraint:self.hh_heightCS];
        }else{
            [self.superview removeConstraint:self.hh_heightCS];
        }
        self.hh_heightCS = nil;
    }
    
    if (self.hh_topCS) {
        [self.superview removeConstraint:self.hh_topCS];
        self.hh_topCS = nil;
    }
    if (self.hh_leftCS) {
        [self.superview removeConstraint:self.hh_leftCS];
        self.hh_leftCS = nil;
    }
    if (self.hh_bottomCS) {
        [self.superview removeConstraint:self.hh_bottomCS];
        self.hh_bottomCS = nil;
    }
    if (self.hh_rightCS) {
        [self.superview removeConstraint:self.hh_rightCS];
        self.hh_rightCS = nil;
    }
    if (self.hh_leadingCS) {
        [self.superview removeConstraint:self.hh_leadingCS];
        self.hh_leadingCS = nil;
    }
    if (self.hh_trailingCS) {
        [self.superview removeConstraint:self.hh_trailingCS];
        self.hh_trailingCS = nil;
    }
    if (self.hh_centerXCS) {
        [self.superview removeConstraint:self.hh_centerXCS];
        self.hh_centerXCS = nil;
    }
    if (self.hh_centerYCS) {
        [self.superview removeConstraint:self.hh_centerYCS];
        self.hh_centerYCS = nil;
    }
}

- (UIView *(^)(void))on_
{
    return ^UIView *(){
        [self installAllConstraint];
        [self resetLayoutInitialInfo];
        return self;
    };
}

- (void)resetLayoutInitialInfo
{
    relation_ = 0;
    [self.equalToArrayM removeAllObjects];
    [self.offsetArrayM removeAllObjects];
    [self.layoutArrayM removeAllObjects];
    if (self.relativeView) {
        [self.relativeView.equalToArrayM removeAllObjects];
        [self.relativeView.offsetArrayM removeAllObjects];
        [self.relativeView.layoutArrayM removeAllObjects];
        self.relativeView.layoutArrayM = nil;
        self.relativeView.offsetArrayM = nil;
        self.relativeView.equalToArrayM = nil;
        self.relativeView = nil;
    }
}

- (void)installAllConstraint
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.relativeView) {
        int index = -1;
        for (int i = 0; i<self.layoutArrayM.count; i++) {
            NSInteger relative = self.relativeView.layoutArrayM.count>i?self.relativeView.layoutArrayM[i].integerValue:self.layoutArrayM[i].integerValue;
            CGFloat constant = self.offsetArrayM.count>i?[self countConstant:i index:&index]:index==-1?self.equalToArrayM.count>i?self.equalToArrayM[i].floatValue:0.0f:self.equalToArrayM.count>=i-index?self.equalToArrayM[i-index-1].floatValue:0.0f;
            [self readyDeploy:self.layoutArrayM[i].integerValue relative:relative view:self.relativeView equalTo:constant];
        }
    }else if (self.layoutArrayM.count) {
        for (int i = 0; i<self.layoutArrayM.count; i++) {
            CGFloat constant = self.equalToArrayM.count>i?self.equalToArrayM[i].floatValue:self.equalToArrayM.lastObject.floatValue;
            [self readyDeploy:self.layoutArrayM[i].integerValue relative:self.layoutArrayM[i].integerValue view:nil equalTo:constant];
        }
    }
}
- (CGFloat)countConstant:(int)i index:(int *)index
{
    *index = i;
    return self.offsetArrayM[i].floatValue;
}

- (void)readyDeploy:(NSInteger)source relative:(NSInteger)relative view:(UIView *)view equalTo:(CGFloat)constant
{
    switch (source) {
        case NSLayoutAttributeLeft:
        {
            if(self.hh_leftCS){[self.superview removeConstraint:self.hh_leftCS];}
            self.hh_leftCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_leftCS];
        }
            break;
        case NSLayoutAttributeRight:
        {
            if(self.hh_rightCS){[self.superview removeConstraint:self.hh_rightCS];}
            self.hh_rightCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_rightCS];
        }
            break;
        case NSLayoutAttributeTop:
        {
            if(self.hh_topCS){[self.superview removeConstraint:self.hh_topCS];}
            self.hh_topCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_topCS];
        }
            break;
        case NSLayoutAttributeBottom:
        {
            if(self.hh_bottomCS){[self.superview removeConstraint:self.hh_bottomCS];}
            self.hh_bottomCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_bottomCS];
        }
            break;
        case NSLayoutAttributeLeading:
        {
            if(self.hh_leadingCS){[self.superview removeConstraint:self.hh_leadingCS];}
            self.hh_leadingCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_leadingCS];
        }
            break;
        case NSLayoutAttributeTrailing:
        {
            if(self.hh_trailingCS){[self.superview removeConstraint:self.hh_trailingCS];}
            self.hh_trailingCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_trailingCS];
        }
            break;
        case NSLayoutAttributeWidth:
        {
            if(self.hh_widthCS){
                if (self.equalToArrayM.count && constant) {
                    self.isWidthSelf = YES;
                }else if (view){
                    self.isWidthSelf = NO;
                }else{
                    self.isWidthSelf = YES;
                } [self.equalToArrayM.count&&constant?self:view?self.superview:self removeConstraint:self.hh_widthCS];}
            self.hh_widthCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:relation_ toItem:self.equalToArrayM.count&&constant?nil:view?:nil attribute:relative multiplier:1.0 constant:constant];
            [self.equalToArrayM.count&&constant?self:view?self.superview:self addConstraint:self.hh_widthCS];
        }
            break;
        case NSLayoutAttributeHeight:
        {
            if(self.hh_heightCS){
                if (self.equalToArrayM.count && constant) {
                    self.isHeightSelf = YES;
                }else if (view){
                    self.isHeightSelf = NO;
                }else{
                    self.isHeightSelf = YES;
                }
                [self.equalToArrayM.count&&constant?self:view?self.superview:self removeConstraint:self.hh_heightCS];}
            self.hh_heightCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:relation_ toItem:self.equalToArrayM.count&&constant?nil:view?:nil attribute:relative multiplier:1.0 constant:constant];
            [self.equalToArrayM.count&&constant?self:view?self.superview:self addConstraint:self.hh_heightCS];
        }
            break;
        case NSLayoutAttributeCenterX:
        {
            if(self.hh_centerXCS){[self.superview removeConstraint:self.hh_centerXCS];}
            self.hh_centerXCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_centerXCS];
        }
            break;
        case NSLayoutAttributeCenterY:
        {
            if(self.hh_centerYCS){[self.superview removeConstraint:self.hh_centerYCS];}
            self.hh_centerYCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:relation_ toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.hh_centerYCS];
        }
            break;
            
        default:
            break;
    }
}

@end
