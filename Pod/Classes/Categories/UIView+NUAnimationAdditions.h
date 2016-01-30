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

///Sets the origin x of a view's frame.
- (void)setFrameX: (CGFloat)x;

///Sets the origin y of a view's frame.
- (void)setFrameY: (CGFloat)y;

///Sets the width of a view's frame.
- (void)setFrameWidth: (CGFloat)w;

///Sets the height of a view's frame.
- (void)setFrameHeight: (CGFloat)h;

//Layer settings
///Sets the origin x of a view's layer.
- (void)setLayerX: (CGFloat)x;

///Sets the origin y of a view's layer.
- (void)setLayerY: (CGFloat)y;

///Sets the width of a view's layer.
- (void)setLayerWidth: (CGFloat)w;

///Sets the height of a view's layer.
- (void)setLayerHeight: (CGFloat)h;

@end
