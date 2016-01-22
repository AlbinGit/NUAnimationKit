# NUAnimationKit

<!--[![CI Status](http://img.shields.io/travis/Victor/NUAnimationKit.svg?style=flat)](https://travis-ci.org/Victor/NUAnimationKit)
[![Version](https://img.shields.io/cocoapods/v/NUAnimationKit.svg?style=flat)](http://cocoapods.org/pods/NUAnimationKit)
[![License](https://img.shields.io/cocoapods/l/NUAnimationKit.svg?style=flat)](http://cocoapods.org/pods/NUAnimationKit)
[![Platform](https://img.shields.io/cocoapods/p/NUAnimationKit.svg?style=flat)](http://cocoapods.org/pods/NUAnimationKit)
-->
UIView animation wrapper to facilitate chaining of animation commands.

###Problem
Chaining of UIView animations requires the use of completion handler blocks to chain commands together:

```objc
[UIView animateWithDuration:1
                     animations:^
     {
         //animations
     } completion:^(BOOL finished) {
         if (finished) {
             [UIView animateWithDuration:1
                              animations:^
              {
                  //Next animation block
              } completion:^(BOOL finished) {
                  if (finished) {
                      [UIView animateWithDuration:1
                                       animations:^
                       {
                           //Next animation block
                       } completion:^(BOOL finished) {
                           //And so on..
                       }];
                  }
              }];
         }
     }];
```
Which isn't a particularly elegant solution, and is hard to read.

###This approach
This library creates a wrapper around the chaining of UIView animations using a simple syntax:

```objc
NUAnimationController *controller = [[NUAnimationController alloc] init];

[controller addAnimation:^{
    [animationView1 setFrame:CGRectMake(10, 100, 200, 200)];
}].andThen(^{
	//Executes after the block is done
    self.view.backgroundColor = [UIColor greenColor];
});

//Chains next animation
[controller addAnimation:^{
    [animationView2 setFrame:CGRectMake(10, 300, 200, 200)];
}];
```

NUAnimationKit also allows you to set animation options on creation:

```objc
[controller addAnimation:^{
    label.frame = CGRectMake(200, 500, 200, 20);
}].withDuration(2)
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

NUAnimationKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NUAnimationKit"
```

## Author

Victor Maraccini, vgm.maraccini@gmail.com

## License

NUAnimationKit is available under the MIT license. See the LICENSE file for more info.
