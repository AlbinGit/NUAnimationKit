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
                       animateAlongside: (NUProgressAnimationBlock)progressBlock {
    
    NUCompositeAnimationBlock *result = [[NUCompositeAnimationBlock alloc] init];
    if (result) {
        result.type = type;
        result.options = options;
        result.delay = delay;
        result.animationBlock = animations;
        result.completionBlock = completionBlock;
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
    super.completionBlock = ^() {
        [self cleanUp];
        
        if (completionBlock) {
            completionBlock();
        }
    };
}

- (NUCompositeAnimationBlock * (^)(NUProgressAnimationBlock))alongSideBlock {
    return ^NUCompositeAnimationBlock*(NUProgressAnimationBlock block) {
        self.progressBlock = block;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NUAnimationType))withType {
    return ^NUCompositeAnimationBlock*(NUAnimationType type) {
        self.type = type;
        if (type == NUAnimationTypeSpringy) {
            self.options = [[NUSpringAnimationOptions alloc] init];
        }
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NSTimeInterval))withDelay {
    return ^NUCompositeAnimationBlock*(NSTimeInterval delay) {
        self.delay = delay;
        return self;
    };
}
- (NUCompositeAnimationBlock * (^)(NUCompletionBlock))andThen {
    return ^NUCompositeAnimationBlock*(NUCompletionBlock completion) {
        self.completionBlock = completion;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(UIViewAnimationCurve))withCurve {
    return ^NUCompositeAnimationBlock*(UIViewAnimationCurve curve) {
        self.options.curve = curve;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(UIViewAnimationOptions))withAnimationOption {
    return ^NUCompositeAnimationBlock*(UIViewAnimationOptions options) {
        self.options.options = options;
        return self;
    };
}

- (NUCompositeAnimationBlock * (^)(NSTimeInterval))withDuration {
    return ^NUCompositeAnimationBlock*(NSTimeInterval duration) {
        self.options.duration = duration;
        return self;
    };
}
- (NUCompositeAnimationBlock * (^)(NUAnimationOptions *))withOptions {
    return ^NUCompositeAnimationBlock*(NUAnimationOptions *options) {
        self.options = options;
        return self;
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