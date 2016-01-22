//
//  NUAnimationController.m
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//


#define weakify(var) __weak typeof(var) AHKWeak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")

#import "NUAnimationController.h"
#import <QuartzCore/QuartzCore.h>

@interface NUAnimationController ()

@property (nonatomic, copy) void (^completionBlock)();
@property (nonatomic, strong) NSMutableArray *animationBlocks;
@property (nonatomic, readwrite) BOOL animationRunning;

@end

@implementation NUAnimationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animationBlocks = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (NUBaseAnimationBlock *)addAnimationBlock:(NUBaseAnimationBlock *)block {
    [self.animationBlocks addObject:block];
    return block;
}

- (void)startAnimationChainWithCompletionBlock:(void (^)())completionBlock {
    if (self.animationRunning) {
        //Animation cannot be started multiple times.
        return;
    }
    
    self.completionBlock = completionBlock;
    [self startNextAnimation];
}

- (void)startAnimationChain {
    [self startAnimationChainWithCompletionBlock:nil];
}

///Adds an animation block to the chain.
- (NUCompositeAnimationBlock *)addAnimation: (NUSimpleAnimationBlock)animation {
    NUCompositeAnimationBlock *result = [[NUCompositeAnimationBlock alloc] init];
    result.animationBlock = animation;
    [self addAnimationBlock:result];
    return result;
}

#pragma mark - Private

- (void)startNextAnimation {
    if (self.animationBlocks.count == 0) {
        self.completionBlock();
        [self cleanUp];
        return;
    }
    
    NUBaseAnimationBlock *block = [self.animationBlocks firstObject];
    if (block.type == NUAnimationTypeDefault) {
        [UIView animateWithDuration:block.options.duration
                              delay:block.delay
                            options:block.options.options
                         animations:^{
                             [block animationWillBegin];
                             block.animationBlock();
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 if (block.completionBlock) {
                                     block.completionBlock();
                                 }
                                 
                                 [self.animationBlocks removeObjectAtIndex:0];
                                 [self startNextAnimation];
                             }
                         }];
    } else if (block.type == NUAnimationTypeSpringy) {
        NUSpringAnimationOptions *springOptions = (NUSpringAnimationOptions *)block.options;
        [UIView animateWithDuration:block.options.duration
                              delay:block.delay
             usingSpringWithDamping:springOptions.damping
              initialSpringVelocity:springOptions.initialVelocity
                            options:block.options.options
                         animations:^{
                             [block animationWillBegin];
                             block.animationBlock();
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 if (block.completionBlock) {
                                     block.completionBlock();
                                 }
                                 
                                 [self.animationBlocks removeObjectAtIndex:0];
                                 [self startNextAnimation];
                             }
                         }];
    }
    
}

- (void)cleanUp {
    self.animationRunning = false;
}

@end
