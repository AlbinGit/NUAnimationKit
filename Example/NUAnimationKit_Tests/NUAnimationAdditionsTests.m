//
//  NUAnimationAdditionsTests.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/24/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+NUAnimationAdditions.h"

@interface NUAnimationAdditionsTests : XCTestCase

@property (nonatomic, strong) UIView *testView;
@property (nonatomic, readwrite) CGRect initialFrame;
@property (nonatomic, readwrite) CGRect initialLayerFrame;

@end

@implementation NUAnimationAdditionsTests

- (void)setUp {
    [super setUp];
    self.initialFrame = CGRectMake(0, 0, 100, 100);
    self.testView = [[UIView alloc] initWithFrame:self.initialFrame];
    self.initialLayerFrame = self.testView.layer.frame;
}

- (void)testSetFrameX {
    double value = 5;
    [self.testView setFrameX:value];
    XCTAssertEqual(self.testView.frame.origin.x, value);
    XCTAssertEqual(self.testView.frame.origin.y, self.initialFrame.origin.y);
    XCTAssertEqual(self.testView.frame.size.width, self.initialFrame.size.width);
    XCTAssertEqual(self.testView.frame.size.height, self.initialFrame.size.height);
}

- (void)testSetFrameY {
    double value = 5;
    [self.testView setFrameY:value];
    XCTAssertEqual(self.testView.frame.origin.x, self.initialFrame.origin.x);
    XCTAssertEqual(self.testView.frame.origin.y, value);
    XCTAssertEqual(self.testView.frame.size.width, self.initialFrame.size.width);
    XCTAssertEqual(self.testView.frame.size.height, self.initialFrame.size.height);

}

- (void)testSetFrameWidth {
    double value = 5;
    [self.testView setFrameWidth:value];
    XCTAssertEqual(self.testView.frame.origin.x, self.initialFrame.origin.x);
    XCTAssertEqual(self.testView.frame.origin.y, self.initialFrame.origin.y);
    XCTAssertEqual(self.testView.frame.size.width, value);
    XCTAssertEqual(self.testView.frame.size.height, self.initialFrame.size.height);
}

- (void)testSetFrameHeight {
    double value = 5;
    [self.testView setFrameHeight:value];
    XCTAssertEqual(self.testView.frame.origin.x, self.initialFrame.origin.x);
    XCTAssertEqual(self.testView.frame.origin.y, self.initialFrame.origin.y);
    XCTAssertEqual(self.testView.frame.size.width, self.initialFrame.size.width);
    XCTAssertEqual(self.testView.frame.size.height, value);
}

- (void)testSetLayerX {
    double value = 5;
    [self.testView setLayerX:value];
    XCTAssertEqual(self.testView.layer.frame.origin.x, value);
    XCTAssertEqual(self.testView.layer.frame.origin.y, self.initialLayerFrame.origin.y);
    XCTAssertEqual(self.testView.layer.frame.size.width, self.initialLayerFrame.size.width);
    XCTAssertEqual(self.testView.layer.frame.size.height, self.initialLayerFrame.size.height);
}

- (void)testSetLayerY {
    double value = 5;
    [self.testView setLayerY:value];
    XCTAssertEqual(self.testView.layer.frame.origin.x, self.initialLayerFrame.origin.x);
    XCTAssertEqual(self.testView.layer.frame.origin.y, value);
    XCTAssertEqual(self.testView.layer.frame.size.width, self.initialLayerFrame.size.width);
    XCTAssertEqual(self.testView.layer.frame.size.height, self.initialLayerFrame.size.height);
}

- (void)testSetLayerWidth {
    double value = 5;
    [self.testView setLayerWidth:value];
    XCTAssertEqual(self.testView.layer.frame.origin.x, self.initialLayerFrame.origin.x);
    XCTAssertEqual(self.testView.layer.frame.origin.y, self.initialLayerFrame.origin.y);
    XCTAssertEqual(self.testView.layer.frame.size.width, value);
    XCTAssertEqual(self.testView.layer.frame.size.height, self.initialLayerFrame.size.height);
}

- (void)testSetLayerHeight {
    double value = 5;
    [self.testView setLayerHeight:value];
    XCTAssertEqual(self.testView.layer.frame.origin.x, self.initialLayerFrame.origin.x);
    XCTAssertEqual(self.testView.layer.frame.origin.y, self.initialLayerFrame.origin.y);
    XCTAssertEqual(self.testView.layer.frame.size.width, self.initialLayerFrame.size.width);
    XCTAssertEqual(self.testView.layer.frame.size.height, value);
}

@end
