//
//  CoreAnimation2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/5/24.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation2ViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface CoreAnimation2ViewController ()

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) UIView *part1View;
@property (nonatomic, strong) UIView *part2View;
@property (nonatomic, strong) UIView *part3View;
@property (nonatomic, strong) UIView *part4View;

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation CoreAnimation2ViewController

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

- (void)addStretchableImage:(UIImage *)image withContentCenter:(CGRect)rect toLayer:(CALayer *)layer
{
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsCenter = rect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.layerView];
    
    [self.view addSubview:self.part1View];
    [self.view addSubview:self.part2View];
    [self.view addSubview:self.part3View];
    [self.view addSubview:self.part4View];
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    
    UIImage *image = [UIImage imageNamed:@"drinks"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;//kCAGravityCenter;
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    self.layerView.layer.masksToBounds = YES;
    
    [self addSpriteImage:image withContentRect:CGRectMake(0.0, 0.0, 0.5, 0.5) toLayer:self.part1View.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.0, 0.5, 0.5) toLayer:self.part2View.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.0, 0.5, 0.5, 0.5) toLayer:self.part3View.layer];
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.part4View.layer];
    
    UIImage *image1 = [UIImage imageNamed:@"points"];
    [self addStretchableImage:image1 withContentCenter:CGRectMake(0.45, 0.45, 0.1, 0.1) toLayer:self.button1.layer];
    [self addStretchableImage:image1 withContentCenter:CGRectMake(0.0, 0.0, 1.0, 1.0) toLayer:self.button2.layer];
}

- (UIView *)layerView
{
    if(!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, (SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - 150.0) / 2, 150.0, 150.0)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _layerView;
}

- (UIView *)part1View
{
    if(!_part1View) {
        _part1View = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
        _part1View.backgroundColor = [UIColor whiteColor];
    }
    
    return _part1View;
}

- (UIView *)part2View
{
    if(!_part2View) {
        _part2View = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100.0, 0.0, 100.0, 100.0)];
        _part2View.backgroundColor = [UIColor whiteColor];
    }
    
    return _part2View;
}

- (UIView *)part3View
{
    if(!_part3View) {
        _part3View = [[UIView alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - 100.0, 100.0, 100.0)];
        _part3View.backgroundColor = [UIColor whiteColor];
    }
    
    return _part3View;
}

- (UIView *)part4View
{
    if(!_part4View) {
        _part4View = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100.0, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - 100.0, 100.0, 100.0)];
        _part4View.backgroundColor = [UIColor whiteColor];
    }
    
    return _part4View;
}

- (UIButton *)button1
{
    if(!_button1) {
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.layerView.frame) + 10.0, CGRectGetMinY(self.layerView.frame), 150.0, 30.0)];
        _button1.backgroundColor = [UIColor clearColor];
    }
    
    return _button1;
}

- (UIButton *)button2
{
    if(!_button2) {
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.layerView.frame) + 10.0, CGRectGetMaxY(self.layerView.frame) - 30.0, 150.0, 30.0)];
        _button2.backgroundColor = [UIColor clearColor];
    }
    
    return _button2;
}

@end
