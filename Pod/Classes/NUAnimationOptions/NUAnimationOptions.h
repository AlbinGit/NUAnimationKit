//
//  NUAnimationOptions.h
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NUAnimationOptions : NSObject {
    NSTimeInterval _duration;
}

@property NSTimeInterval duration;
@property UIViewAnimationOptions options;
@property UIViewAnimationCurve curve;

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve;

@end

@interface NUSpringAnimationOptions : NUAnimationOptions

extern NSTimeInterval NUSpringAnimationNaturalDuration;


//Physics-related
@property (nonatomic) double settleTolerance;
@property (nonatomic) double springMass;
@property (nonatomic) double springConstant;

//Animation-related
@property (nonatomic) CGFloat damping;
@property (nonatomic) CGFloat initialVelocity;

- (instancetype)initWithOptions: (NUAnimationOptions *)options;

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve
                            andDamping: (CGFloat)damping
                    andInitialVelocity: (CGFloat)initialVelocity;

- (NSTimeInterval)naturalDuration;

@end