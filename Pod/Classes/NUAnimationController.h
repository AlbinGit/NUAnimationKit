//
//  NUAnimationController.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUCompositeAnimation.h"
#import "UIView+NUAnimationAdditions.h"

@interface NUAnimationController : NSObject

@property (nonatomic, readonly) BOOL animationCancelled;

- (NUBaseAnimation *)addAnimationBlock:(NUBaseAnimation *)block;
- (void)removeAnimation: (NUBaseAnimation *)animation;
- (void)removeAllAnimations;

- (NSArray *)animations;


- (void)startAnimationChainWithCompletionBlock:(void (^)())completionBlock;
- (void)startAnimationChain;

//Convenience methods
- (NUCompositeAnimation *)addAnimation: (NUSimpleAnimationBlock)animations;

- (void)cancelAnimations;

@end
