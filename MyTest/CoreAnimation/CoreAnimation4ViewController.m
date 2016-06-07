//
//  CoreAnimation4ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/2.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation4ViewController.h"

@interface CoreAnimation4ViewController ()

@property (nonatomic, strong) UIView *layerView1;
@property (nonatomic, strong) UIView *layerView2;
@property (nonatomic, strong) UIView *layerView3;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation CoreAnimation4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.layerView1];
    [self.view addSubview:self.layerView2];
    [self.view addSubview:self.layerView3];
    
    [self.view addSubview:self.imageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [CATransaction setAnimationDuration:3.0];
    self.maskLayer.frame = CGRectMake(69.0, 0.0, 50.0, 50.0);
    self.maskLayer.contentsRect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    [CATransaction commit];
}

- (UIView *)layerView1
{
    if(!_layerView1) {
        _layerView1 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50.0) / 2, 50.0, 50.0, 50.0)];
        _layerView1.backgroundColor = [UIColor clearColor];
        
        _layerView1.layer.contentsGravity = kCAGravityCenter;
        _layerView1.layer.contentsScale = [UIScreen mainScreen].scale;
        UIImage *image = [UIImage imageNamed:@"personal"];
        _layerView1.layer.contents = (__bridge id)image.CGImage;
        
        _layerView1.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        _layerView1.layer.shadowOpacity = 0.5;
        CGMutablePathRef squarePath = CGPathCreateMutable();
        CGPathAddRect(squarePath, NULL, _layerView1.bounds);
        _layerView1.layer.shadowPath = squarePath;
        CGPathRelease(squarePath);
    }
    
    return _layerView1;
}

- (UIView *)layerView2
{
    if(!_layerView2) {
        _layerView2 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50.0) / 2, 150.0, 50.0, 50.0)];
        _layerView2.backgroundColor = [UIColor clearColor];
        
        _layerView2.layer.contentsGravity = kCAGravityCenter;
        _layerView2.layer.contentsScale = [UIScreen mainScreen].scale;
        UIImage *image = [UIImage imageNamed:@"personal"];
        _layerView2.layer.contents = (__bridge id)image.CGImage;
        
        _layerView2.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        _layerView2.layer.shadowOpacity = 0.5;
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath, NULL, _layerView2.bounds);
        _layerView2.layer.shadowPath = circlePath;
        CGPathRelease(circlePath);
    }
    
    return _layerView2;
}

- (UIView *)layerView3
{
    if(!_layerView3) {
        _layerView3 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50.0) / 2, 250.0, 50.0, 50.0)];
        _layerView3.backgroundColor = [UIColor clearColor];
        
        _layerView3.layer.contentsGravity = kCAGravityCenter;
        _layerView3.layer.contentsScale = [UIScreen mainScreen].scale;
        UIImage *image = [UIImage imageNamed:@"personal"];
        _layerView3.layer.contents = (__bridge id)image.CGImage;
        
        _layerView3.layer.shadowOpacity = 0.5;
    }
    
    return _layerView3;
}

- (UIImageView *)imageView
{
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 188.0) / 2, 320.0, 188.0, 100.0)];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.image = [UIImage imageNamed:@"drinks"];

        _imageView.layer.mask = self.maskLayer;
    }
    
    return _imageView;
}

- (CALayer *)maskLayer
{
    if(!_maskLayer) {
        _maskLayer = [CALayer layer];
        _maskLayer.frame = CGRectMake(69.0, 0.0, 50.0, 0.0);
        _maskLayer.contentsRect = CGRectMake(0.0, 0.0, 1.0, 0.0);
        UIImage *maskImage = [UIImage imageNamed:@"personal"];
        _maskLayer.contents = (__bridge id)maskImage.CGImage;
    }
    
    return _maskLayer;
}

@end
