//
//  NUCompositeAnimation.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUBaseAnimation.h"

@interface NUCompositeAnimation : NUBaseAnimation

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                     andCompletionBlock: (NUCompletionBlock)completionBlock
                         inParallelWith: (NUBaseAnimation *)parallelBlock
                       animateAlongside: (NUProgressAnimationBlock)progressBlock;

@property (nonatomic, strong) NUBaseAnimation *parallelBlock;

- (NUCompositeAnimation * (^)(NUAnimationType))withType;
- (NUCompositeAnimation * (^)(NSTimeInterval))withDelay;

//Completion
- (NUCompositeAnimation * (^)(NUCompletionBlock))andThen;

//Options
- (NUCompositeAnimation * (^)(UIViewAnimationCurve))withCurve;
- (NUCompositeAnimation * (^)(UIViewAnimationOptions))withAnimationOption;
- (NUCompositeAnimation * (^)(NSTimeInterval))withDuration;
- (NUCompositeAnimation * (^)(NUAnimationOptions *))withOptions;

//  Springy options
- (NUCompositeAnimation * (^)(CGFloat))withDamping;
- (NUCompositeAnimation * (^)(CGFloat))withInitialVelocity;

//Progress
- (NUCompositeAnimation * (^)(NUProgressAnimationBlock))alongSideBlock;

//Parallel
- (NUCompositeAnimation * (^)(NUSimpleAnimationBlock))inParallelWith;

@end
