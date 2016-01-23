//
//  NUBaseAnimationTests.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/23/16.
//
//

#import <XCTest/XCTest.h>
#import "NUBaseAnimation.h"

@interface NUBaseAnimationTests : XCTestCase

@end

@implementation NUBaseAnimationTests

- (void)testDefaultTypeInstantiation {
    id animationBlock = ^{
        ;
    };
    NUBaseAnimation *animation = [NUBaseAnimation animationBlockWithType:NUAnimationTypeDefault
                                                              andOptions:[NUAnimationOptions
                                                                          animationWithDuration:1
                                                                          andOptions:UIViewAnimationOptionAutoreverse
                                                                          andCurve:UIViewAnimationCurveEaseInOut]
                                                                andDelay:1
                                                           andAnimations:animationBlock];
    
    //Type
    XCTAssertEqual(animation.type, NUAnimationTypeDefault);
    
    //Options
    XCTAssertTrue([animation.options isKindOfClass:[NUAnimationOptions class]]);
    XCTAssertFalse([animation.options isKindOfClass:[NUSpringAnimationOptions class]]);
    XCTAssertEqual(animation.options.duration, 1);
    XCTAssertEqual(animation.options.options, UIViewAnimationOptionAutoreverse);
    XCTAssertEqual(animation.options.curve, UIViewAnimationCurveEaseInOut);
    
    //Delay
    XCTAssertEqual(animation.delay, 1);
    
    //Animations
    XCTAssertEqualObjects(animation.animationBlock, animationBlock);
}

- (void)testSpringyTypeInstantiation {
    id animationBlock = ^{
        ;
    };
    NUBaseAnimation *animation = [NUBaseAnimation animationBlockWithType:NUAnimationTypeSpringy
                                                              andOptions:[NUAnimationOptions
                                                                          animationWithDuration:1
                                                                          andOptions:UIViewAnimationOptionAutoreverse
                                                                          andCurve:UIViewAnimationCurveEaseInOut]
                                                                andDelay:1
                                                           andAnimations:animationBlock];
    
    //Type
    XCTAssertEqual(animation.type, NUAnimationTypeDefault);
    
    //Options
    XCTAssertTrue([animation.options isKindOfClass:[NUAnimationOptions class]]);
    XCTAssertTrue([animation.options isKindOfClass:[NUSpringAnimationOptions class]]);
    XCTAssertEqual(animation.options.duration, 1);
    XCTAssertEqual(animation.options.options, UIViewAnimationOptionAutoreverse);
    XCTAssertEqual(animation.options.curve, UIViewAnimationCurveEaseInOut);
    
    //Delay
    XCTAssertEqual(animation.delay, 1);
    
    //Animations
    XCTAssertEqualObjects(animation.animationBlock, animationBlock);
}

@end
