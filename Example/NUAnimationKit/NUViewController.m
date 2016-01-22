//
//  NUViewController.m
//  NUAnimationKit
//
//  Created by Victor on 01/22/2016.
//  Copyright (c) 2016 Victor. All rights reserved.
//

#import "NUViewController.h"
#import "NUAnimationController.h"

@interface NUViewController ()

@end

@implementation NUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *animationView1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 100)];
    animationView1.text = @"NU";
    
    UILabel *animationView2= [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 100, 100)];
    animationView2.text = @"Animation";
    
    UILabel *animationView3 = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 100, 100)];
    animationView3.text = @"Kit";
    
    UILabel *completionLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 600, 300, 20)];
    completionLabel.text = @"Working on it";
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 600, 300, 20)];
    
    [self.view addSubview:animationView1];
    [self.view addSubview:animationView2];
    [self.view addSubview:animationView3];
    [self.view addSubview:completionLabel];
    [self.view addSubview:progressLabel];
    
    NUAnimationController *controller = [[NUAnimationController alloc] init];
    
    [controller addAnimation:^{
        [animationView1 setFrame:CGRectMake(30, 100, 100, 100)];
    }].withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
    .andThen(^{
        completionLabel.text = @"Almost there";
    });
    
    [controller addAnimation:^{
        [animationView2 setFrame:CGRectMake(60, 100, 100, 100)];
    }].withDelay(0.1).withDuration(0.3).withCurve(UIViewAnimationCurveEaseInOut);
    
    [controller addAnimation:^{
        animationView3.frame = CGRectMake(150, 100, 100, 100);
    }].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        progressLabel.text = [NSString stringWithFormat:@"%f", progress];
    });
    
    [controller startAnimationChainWithCompletionBlock:^{
        completionLabel.text = @"All done";
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
