//
//  NUAnimationOptions.h
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NUAnimationOptions : NSObject
{
@protected
    NSTimeInterval _duration;
}

@property (nonatomic, readwrite) NSTimeInterval duration;
@property (nonatomic, readwrite) UIViewAnimationOptions options;
@property (nonatomic, readwrite) UIViewAnimationCurve curve;

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve;

@end

@interface NUSpringAnimationOptions : NUAnimationOptions

extern NSTimeInterval NUSpringAnimationNaturalDuration;

@property (nonatomic, readwrite) CGFloat damping;
@property (nonatomic, readwrite) CGFloat initialVelocity;

+ (instancetype) animationWithDuration:(NSTimeInterval)duration
                            andOptions:(UIViewAnimationOptions)options
                              andCurve:(UIViewAnimationCurve)curve
                            andDamping:(CGFloat)damping
                    andInitialVelocity: (CGFloat)initialVelocity;

@end