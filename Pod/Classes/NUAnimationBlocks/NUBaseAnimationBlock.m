//
//  NUBaseAnimationBlock.m
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUBaseAnimationBlock.h"

@implementation NUBaseAnimationBlock

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.options = [[NUAnimationOptions alloc] init];
        self.type = NUAnimationTypeDefault;
    }
    return self;
}

- (instancetype)initWithType: (NUAnimationType)type
                  andOptions: (NUAnimationOptions *)options
                    andDelay: (NSTimeInterval)delay
               andAnimations: (NUSimpleAnimationBlock)animations
          andCompletionBlock: (NUCompletionBlock)completionBlock{
    NSParameterAssert(animations);
    NSParameterAssert(options);
    self = [super init];
    if (self) {
        _type = type;
        _options = options;
        _delay = delay;
        _animationBlock = animations;
        _completionBlock = completionBlock;
    }
    return self;
}

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations {
    return [self animationBlockWithType:type
                             andOptions:options
                               andDelay:delay
                          andAnimations:animations
                     andCompletionBlock:nil];
}

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                     andCompletionBlock: (NUCompletionBlock)completionBlock {
    
    NUBaseAnimationBlock *block = [[NUBaseAnimationBlock alloc]initWithType:type
                                                                 andOptions:options
                                                                   andDelay:delay
                                                              andAnimations:animations
                                                         andCompletionBlock:completionBlock];
    return block;
}


- (void)animationWillBegin {
    
}

//Convenience methods
- (NUBaseAnimationBlock * (^)(NUAnimationType))withType {
    return ^NUBaseAnimationBlock*(NUAnimationType type) {
        self.type = type;
        if (type == NUAnimationTypeSpringy) {
            self.options = [[NUSpringAnimationOptions alloc] init];
        }
        return self;
    };
}

- (NUBaseAnimationBlock * (^)(UIViewAnimationOptions))withAnimationOption {
    return ^NUBaseAnimationBlock*(UIViewAnimationOptions option) {
        self.options.options = option;
        return self;
    };
}

- (NUBaseAnimationBlock * (^)(UIViewAnimationCurve))withCurve {
    return ^NUBaseAnimationBlock*(UIViewAnimationCurve curve) {
        self.options.curve = curve;
        return self;
    };
}

- (NUBaseAnimationBlock * (^)(NSTimeInterval))withDuration {
    return ^NUBaseAnimationBlock*(NSTimeInterval duration) {
        self.options.duration = duration;
        return self;
    };
}

- (NUBaseAnimationBlock * (^)(NUAnimationOptions *))withOptions {
    return ^NUBaseAnimationBlock*(NUAnimationOptions *options) {
        self.options = options;
        return self;
    };
}

- (NUBaseAnimationBlock * (^)(NSTimeInterval))withDelay {
    return ^NUBaseAnimationBlock*(NSTimeInterval delay) {
        self.delay = delay;
        return self;
    };
}

- (NUBaseAnimationBlock * (^)(NUCompletionBlock))andThen {
    return ^NUBaseAnimationBlock*(NUCompletionBlock completion) {
        self.completionBlock = completion;
        return self;
    };
}

@end
