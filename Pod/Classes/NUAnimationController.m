//
//  NUAnimationController.m
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUAnimationController.h"
#import <QuartzCore/QuartzCore.h>

@interface NUAnimationController ()

@property (nonatomic, copy) void (^completionBlock)();
@property (nonatomic, strong) NSMutableArray *animationBlocks;
@property (nonatomic, readwrite) NSTimeInterval totalAnimationTime;
@property (nonatomic, readwrite) int animationStep;
@property (nonatomic, readwrite) BOOL animationRunning;
@property (nonatomic, readwrite) BOOL animationCancelled;

@end

@implementation NUAnimationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animationBlocks = [[NSMutableArray alloc] init];
        _totalAnimationTime = 0;
    }
    return self;
}

#pragma mark - Public methods

- (NUBaseAnimation *)addAnimation:(NUBaseAnimation *)block {
    [self.animationBlocks addObject:block];
    self.totalAnimationTime += block.options.duration;
    return block;
}

- (void)startAnimationChainWithCompletionBlock:(NUNoArgumentsBlock)completionBlock {
    self.animationCancelled = false;
    self.animationStep = 0;
    if (self.animationRunning) {
        //Animation cannot be started multiple times.
        return;
    }
    
    self.animationRunning = true;
    
    self.completionBlock = completionBlock;
    [self startNextAnimation];
}

- (void)startAnimationChain {
    [self startAnimationChainWithCompletionBlock:nil];
}

- (NUCompositeAnimation *)addAnimations: (NUSimpleAnimationBlock)animation {
    NUCompositeAnimation *result = [[NUCompositeAnimation alloc] init];
    result.animationBlock = animation;
    [self addAnimation:result];
    return result;
}

- (void)cancelAnimations {
    self.animationCancelled = true;
}

- (void)removeAnimation: (NUBaseAnimation *)animation {
    [self.animationBlocks removeObject:animation];
}

- (void)removeAllAnimations {
    self.animationBlocks = [[NSMutableArray alloc] init];
}

- (NSArray *)animations {
    return [self.animationBlocks copy];
}

#pragma mark - Private

- (void)startNextAnimation {
    if (self.animationBlocks.count == self.animationStep) {
        [self finishAnimations];
        return;
    }
    
    NUBaseAnimation *block = self.animationBlocks[self.animationStep];
    [self startBlock:block isParallel:false];
    
}

- (void)startBlock:(NUBaseAnimation *)block isParallel: (BOOL)isParallel {
    __weak typeof(self) weakself = self;
    if ([block isKindOfClass:[NUCompositeAnimation class]]) {
        NUCompositeAnimation *composite = (NUCompositeAnimation *)block;
        if (composite.parallelBlock) {
            [self startBlock:composite.parallelBlock isParallel:true];
        }
    }
    
    [block animationWillBegin];
    if (block.type == NUAnimationTypeDefault) {
        [UIView animateWithDuration:block.options.duration
                              delay:block.delay
                            options:block.options.options
                         animations:^{
                             if (block.animationBlock) {
                                 block.animationBlock();
                             }
                         }
                         completion:^(BOOL finished) {
                             __strong typeof(self) self = weakself;
                             if (finished) {
                                 [block animationDidFinish];
                                 
                                 if (self.animationCancelled) {
                                     [self finishAnimations];
                                 } else if (!isParallel) {
                                     self.animationStep++;
                                     [self startNextAnimation];
                                 }
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
                             if (block.animationBlock) {
                                 block.animationBlock();
                             }
                         }
                         completion:^(BOOL finished) {
                             __strong typeof(self) self = weakself;
                             if (finished) {
                                 [block animationDidFinish];
                                 
                                 if (self.animationCancelled) {
                                     [self finishAnimations];
                                 } else if (!isParallel) {
                                     self.animationStep++;
                                     [self startNextAnimation];
                                 }
                             }
                         }];
    }
}

- (void)finishAnimations {
    if (self.completionBlock) {
        self.completionBlock();
    }
    self.animationRunning = false;
}

@end
