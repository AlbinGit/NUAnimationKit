//
//  NUBaseExampleViewController.h
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NUAnimationKit/NUAnimationController.h>
#import <Masonry/Masonry.h>

@interface NUBaseExampleViewController : UIViewController

- (void)startAnimation;
- (void)installInitialConstraints NS_REQUIRES_SUPER;

@property (nonatomic, strong) NUAnimationController *controller;
@property BOOL didInstallConstraints;
@property (nonatomic, weak) UIButton *startButton;

@end
