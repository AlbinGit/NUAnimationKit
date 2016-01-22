//
//  NUCompositeAnimationBlock.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUBaseAnimationBlock.h"

@interface NUCompositeAnimationBlock : NUBaseAnimationBlock

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                     andCompletionBlock: (NUCompletionBlock)completionBlock
                       animateAlongside: (NUProgressAnimationBlock)progressBlock;


- (NUCompositeAnimationBlock * (^)(NUAnimationType))withType;
- (NUCompositeAnimationBlock * (^)(NSTimeInterval))withDelay;


//Completion
- (NUCompositeAnimationBlock * (^)(NUCompletionBlock))andThen;

//Options
- (NUCompositeAnimationBlock * (^)(UIViewAnimationCurve))withCurve;
- (NUCompositeAnimationBlock * (^)(UIViewAnimationOptions))withAnimationOption;
- (NUCompositeAnimationBlock * (^)(NSTimeInterval))withDuration;
- (NUCompositeAnimationBlock * (^)(NUAnimationOptions *))withOptions;

//Progress
- (NUCompositeAnimationBlock * (^)(NUProgressAnimationBlock))alongSideBlock;

@end
