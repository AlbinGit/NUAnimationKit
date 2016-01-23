//
//  UIView+NUAnimationAdditions.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//
//

#import <UIKit/UIKit.h>

@interface UIView (NUAnimationAdditions)

//Frame settings
- (void)setFrameX: (CGFloat)x;
- (void)setFrameY: (CGFloat)y;

- (void)setFrameWidth: (CGFloat)w;
- (void)setFrameHeight: (CGFloat)h;

//Layer settings
- (void)setLayerX: (CGFloat)x;
- (void)setLayerY: (CGFloat)y;

- (void)setLayerWidth: (CGFloat)w;
- (void)setLayerHeight: (CGFloat)h;

@end
