//
//  NUAnimationController.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUCompositeAnimationBlock.h"

#define frameSetY(f,y)          f = CGRectMake(f.origin.x, y, f.size.width, f.size.height)
#define frameSetX(f,x)          f = CGRectMake(x, f.origin.y, f.size.width, f.size.height)

#define frameSetWidth(f,w)      f = CGRectMake(f.origin.x, f.origin.y, w, f.size.height)
#define frameSetHeight(f,h)     f = CGRectMake(f.origin.x, f.origin.y, f.size.width, h)

@interface NUAnimationController : NSObject

@property (nonatomic, readonly) BOOL animationCancelled;

- (NUBaseAnimationBlock *)addAnimationBlock:(NUBaseAnimationBlock *)block;

- (void)startAnimationChainWithCompletionBlock:(void (^)())completionBlock;
- (void)startAnimationChain;

//Convenience methods
- (NUCompositeAnimationBlock *)addAnimation: (NUSimpleAnimationBlock)animations;

- (void)cancelAnimations;

@end
