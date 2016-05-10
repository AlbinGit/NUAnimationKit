//
//  NUBaseExampleViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUBaseExampleViewController.h"

static CGFloat const kBottomOffset = 48;

@implementation NUBaseExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.startButton];
    self.controller = [[NUAnimationController alloc] init];
}

- (void)updateViewConstraints {
    if (!self.didInstallConstraints) {
        self.didInstallConstraints = true;
        [self installInitialConstraints];
    }
    [super updateViewConstraints];
}

- (void)installInitialConstraints {
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kBottomOffset);
    }];
}

- (void)startAnimation {
    [self.controller startAnimationChain];
}

- (UIButton *)startButton {
    if (_startButton) {
        return _startButton;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Start" forState:UIControlStateNormal];
    
    _startButton = btn;
    
    return btn;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.controller = nil;
}

@end
