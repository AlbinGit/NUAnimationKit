//
//  NUCompositeAnimationBlock.m
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUCompositeAnimationBlock.h"

@interface NUCompositeAnimationBlock ()

@property (nonatomic, strong) NUProgressAnimationBlock progressBlock;

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, readwrite) CFTimeInterval lastTimestamp;

@property (nonatomic, readwrite) CGFloat progress;
@property (nonatomic, readwrite) CGFloat totalAnimationDuration;

@end

@implementation NUCompositeAnimationBlock

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                     andCompletionBlock: (NUCompletionBlock)completionBlock
                         inParallelWith:(NUBaseAnimationBlock *)parallelBlock
                       animateAlongside: (NUProgressAnimationBlock)progressBlock {
    
    NUCompositeAnimationBlock *result = [[NUCompositeAnimationBlock alloc] init];
    if (result) {
        result.type = type;
        result.options = options;
        result.delay = delay;
        result.animationBlock = animations;
        result.completionBlock = completionBlock;
        result.parallelBlock = parallelBlock;
        result.progressBlock = progressBlock;
    }
    return result;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(updateAnimationProgress)];
        self.completionBlock = nil;
    }
    return self;
}

#pragma mark - Extension methods

- (void)animationWillBegin {
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop]
                           forMode:NSDefaultRunLoopMode];
}

- (void)setCompletionBlock:(NUCompletionBlock)completionBlock {
    __weak typeof(self) weakself = self;
    super.completionBlock = ^() {
        __strong typeof(self) self = weakself;
        [self cleanUp];
        
        if (completionBlock) {
            completionBlock();
        }
    };
}

#pragma mark - Convenience methods

- (NUCompositeAnimationBlock * (^)(NUProgressAnimationBlock))alongSideBlock {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NUProgressAnimationBlock block) {
        __strong typeof(self) self = weakself;
        self.progressBlock = block;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NUAnimationType))withType {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NUAnimationType type) {
        __strong typeof(self) self = weakself;
        self.type = type;
        if (type == NUAnimationTypeSpringy) {
            self.options = [[NUSpringAnimationOptions alloc] init];
        }
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NSTimeInterval))withDelay {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NSTimeInterval delay) {
        __strong typeof(self) self = weakself;
        self.delay = delay;
        return self;
    };
}
- (NUCompositeAnimationBlock * (^)(NUCompletionBlock))andThen {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NUCompletionBlock completion) {
        __strong typeof(self) self = weakself;
        self.completionBlock = completion;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(UIViewAnimationCurve))withCurve {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(UIViewAnimationCurve curve) {
        __strong typeof(self) self = weakself;
        self.options.curve = curve;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(UIViewAnimationOptions))withAnimationOption {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(UIViewAnimationOptions options) {
        __strong typeof(self) self = weakself;
        self.options.options = options;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NSTimeInterval))withDuration {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NSTimeInterval duration) {
        __strong typeof(self) self = weakself;
        self.options.duration = duration;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NUAnimationOptions *))withOptions {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NUAnimationOptions *options) {
        __strong typeof(self) self = weakself;
        self.options = options;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(CGFloat))withInitialVelocity {
    __weak typeof(self) weakself = self;
    NSAssert(self.type == NUAnimationTypeSpringy, @"This can only be set in springy animations.");
    return ^NUCompositeAnimationBlock*(CGFloat velocity) {
        __strong typeof(self) self = weakself;
        ((NUSpringAnimationOptions *)self.options).initialVelocity = velocity;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(CGFloat))withDamping {
    __weak typeof(self) weakself = self;
    NSAssert(self.type == NUAnimationTypeSpringy, @"This can only be set in springy animations.");
    return ^NUCompositeAnimationBlock*(CGFloat damping) {
        __strong typeof(self) self = weakself;
        ((NUSpringAnimationOptions *)self.options).damping = damping;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NUSimpleAnimationBlock))inParallelWith {
    __weak typeof(self) weakself = self;
    return ^NUCompositeAnimationBlock*(NUSimpleAnimationBlock block) {
        __strong typeof(self) self = weakself;
        NUCompositeAnimationBlock *result = [[NUCompositeAnimationBlock alloc] init];
        result.animationBlock = block;
        self.parallelBlock = result;
        return result;
    };
}

#pragma mark - Private methods

- (void)cleanUp {
    [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.progress = 1;
}

- (void)updateAnimationProgress {
    if (self.lastTimestamp == 0) {
        self.lastTimestamp = self.displayLink.timestamp;
        self.progress = 0;
        return;
    }
    
    self.progress += (self.displayLink.timestamp - self.lastTimestamp) / self.options.duration;
    self.lastTimestamp = self.displayLink.timestamp;
}

- (void)setProgress:(CGFloat)progress {
    _progress = MIN(progress, 1.0f);
    if (self.progressBlock) {
        self.progressBlock(_progress);
    }
}

@end