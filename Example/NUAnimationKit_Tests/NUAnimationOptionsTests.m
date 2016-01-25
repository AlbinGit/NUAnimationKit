//
//  NUAnimationOptionsTests.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/24/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NUAnimationController.h"
#import "NUAnimationDefaults.h"

@interface NUAnimationOptionsTests : XCTestCase
@property (nonatomic, strong)NUAnimationController *controller;
@end

@implementation NUAnimationOptionsTests

- (void)setUp {
    [super setUp];
    self.controller = [[NUAnimationController alloc] init];
}

- (void)testDefaultFactoryMethod {
    UIViewAnimationCurve curve = UIViewAnimationCurveEaseIn;
    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse;
    NSTimeInterval duration = 1.0123;
    
    NUAnimationOptions *result = [NUAnimationOptions animationWithDuration:duration
                                                                 andOptions:options
                                                                   andCurve:curve];
    XCTAssertNotNil(result);
    XCTAssertEqual(result.duration, duration);
    XCTAssertEqual(result.options, options);
    XCTAssertEqual(result.curve, curve);
}

- (void)testSpringyFactoryMethod {
    CGFloat damping = 0.312, initialVelocity = 5.32;
    UIViewAnimationCurve curve = UIViewAnimationCurveEaseIn;
    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse;
    NSTimeInterval duration = 1.0123;
    
    NUSpringAnimationOptions *result = [NUSpringAnimationOptions animationWithDuration:duration
                                                                            andOptions:options
                                                                              andCurve:curve
                                                                            andDamping:damping
                                                                    andInitialVelocity:initialVelocity];
    
    XCTAssertNotNil(result);
    XCTAssertEqual(result.duration, duration);
    XCTAssertEqual(result.options, options);
    XCTAssertEqual(result.curve, curve);
    XCTAssertEqual(result.damping, damping);
    XCTAssertEqual(result.initialVelocity, initialVelocity);
}

- (void)testRespectsDefaults {
    CGFloat damping = 0.312, initialVelocity = 5.32;
    double springMass = 2.123, springConstant = 2.32E3;
    UIViewAnimationCurve curve = UIViewAnimationCurveEaseIn;
    UIViewAnimationOptions options = UIViewAnimationOptionAutoreverse;
    NSTimeInterval duration = 1.0123;
    
    [NUAnimationDefaults sharedDefaults].defaultDuration = duration;
    [NUAnimationDefaults sharedDefaults].defaultCurve = curve;
    [NUAnimationDefaults sharedDefaults].defaultOptions = options;
    [NUAnimationDefaults sharedDefaults].defaultDamping = damping;
    [NUAnimationDefaults sharedDefaults].defaultInitialVelocity = initialVelocity;
    [NUAnimationDefaults sharedDefaults].defaultSpringMass = springMass;
    [NUAnimationDefaults sharedDefaults].defaultSpringConstant = springConstant;
    
    //Base options
    NUAnimationOptions *test = [[NUAnimationOptions alloc] init];
    XCTAssertEqual(test.duration, duration);
    XCTAssertEqual(test.curve, curve);
    XCTAssertEqual(test.options, options);
    
    //Spring options
    NUSpringAnimationOptions *testSpring = [[NUSpringAnimationOptions alloc] init];
    XCTAssertEqual(testSpring.damping, damping);
    XCTAssertEqual(testSpring.initialVelocity, initialVelocity);
    XCTAssertEqual(testSpring.springMass, springMass);
    XCTAssertEqual(testSpring.springConstant, springConstant);
}

- (void)testNaturalTimeIntervalOverride {
    NUSpringAnimationOptions *options = [[NUSpringAnimationOptions alloc] init];
    
    //Default
    XCTAssertEqual(options.duration, [NUAnimationDefaults sharedDefaults].defaultDuration);
    
    //Natural
    options.duration = NUSpringAnimationNaturalDuration;
    XCTAssertEqual(options.duration, options.naturalDuration);
    
    //Override
    options.duration = 2;
    XCTAssertEqual(options.duration, 2);
}

- (void)testChangesToParametersShouldUpdateNaturalDuration {
    NUSpringAnimationOptions *options = [[NUSpringAnimationOptions alloc] init];
    options.duration = NUSpringAnimationNaturalDuration;
    
    NSTimeInterval originalDuration = options.naturalDuration;
    XCTAssertEqual(options.duration, originalDuration);
    
    //Change damping parameter
    options.damping = options.damping / 2.0f;
    XCTAssertNotEqual(originalDuration, options.naturalDuration);
    originalDuration = options.naturalDuration;
    XCTAssertEqual(options.duration, originalDuration);
    
    //Change spring mass parameter
    options.springMass = options.springMass * 2.0f;
    XCTAssertNotEqual(originalDuration, options.naturalDuration);
    originalDuration = options.naturalDuration;
    XCTAssertEqual(options.duration, originalDuration);
    
    //Change spring constant parameter
    options.springConstant = options.springConstant * 2.0f;
    XCTAssertNotEqual(originalDuration, options.naturalDuration);
    originalDuration = options.naturalDuration;
    XCTAssertEqual(options.duration, originalDuration);
}

@end
