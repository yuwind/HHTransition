//
//  HHPresentAnimatorFlipTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHBaseAnimatedTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHPresentAnimatorFlipTransition : HHBaseAnimatedTransition

+ (instancetype)flipTransitionWithStyle:(HHPresentStyle)style isBegining:(BOOL)isBegining;

@end

NS_ASSUME_NONNULL_END
