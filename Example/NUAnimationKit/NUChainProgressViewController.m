//
//  NUChainProgressViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 5/10/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUChainProgressViewController.h"

@interface NUChainProgressViewController ()
@property (nonatomic, strong) UIView *animationView1;
@property (nonatomic, strong) UIView *animationView2;
@property (nonatomic, strong) UIView *animationView3;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation NUChainProgressViewController

- (void)installInitialConstraints {
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.startButton.mas_top).offset(48);
        make.left.equalTo(self.view).offset(48);
        make.right.equalTo(self.view).offset(-48);
    }];

    [super installInitialConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];

    __weak typeof(self) weakself = self;
    [self.controller addAnimations:^{
        __strong typeof(self) self = weakself;
        [self.animationView1 setFrameY:300];
        self.animationView1.backgroundColor = [UIColor grayColor];
    }]
    .withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
    .withDuration(0.5)
    .withAssociatedViews(@[self.animationView1]);

    [self.controller addAnimations:^{
        __strong typeof(self) self = weakself;
        [self.animationView2 setFrameY:300];
    }]
    .withDuration(0.5)
    .withCurve(UIViewAnimationCurveEaseInOut)
    .withAssociatedViews(@[self.animationView2]);;

    [self.controller addAnimations:^{
        __strong typeof(self) self = weakself;
        [self.animationView3 setFrameY:300];
    }]
    .withType(NUAnimationTypeSpringy)
    .withDuration(NUSpringAnimationNaturalDuration)
    .withAssociatedViews(@[self.animationView3]);
}

- (void)setupViews {
    self.animationView1 = [UIView new];
    self.animationView1.backgroundColor = [UIColor redColor];

    self.animationView2= [UIView new];
    self.animationView2.backgroundColor = [UIColor greenColor];

    self.animationView3 = [UIView new];
    self.animationView3.backgroundColor = [UIColor blueColor];

    self.slider = [UISlider new];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    [self.slider addTarget:self
                    action:@selector(updateAnimation:)
          forControlEvents:UIControlEventValueChanged];

    CGFloat viewOffset = ([UIApplication sharedApplication].keyWindow.bounds.size.width - 300)/2.f;
    self.animationView1.frame = CGRectMake(viewOffset, 100, 100, 100);
    self.animationView2.frame = CGRectMake(100 + viewOffset, 100, 100, 100);
    self.animationView3.frame = CGRectMake(200 + viewOffset, 100, 100, 100);

    [self.view addSubview:self.animationView1];
    [self.view addSubview:self.animationView2];
    [self.view addSubview:self.animationView3];
    [self.view addSubview:self.slider];

    self.startButton.hidden = true;
}

- (void)updateAnimation:(UISlider *)slider {
    [self.controller animateToProgress:slider.value];
}

@end
