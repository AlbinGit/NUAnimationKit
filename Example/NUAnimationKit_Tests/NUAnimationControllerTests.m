//
//  NUAnimationControllerTests.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NUAnimationController.h"
#import <objc/runtime.h>

@interface NUAnimationControllerTests : XCTestCase
@property (nonatomic, strong)NUAnimationController *controller;
@property XCTestExpectation *deallocExpectation;
@end

@implementation NUAnimationControllerTests

- (void)setUp {
    [super setUp];
    self.controller = [[NUAnimationController alloc] init];
}

- (void)testCreationShorthandNotation {
    NUCompositeAnimation *result = [self.controller addAnimation:^{
    }];
    XCTAssertTrue([result isKindOfClass:[NUCompositeAnimation class]]);
}

- (void)testNoAnimations {
    XCTestExpectation *expect = [self expectationWithDescription:@"noAnimations"];
    [self.controller startAnimationChain];
    [self.controller startAnimationChainWithCompletionBlock:^{
        [expect fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testAddedAnimationsShouldBeCalled {
    XCTestExpectation *expect1 = [self expectationWithDescription:@"callAnimations1"];
    XCTestExpectation *expect2 = [self expectationWithDescription:@"callAnimations2"];
    
    [self.controller addAnimation:^{
        [expect1 fulfill];
    }];
    [self.controller addAnimation:^{
        [expect2 fulfill];
    }];
    
    [self.controller startAnimationChain];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testCompletionBlockShouldBeCalled {
    XCTestExpectation *expect = [self expectationWithDescription:@"completion"];
    
    [self.controller addAnimation:^{
        ;
    }];
    
    
    [self.controller startAnimationChainWithCompletionBlock:^{
        [expect fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testCancelAnimations {
    XCTestExpectation *expect = [self expectationWithDescription:@"firstAnimation"];
    XCTestExpectation *expectCompletion = [self expectationWithDescription:@"completionBlock"];
    
    __weak typeof(self) weakself = self;
    [self.controller addAnimation:^{
        __strong typeof(self) self = weakself;
        [self.controller cancelAnimations];
        
        //Wait before fulfilling expectation
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            XCTAssertTrue(self.controller.animationCancelled);
            [expect fulfill];
        });
    }];
    
    [self.controller addAnimation:^{
        __strong typeof(self) self = weakself;
        XCTFail(@"Second animation shouldn't be called");
    }];
    
    [self.controller startAnimationChainWithCompletionBlock:^{
        XCTAssertTrue(self.controller.animationCancelled);
        [expectCompletion fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
    
}

@end
