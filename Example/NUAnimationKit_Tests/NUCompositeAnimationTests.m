//
//  NUCompositeAnimationTests.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/23/16.
//
//

#import <XCTest/XCTest.h>
#import <NUAnimationKit/NUAnimationController.h>
#import <OCMock/OCMock.h>

@interface NUCompositeAnimationTests : XCTestCase

@property (nonatomic, strong) NUCompositeAnimation *composite;

@property (nonatomic) CGFloat expectedPercentage;
@property (nonatomic) CFTimeInterval simulatedTimeInterval;

@end

@interface NUBaseAnimation (Private)
@property (nonatomic, strong) NSArray<NSValue *> *targetLayers;
@end


@interface NUCompositeAnimation ()
- (void)updateAnimationProgress;
@end

@implementation NUCompositeAnimationTests

- (void)setUp {
    [super setUp];
    self.composite = [[NUCompositeAnimation alloc] init];
    
    //Exposed private methods
    XCTAssert([NUCompositeAnimation instanceMethodForSelector:@selector(updateAnimationProgress)]);
}

- (void)testFactoryMethod {
    id animationBlock = ^{NSLog(@"animation");};
    id completionBlock = ^{NSLog(@"completion");};
    id cancellationBlock = ^{NSLog(@"cancellation");};
    id progressBlock = ^(CGFloat f){NSLog(@"progress");};
    NSTimeInterval delay = 0.32;
    
    
    UIViewAnimationOptions options = UIViewAnimationOptionRepeat;
    UIViewAnimationCurve curve = UIViewAnimationCurveEaseInOut;
    NSTimeInterval duration = 0.321;
    NUAnimationOptions *optionsObject = [NUAnimationOptions animationWithDuration:duration
                                                                       andOptions:options
                                                                         andCurve:curve];
    
    NUCompositeAnimation *result = [NUCompositeAnimation animationBlockWithType:NUAnimationTypeDefault
                                                                     andOptions:optionsObject
                                                                       andDelay:delay
                                                                  andAnimations:animationBlock
                                                             andCompletionBlock:completionBlock
                                                           andCancellationBlock:cancellationBlock
                                                                 inParallelWith:self.composite
                                                               animateAlongside:progressBlock];
    
    XCTAssertEqual(result.type, NUAnimationTypeDefault);
    XCTAssertEqualObjects(result.options, optionsObject);
    XCTAssertEqual(result.delay, delay);
    XCTAssertEqualObjects(result.animationBlock, animationBlock);
    XCTAssertEqualObjects(result.completionBlock, completionBlock);
    XCTAssertEqualObjects(result.cancellationBlock, cancellationBlock);
    XCTAssertEqualObjects(result.progressBlock, progressBlock);
    
}

- (void)testProgressBlockIsCalled {
    self.simulatedTimeInterval = kCFAbsoluteTimeIntervalSince1970;
    
    //Stub CADisplayLink
    id linkMock = OCMClassMock([CADisplayLink class]);
    //  Setup to return our simulated value
    [OCMStub([linkMock timestamp]) andCall:@selector(simulatedTimeInterval)
                                  onObject:self];
    //  Setup to ignore removeFromRunLoop, since it was never added
    OCMStub([linkMock removeFromRunLoop:[OCMArg any]
                                forMode:[OCMArg any]]);
    //  Setup to return our mocked instance
    [OCMExpect([linkMock displayLinkWithTarget:[OCMArg any]
                                      selector:[OCMArg anySelector]]) andReturn:linkMock];
    
    self.composite = [[NUCompositeAnimation alloc] init];
    
    //Create block with the progress assertion
    self.composite.alongSideBlock(^(CGFloat f){
        NSLog(@"NUCompositeAnimationTests - Percentage received %f, Percentage expected: %f", f, self.expectedPercentage);
        //Due to float-point approximations, we must test if the difference is smaller than a certain established value.
        XCTAssertTrue(fabs(f - self.expectedPercentage) < FLT_EPSILON);
    }).withDuration(1);

    [self.composite animationWillBegin];
    
    //First animation frame. Progress should be zero.
    self.expectedPercentage = 0;
    [self.composite updateAnimationProgress];

    //0.1 seconds passed.
    self.simulatedTimeInterval += 0.1;
    self.expectedPercentage = 0.1;
    [self.composite updateAnimationProgress];
    
    //0.4 more seconds passed
    self.simulatedTimeInterval += 0.4;
    self.expectedPercentage = 0.5;
    [self.composite updateAnimationProgress];
    
    //Animation finished
    self.expectedPercentage = 1;
    [self.composite animationDidFinish];
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

- (void)testCancellationShorthandNotation {
    id block = ^{;};
    self.composite.ifCancelled(block);
    XCTAssertEqualObjects(self.composite.cancellationBlock, block);
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

- (void)testShouldOnlyCreateDisplayLinkIfAnimationHasProgressBlock {
    id displayMock = OCMClassMock([CADisplayLink class]);
    [[displayMock reject] displayLinkWithTarget:[OCMArg isEqual:self.composite]
                                       selector:[OCMArg anySelector]];
    [self.composite animationWillBegin];
    OCMVerifyAll(displayMock);
    [self.composite animationDidFinish];
    [displayMock stopMocking];

    displayMock = OCMClassMock([CADisplayLink class]);
    OCMExpect([displayMock displayLinkWithTarget:[OCMArg isEqual:self.composite]
                                        selector:[OCMArg anySelector]]);
    self.composite.progressBlock = ^(CGFloat progress){};
    [self.composite animationWillBegin];
    OCMVerifyAll(displayMock);
    [self.composite animationDidFinish];
}

- (void)testResetsDisplayLinkEveryTimeAnimationStarts {
    id displayMock = OCMClassMock([CADisplayLink class]);
    OCMExpect([displayMock displayLinkWithTarget:[OCMArg isEqual:self.composite]
                                        selector:[OCMArg anySelector]]);
    self.composite.progressBlock = ^(CGFloat progress){};
    [self.composite animationWillBegin];
    OCMVerifyAll(displayMock);
    [self.composite animationDidFinish];

    OCMExpect([displayMock displayLinkWithTarget:[OCMArg isEqual:self.composite]
                                        selector:[OCMArg anySelector]]);
    self.composite.progressBlock = ^(CGFloat progress){};
    [self.composite animationWillBegin];
    OCMVerifyAll(displayMock);
    [self.composite animationDidFinish];
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

- (void)testAssociatedViewsShorthandNotation {
    UIView *view = [UIView new];
    self.composite.withAssociatedViews(@[view]);
    XCTAssertNotNil(self.composite.targetLayers);
    XCTAssertEqual(self.composite.targetLayers.count, 1);
    XCTAssertEqualObjects([NSValue valueWithNonretainedObject:view.layer], self.composite.targetLayers[0]);
}

@end
