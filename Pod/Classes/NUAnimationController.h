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

///Readonly boolean that reports whether animations have been canceled. It's value is reset to zero every time the animation begins.
@property (nonatomic, readonly) BOOL animationCancelled;
///Readonly integer that reports the current animation step
@property (nonatomic, readonly) int animationStep;
///Readonly boolean that reports whether animations are running
@property (nonatomic, readonly) BOOL animationRunning;


///Add an animation to the chain
- (NUBaseAnimation *)addAnimation:(NUBaseAnimation *)animation;
///Remove an animation from the chain
- (void)removeAnimation: (NUBaseAnimation *)animation;
///Clear the nimation chain
- (void)removeAllAnimations;

///Gets all animation steps
- (NSArray *)animations;

///Starts the animation and calls @c completionBlock when done.
- (void)startAnimationChainWithCompletionBlock:(NUNoArgumentsBlock)completionBlock;
- (void)startAnimationChain;

//Convenience methods

///Adds an animation block to the chain
- (NUCompositeAnimation *)addAnimations: (NUSimpleAnimationBlock)animations;

///Finishes the current animation step and stops the animation chain
- (void)cancelAnimations;

@end
