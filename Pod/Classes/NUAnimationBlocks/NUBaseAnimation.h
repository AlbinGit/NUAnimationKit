//
//  NUBaseAnimation.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUAnimationOptions.h"
#import <UIKit/UIKit.h>

//Block definitions
typedef void (^NUSimpleAnimationBlock)(void);
typedef void (^NUProgressAnimationBlock)(CGFloat progress);

typedef void (^NUNoArgumentsBlock)(void);

//Types
typedef NS_ENUM(NSInteger, NUAnimationType) {
    NUAnimationTypeDefault,
    NUAnimationTypeSpringy,
};

//Base class
@interface NUBaseAnimation : NSObject

@property (nonatomic) NUAnimationType type;
@property NUAnimationOptions *options;
@property NSTimeInterval delay;
@property (nonatomic, copy) NUSimpleAnimationBlock animationBlock;
@property (nonatomic, copy) NUNoArgumentsBlock completionBlock;
@property (nonatomic, copy) NUNoArgumentsBlock initializationBlock;

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations;

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                 andInitializationBlock: (NUNoArgumentsBlock)initializationBlock
                     andCompletionBlock: (NUNoArgumentsBlock)completionBlock;

///Block invoked when the controller is about to start the animation
- (void)animationWillBegin;

///Block invoked when the animation is finished
- (void)animationDidFinish;

@end
