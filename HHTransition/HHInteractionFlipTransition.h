//
//  HHInteractionFlipTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHBaseAnimatedTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHInteractionFlipTransition : HHBaseAnimatedTransition

+ (instancetype)flipTransitionWithStyle:(HHPushStyle)style isBegining:(BOOL)isBegining;

@end

NS_ASSUME_NONNULL_END
