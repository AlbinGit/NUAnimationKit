//
//  NUBaseAnimationBlock.h
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

typedef void (^NUCompletionBlock)(void);

//Types
typedef NS_ENUM(NSInteger, NUAnimationType) {
    NUAnimationTypeDefault,
    NUAnimationTypeSpringy,
};

//Base class
@interface NUBaseAnimationBlock : NSObject

@property (nonatomic, readwrite) NUAnimationType type;
@property (nonatomic, readwrite) NUAnimationOptions *options;
@property (nonatomic, readwrite) NSTimeInterval delay;
@property (nonatomic, copy) NUSimpleAnimationBlock animationBlock;
@property (nonatomic, copy) NUCompletionBlock completionBlock;

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations;

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                     andCompletionBlock: (NUCompletionBlock)completionBlock;

///Block invoked when the controller is about to start the animation
- (void)animationWillBegin;

@end
