//
//  NUBaseExampleViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUBaseExampleViewController.h"

@implementation NUBaseExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.startButton];
    self.controller = [[NUAnimationController alloc] init];
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
    btn.frame = CGRectMake(50, 600, 160.0, 40.0);
    [btn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Start" forState:UIControlStateNormal];
    
    _startButton = btn;
    
    return btn;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.controller = nil;
}

@end
