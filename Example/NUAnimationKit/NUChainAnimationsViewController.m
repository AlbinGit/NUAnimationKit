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
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, strong) UIView *animationView1;
@property (nonatomic, strong) UIView *animationView2;
@property (nonatomic, strong) UIView *animationView3;
@end

static CGFloat const kViewOffset = 48;

@implementation NUChainAnimationsViewController

- (void)installInitialConstraints {
    [self.completionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.startButton.mas_top).offset(-kViewOffset);
        make.left.right.equalTo(self.view);
    }];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.completionLabel.mas_top).offset(-kViewOffset);
        make.left.right.equalTo(self.view);
    }];

    [super installInitialConstraints];
}

- (void)viewDidLoad {
    [self setupViews];
    [super viewDidLoad];

    __weak typeof(self) weakself = self;
    [self.controller addAnimations:^{
        __strong typeof(self) self = weakself;
        [self.animationView1 setFrameY:300];
        self.animationView1.backgroundColor = [UIColor grayColor];
    }]
    .withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
    .withDuration(0.5)
    .ifCancelled(^{
        NSLog(@"First was cancelled");
    })
    .andThen(^{
        __strong typeof(self) self = weakself;
        self.completionLabel.text = @"Working on it";
    });

    [self.controller addAnimations:^{
        __strong typeof(self) self = weakself;
        [self.animationView2 setFrameY:300];
    }]
    .withDuration(0.5)
    .withCurve(UIViewAnimationCurveEaseInOut)
    .ifCancelled(^{
        NSLog(@"Second was cancelled");
    });

    [self.controller addAnimations:^{
        __strong typeof(self) self = weakself;
        [self.animationView3 setFrameY:300];
    }]
    .withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration)
    .alongSideBlock(^(CGFloat progress){
        __strong typeof(self) self = weakself;
        self.progressLabel.text = [NSString stringWithFormat:@"%f", progress];
    })
    .ifCancelled(^{
        NSLog(@"Third was cancelled");
    });

    [self.controller setCancellationBlock:^{
        NSLog(@"Someone was cancelled");
    }];

    self.controller.shouldRunAllAnimationsIfCancelled = true;
}

- (void)setupViews {
    self.animationView1 = [UIView new];
    self.animationView1.backgroundColor = [UIColor redColor];

    self.animationView2= [UIView new];
    self.animationView2.backgroundColor = [UIColor greenColor];

    self.animationView3 = [UIView new];
    self.animationView3.backgroundColor = [UIColor blueColor];

    self.completionLabel = [UILabel new];
    self.completionLabel.text = @"Not started";

    self.progressLabel = [[UILabel alloc] init];
    self.progressLabel.text = [NSString stringWithFormat:@"%f", 0.0f];

    CGFloat viewOffset = ([UIApplication sharedApplication].keyWindow.bounds.size.width - 300)/2.f;
    self.animationView1.frame = CGRectMake(viewOffset, 100, 100, 100);
    self.animationView2.frame = CGRectMake(100 + viewOffset, 100, 100, 100);
    self.animationView3.frame = CGRectMake(200 + viewOffset, 100, 100, 100);

    [self.view addSubview:self.animationView1];
    [self.view addSubview:self.animationView2];
    [self.view addSubview:self.animationView3];
    [self.view addSubview:self.completionLabel];
    [self.view addSubview:self.progressLabel];
}

- (void)startAnimation {
    __weak typeof(self) weakself = self;
    [self.controller startAnimationChainWithCompletionBlock:^{
        __strong typeof(self) self = weakself;
        self.completionLabel.text = @"All done";
    }];
}

@end
