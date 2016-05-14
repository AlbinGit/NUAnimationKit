//
//  NUProgressAnimationViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 5/13/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUProgressAnimationViewController.h"

@interface NUProgressAnimationViewController ()
@property (nonatomic, weak) UILabel *animatedLabel;
@end

@implementation NUProgressAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];

    __weak typeof(self) weakself = self;
    [self.controller addProgressAnimations:^(CGFloat progress) {
        __strong typeof(self) self = weakself;
        self.animatedLabel.text = [NSString stringWithFormat:@"%.3f", progress];
    }]
    .withDuration(2);
}

- (void)setupViews {
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"%.3f", 0.f];
    self.animatedLabel = label;

    [self.view addSubview:label];
}

- (void)installInitialConstraints {
    [self.animatedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [super installInitialConstraints];
}

@end
