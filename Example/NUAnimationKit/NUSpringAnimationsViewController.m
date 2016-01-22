//
//  NUSpringAnimationsViewController.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import "NUSpringAnimationsViewController.h"
#import "NUAnimationController.h"

@interface NUSpringAnimationsViewController ()
@property (nonatomic, strong) NSDate *startDate;
@end

@implementation NUSpringAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *animationView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    animationView1.backgroundColor = [UIColor redColor];
    UILabel *duration1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    duration1.numberOfLines = 0;
    
    UIView *animationView2= [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    animationView2.backgroundColor = [UIColor greenColor];
    UILabel *duration2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    duration2.numberOfLines = 0;
    
    UIView *animationView3 = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    animationView3.backgroundColor = [UIColor blueColor];
    UILabel *duration3 = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    duration3.numberOfLines = 0;
    
    [self.view addSubview:animationView1];
    [self.view addSubview:animationView2];
    [self.view addSubview:animationView3];
    
    [self.view addSubview:duration1];
    [self.view addSubview:duration2];
    [self.view addSubview:duration3];
    
    self.controller = [[NUAnimationController alloc] init];
    
    [self.controller addAnimation:^{
        frameSetY(animationView1.frame, 300);
    }].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        duration1.text = [NSString stringWithFormat:@"Damp = 0.1\n%f\n", progress];
    }).
    withDamping(0.1).andThen(^{
        duration1.text = [NSString stringWithFormat:@"Damp = 0.1\n%f\n%f",1.0f, -[self.startDate timeIntervalSinceNow]];
    }).
    inParallelWith(^{
        frameSetY(animationView2.frame, 300);
    }).withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        duration2.text = [NSString stringWithFormat:@"Damp = 0.3\n%f\n", progress];
    }).
    withDamping(0.3).andThen(^{
        duration2.text = [NSString stringWithFormat:@"Damp = 0.3\n%f\n%f", 1.0f, -[self.startDate timeIntervalSinceNow]];
    }).
    inParallelWith(^{
        frameSetY(animationView3.frame, 300);
    }).withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration).
    alongSideBlock(^(CGFloat progress){
        duration3.text = [NSString stringWithFormat:@"Damp = 0.7\n%f\n", progress];
    }).
    withDamping(0.7).andThen(^{
        duration3.text = [NSString stringWithFormat:@"Damp = 0.7\n%f\n%f", 1.0f, -[self.startDate timeIntervalSinceNow]];
    });

}

- (void)startAnimation {
    [super startAnimation];
    self.startDate = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
