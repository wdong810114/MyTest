//
//  ImplicitAnimation1ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/7.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "ImplicitAnimation1ViewController.h"

@interface ImplicitAnimation1ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation ImplicitAnimation1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.layerView];

    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(60.0, 50.0, 100.0, 100.0);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    // 1
    self.colorLayer.delegate = self;
    
    // 2
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    self.colorLayer.actions = @{@"backgroundColor": transition};
    
    NSLog(@"before presentationLayer:%@", self.colorLayer.presentationLayer);
    [self.layerView.layer addSublayer:self.colorLayer];
    
    [self.layerView addSubview:self.changeButton];
}

- (void)changeColor
{
//    [CATransaction begin];
////    [CATransaction setDisableActions:YES];
//    [CATransaction setAnimationDuration:1.0];
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.colorLayer.affineTransform = transform;
//    }];
//    CGFloat red = arc4random() / (CGFloat)INT_MAX;
//    CGFloat green = arc4random() / (CGFloat)INT_MAX;
//    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    [CATransaction commit];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    NSLog(@"after presentationLayer:%@", self.colorLayer.presentationLayer);
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    if([event isEqualToString:@"backgroundColor"]) {
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        return transition;
    }
    
    return nil;
}

- (UIView *)layerView
{
    if(!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 220.0) / 2, 80.0, 220.0, 220.0)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _layerView;
}

- (UIButton *)changeButton
{
    if(!_changeButton) {
        _changeButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.layerView.bounds) - 100.0) / 2, 175.0, 100.0, 30.0)];
        _changeButton.backgroundColor = [UIColor clearColor];
        _changeButton.layer.borderWidth = 0.5;
        _changeButton.layer.borderColor = [UIColor blackColor].CGColor;
        _changeButton.layer.cornerRadius = 3.0;
        _changeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_changeButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_changeButton setTitle:@"Change Color" forState:UIControlStateNormal];
        [_changeButton addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _changeButton;
}

@end
