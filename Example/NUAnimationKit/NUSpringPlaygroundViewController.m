//
//  NUSpringPlaygroundViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUSpringPlaygroundViewController.h"

@interface NUSpringPlaygroundViewController ()
@property UIView *animationView;
@property UISlider *dampingSlider;
@property UISlider *velocitySlider;
@property UISlider *durationSlider;
@property UISwitch *durationSwitch;

@property UILabel *naturalDurationLabel;
@property UILabel *durationLabel;
@property UILabel *dampingLabel;
@property UILabel *velocityLabel;
@end

@implementation NUSpringPlaygroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 100, 100)];
    self.animationView.backgroundColor = [UIColor redColor];
    
    //Damping
    self.dampingSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    self.dampingSlider.value = 0.5;
    self.dampingSlider.minimumValue = 1E-3;
    self.dampingSlider.maximumValue = 1;
    [self.dampingSlider addTarget:self
                           action:@selector(updateValueFromSlider:)
                 forControlEvents:UIControlEventValueChanged];
    
    self.dampingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 100, 60)];
    self.dampingLabel.numberOfLines = 0;
    self.dampingLabel.text = [NSString stringWithFormat:@"Damping:\n%f",
                              self.dampingSlider.value];
    
    
    //Duration
    self.durationSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 350, 200, 100)];
    self.durationSlider.value = 0.5;
    self.durationSlider.minimumValue = 1E-3;
    self.durationSlider.maximumValue = 10;
    [self.durationSlider addTarget:self
                           action:@selector(updateValueFromSlider:)
                 forControlEvents:UIControlEventValueChanged];
    
    self.durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 350, 100, 60)];
    self.durationLabel.numberOfLines = 0;
    self.durationLabel.text = [NSString stringWithFormat:@"Duration:\n%f",
                              self.durationSlider.value];
    
    self.durationSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200, 450, 100, 100)];
    [self.durationSwitch addTarget:self
                            action:@selector(updateDurationState:)
                  forControlEvents:UIControlEventValueChanged];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, 200, 20)];
    label.text = @"Use natural duration";
    
    self.naturalDurationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, 300, 20)];
    
    //Velocity
    self.velocitySlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 500, 200, 100)];
    self.velocitySlider.minimumValue = 0;
    self.velocitySlider.maximumValue = 100;
    [self.velocitySlider addTarget:self
                           action:@selector(updateValueFromSlider:)
                 forControlEvents:UIControlEventValueChanged];
    
    self.velocityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 200, 60)];
    self.velocityLabel.numberOfLines = 0;
    self.velocityLabel.text = [NSString stringWithFormat:@"Initial Velocity:\n%f",
                               self.velocitySlider.value];
    
    [self.view addSubview:self.animationView];
    [self.view addSubview:self.dampingSlider];
    [self.view addSubview:self.durationLabel];
    [self.view addSubview:self.durationSwitch];
    [self.view addSubview:label];
    [self.view addSubview:self.durationSlider];
    [self.view addSubview:self.naturalDurationLabel];
    [self.view addSubview:self.velocitySlider];
    [self.view addSubview:self.velocityLabel];
    [self.view addSubview:self.dampingLabel];
}

- (void)startAnimation {
    [self.animationView setFrameX:70];
    self.startButton.enabled = false;
    
    [self.controller removeAllAnimations];
    
    __weak typeof(self) weakself = self;
    NUBaseAnimation *animation =
    [self.controller addAnimation:^{
        __strong typeof(self) self = weakself;
        [self.animationView setFrameX:150];
    }].withType(NUAnimationTypeSpringy)
    .withDuration(self.durationSwitch.on ? NUSpringAnimationNaturalDuration : self.durationSlider.value).
    withDamping(self.dampingSlider.value).withInitialVelocity(self.velocitySlider.value);
    
    if (self.durationSwitch.on) {
        self.naturalDurationLabel.text = [NSString stringWithFormat:@"Natural duration: %f",
                                          animation.options.duration];
    }
    
    [self.controller startAnimationChainWithCompletionBlock:^{
        self.startButton.enabled = true;
    }];
}

- (void)updateDurationState: (UISwitch *)control {
    self.durationSlider.enabled = !control.on;
    self.durationLabel.textColor = control.on ? [UIColor lightGrayColor] : [UIColor blackColor];
}

- (void)updateValueFromSlider: (UISlider *)slider {
    if (slider == self.dampingSlider) {
        self.dampingLabel.text = [NSString stringWithFormat:@"Damping:\n%f", slider.value];
    } else if (slider == self.velocitySlider) {
        self.velocityLabel.text = [NSString stringWithFormat:@"Initial Velocity:\n%f", slider.value];
    } else {
        self.durationLabel.text = [NSString stringWithFormat:@"Duration:\n%f", slider.value];
    }
}

@end
