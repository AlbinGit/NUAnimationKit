//
//  NUChainAnimationsViewController.m
//  NUAnimationKit
//
//  Created by Victor on 01/22/2016.
//  Copyright (c) 2016 Victor. All rights reserved.
//

#import "NUChainAnimationsViewController.h"

@interface NUChainAnimationsViewController ()
@property (nonatomic, strong) UILabel *completionLabel;
@end

@implementation NUChainAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *animationView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    animationView1.backgroundColor = [UIColor redColor];
    
    UIView *animationView2= [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    animationView2.backgroundColor = [UIColor greenColor];
    
    UIView *animationView3 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    animationView3.backgroundColor = [UIColor blueColor];

    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 500, 300, 20)];
    [slider addTarget:self
               action:@selector(updateAnimation:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 1;
    slider.minimumValue = 0;
    
    self.completionLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 300, 300, 20)];
    self.completionLabel.text = @"Not started";
    
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 300, 20)];
    progressLabel.text = [NSString stringWithFormat:@"%f", 0.0f];
    
    [self.view addSubview:animationView1];
    [self.view addSubview:animationView2];
    [self.view addSubview:animationView3];
    [self.view addSubview:slider];
    [self.view addSubview:self.completionLabel];
    [self.view addSubview:progressLabel];
    
    __weak typeof(self) weakself = self;
    NUBaseAnimation *one = [self.controller addAnimations:^{
        [animationView1 setFrameY:400];
        animationView1.backgroundColor = [UIColor grayColor];
    }].withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
    .withDuration(2)
    .ifCancelled(^{
        NSLog(@"First was cancelled");
    })
    .andThen(^{
        __strong typeof(self) self = weakself;
        self.completionLabel.text = @"Working on it";
    });
    [one setAssociatedViews:@[animationView1]];
    
    NUBaseAnimation *two = [self.controller addAnimations:^{
        [animationView2 setFrameY:400];
    }].withDelay(0.1).withDuration(2).withCurve(UIViewAnimationCurveEaseInOut)
    .ifCancelled(^{
        NSLog(@"Second was cancelled");
    });
    [two setAssociatedViews:@[animationView2]];
    
    NUBaseAnimation *three = [self.controller addAnimations:^{
        [animationView3 setFrameY:400];
    }].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        progressLabel.text = [NSString stringWithFormat:@"%f", progress];
    })
    .ifCancelled(^{
        NSLog(@"Third was cancelled");
    });
    [three setAssociatedViews:@[animationView3]];
    
    [self.controller setCancellationBlock:^{
        NSLog(@"Someone was cancelled");
    }];
    
    self.controller.shouldRunAllAnimationsIfCancelled = true;
}

- (void)updateAnimation:(UISlider *)slider {
    [self.controller animateToProgress:slider.value];
}

- (void)startAnimation {
    __weak typeof(self) weakself = self;
    [self.controller startAnimationChainWithCompletionBlock:^{
        __strong typeof(self) self = weakself;
        self.completionLabel.text = @"All done";
    }];
}

@end
