//
//  NUAnimationDefaults.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//
//

#import <Foundation/Foundation.h>

@interface NUAnimationDefaults : NSObject

+ (id)sharedDefaults;

@property NSTimeInterval defaultDuration;
@property UIViewAnimationOptions defaultOptions;
@property UIViewAnimationCurve defaultCurve;

@property CGFloat defaultDamping;
@property CGFloat defaultInitialVelocity;

@property double defaultSpringMass;
@property double defaultSpringConstant;

@end