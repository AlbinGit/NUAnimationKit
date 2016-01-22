//
//  NUBaseExampleViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUBaseExampleViewController.h"

@interface NUBaseExampleViewController ()
@property (nonatomic, weak) UIButton *startButton;
@end

@implementation NUBaseExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.startButton];
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


@end
