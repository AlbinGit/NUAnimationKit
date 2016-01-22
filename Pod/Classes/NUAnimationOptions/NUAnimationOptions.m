//
//  NUAnimationOptions.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUAnimationOptions.h"

@implementation NUAnimationOptions

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
        self.options = 0;
        self.curve = UIViewAnimationCurveLinear;
    }
    return self;
}

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve {
    NUAnimationOptions *result = [[NUAnimationOptions alloc] init];
    
    result.duration = duration;
    result.options = options;
    result.curve = curve;
    
    return result;
}
@end

@interface NUSpringAnimationOptions()
@property (nonatomic, readwrite) NSTimeInterval naturalTimeInterval;
@end

@implementation NUSpringAnimationOptions

#define naturalConstant 1.0f/(2.0f*M_PI)
#define settleTolerance 0.1f
#define springConstant 1000.0f //N/m
#define mass 1.0f //kg
#define naturalFrequency naturalConstant*sqrt(springConstant/mass)

double NUSpringAnimationNaturalDuration = -1;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.damping = 0.5;
        self.initialVelocity = 0;
    }
    return self;
}

- (NSTimeInterval)naturalTimeInterval {
    if (_naturalTimeInterval) {
        return _naturalTimeInterval;
    }
    _naturalTimeInterval = -log(settleTolerance)/(self.damping*naturalFrequency);
    return _naturalTimeInterval;
}

- (NSTimeInterval)duration {
    if (_duration == NUSpringAnimationNaturalDuration) {
        return self.naturalTimeInterval;
    }
    return _duration;
}

+ (instancetype) animationWithDuration:(NSTimeInterval)duration
                            andOptions:(UIViewAnimationOptions)options
                              andCurve:(UIViewAnimationCurve)curve
                            andDamping:(CGFloat)damping
                    andInitialVelocity: (CGFloat)initialVelocity {
    NUSpringAnimationOptions *result = [[NUSpringAnimationOptions alloc] init];
    
    result.duration = duration;
    result.options = options;
    result.curve = curve;
    result.damping = damping;
    result.initialVelocity = initialVelocity;
    
    return result;
}

@end