//
//  NUBaseExampleViewController.h
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NUAnimationKit/NUAnimationController.h>

@interface NUBaseExampleViewController : UIViewController

- (void)startAnimation;
@property (nonatomic, strong) NUAnimationController *controller;

@property (nonatomic, weak) UIButton *startButton;

@end
