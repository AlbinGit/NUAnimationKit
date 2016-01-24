//
//  NUCompositeAnimationTests.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/23/16.
//
//

#import <XCTest/XCTest.h>
#import "NUAnimationController.h"

@interface NUCompositeAnimationTests : XCTestCase

@property (nonatomic, strong) NUCompositeAnimation *composite;

@end

@implementation NUCompositeAnimationTests

- (void)setUp {
    [super setUp];
    
    self.composite = [[NUCompositeAnimation alloc] init];
    
}

- (void)testTypeShorthandNotation {
    self.composite.withType(NUAnimationTypeDefault);
    XCTAssertEqual(self.composite.type, NUAnimationTypeDefault);
    
    self.composite.withType(NUAnimationTypeSpringy);
    XCTAssertEqual(self.composite.type, NUAnimationTypeSpringy);
}

- (void)testOptionShorthandNotation {
    NUAnimationOptions *options = [NUAnimationOptions animationWithDuration:0
                                                                 andOptions:0
                                                                   andCurve:UIViewAnimationCurveLinear];
    
    self.composite.withOptions(options);
    XCTAssertEqualObjects(self.composite.options, options);
}

- (void)testDelayShorthandNotation {
    self.composite.withDelay(1.03);
    XCTAssertEqual(self.composite.delay, 1.03);
}

- (void)testCurveShorthandNotation {
    self.composite.withCurve(UIViewAnimationCurveEaseInOut);
    XCTAssertEqual(self.composite.options.curve, UIViewAnimationCurveEaseInOut);
    
    self.composite.withCurve(UIViewAnimationCurveLinear);
    XCTAssertEqual(self.composite.options.curve, UIViewAnimationCurveLinear);
}

- (void)testInitializationShorthandNotation {
    id block = ^{;};
    self.composite.butBefore(block);
    XCTAssertEqualObjects(self.composite.initializationBlock, block);
}

- (void)testCompletionShorthandNotation {
    id block = ^{;};
    self.composite.andThen(block);
    XCTAssertEqualObjects(self.composite.completionBlock, block);
}

- (void)testAnimationOptionShorthandNotation {
    self.composite.withAnimationOption(UIViewAnimationOptionAutoreverse);
    XCTAssertEqual(self.composite.options.options, UIViewAnimationOptionAutoreverse);
}

- (void)testDurationShorthandNotation {
    self.composite.withDuration(1.03);
    XCTAssertEqual(self.composite.options.duration, 1.03);
}

- (void)testDampingShorthandNotationShouldThrowForNonSpringy {
    XCTAssertThrows(self.composite.withDamping(0.3));
}

- (void)testDampingShorthandNotation {
    self.composite.type = NUAnimationTypeSpringy;
    self.composite.withDamping(0.212);
    XCTAssert([self.composite.options isKindOfClass:[NUSpringAnimationOptions class]]);
    XCTAssertEqual(((NUSpringAnimationOptions *)self.composite.options).damping, 0.212);
}

- (void)testInitialVelocityShorthandNotationShouldThrowForNonSpringy {
    XCTAssertThrows(self.composite.withInitialVelocity(0.3));
}

- (void)testInitialVelocityShorthandNotation {
    self.composite.type = NUAnimationTypeSpringy;
    self.composite.withInitialVelocity(0.212);
    XCTAssert([self.composite.options isKindOfClass:[NUSpringAnimationOptions class]]);
    XCTAssertEqual(((NUSpringAnimationOptions *)self.composite.options).initialVelocity, 0.212);
}

- (void)testAlongsideBlockShorthandNotation {
    id block = ^(CGFloat f){;};
    self.composite.alongSideBlock(block);
    XCTAssertEqualObjects(self.composite.progressBlock, block);
}

- (void)testInParallelWithShorthandNotation {
    id block = ^{;};
    NUCompositeAnimation *result = self.composite.inParallelWith(block);
    XCTAssertNotNil(result);
    XCTAssertNotEqualObjects(result, self.composite);
    XCTAssertEqualObjects(result.animationBlock, block);
}

@end
