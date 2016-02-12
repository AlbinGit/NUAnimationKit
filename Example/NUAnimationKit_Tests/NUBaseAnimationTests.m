//
//  NUBaseAnimationTests.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/23/16.
//
//

#import <XCTest/XCTest.h>
#import <NUAnimationKit/NUAnimationController.h>
#import <NUAnimationKit/NUBaseAnimation.h>

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
    XCTAssertEqual(animation.type, NUAnimationTypeSpringy);
    
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

- (void)testInitializationBlockIsCalled {
    XCTestExpectation *expect = [self expectationWithDescription:@"initialization"];
    id block = ^{
        [expect fulfill];
    };
    
    NUBaseAnimation *animation = [NUBaseAnimation animationBlockWithType:NUAnimationTypeDefault
                                                              andOptions:[NUAnimationOptions animationWithDuration:0
                                                                                                        andOptions:0
                                                                                                          andCurve:0]
                                                                andDelay:0
                                                           andAnimations:^{}
                                                  andInitializationBlock:block
                                                      andCompletionBlock:nil
                                                    andCancellationBlock:nil];
    //Controller calls public method
    [animation animationWillBegin];
    [self waitForExpectationsWithTimeout:1 handler:nil];

}

- (void)tesCancellationBlockIsCalled {
    XCTestExpectation *expect = [self expectationWithDescription:@"cancellation"];
    id block = ^{
        [expect fulfill];
    };
    
    NUBaseAnimation *animation = [NUBaseAnimation animationBlockWithType:NUAnimationTypeDefault
                                                              andOptions:[NUAnimationOptions animationWithDuration:0
                                                                                                        andOptions:0
                                                                                                          andCurve:0]
                                                                andDelay:0
                                                           andAnimations:^{}
                                                  andInitializationBlock:nil
                                                      andCompletionBlock:nil
                                                    andCancellationBlock:block];
    //Controller calls public method
    [animation animationDidCancel];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testCompletionBlockIsCalled {
    XCTestExpectation *expect = [self expectationWithDescription:@"completion"];
    id block = ^{
        [expect fulfill];
    };
    
    NUBaseAnimation *animation = [NUBaseAnimation animationBlockWithType:NUAnimationTypeDefault
                                                              andOptions:[NUAnimationOptions animationWithDuration:0
                                                                                                        andOptions:0
                                                                                                          andCurve:0]
                                                                andDelay:0
                                                           andAnimations:^{}
                                                  andInitializationBlock:nil
                                                      andCompletionBlock:block
                                                    andCancellationBlock:nil];
    //Controller calls public method
    [animation animationDidFinish];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
