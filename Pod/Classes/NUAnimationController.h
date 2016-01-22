//
//  NUAnimationController.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUCompositeAnimationBlock.h"

@interface NUAnimationController : NSObject

- (NUBaseAnimationBlock *)addAnimationBlock:(NUBaseAnimationBlock *)block;

- (void)startAnimationChainWithCompletionBlock:(void (^)())completionBlock;
- (void)startAnimationChain;

//Convenience methods
- (NUCompositeAnimationBlock *)addAnimation: (NUSimpleAnimationBlock)animations;

@end
