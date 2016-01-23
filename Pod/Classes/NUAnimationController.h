//
//  NUAnimationController.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUCompositeAnimationBlock.h"
#import "UIView+NUAnimationAdditions.h"

@interface NUAnimationController : NSObject

@property (nonatomic, readonly) BOOL animationCancelled;

- (NUBaseAnimationBlock *)addAnimationBlock:(NUBaseAnimationBlock *)block;
- (void)removeAnimation: (NUBaseAnimationBlock *)animation;
- (void)removeAllAnimations;

- (NSArray *)animations;


- (void)startAnimationChainWithCompletionBlock:(void (^)())completionBlock;
- (void)startAnimationChain;

//Convenience methods
- (NUCompositeAnimationBlock *)addAnimation: (NUSimpleAnimationBlock)animations;

- (void)cancelAnimations;

@end
