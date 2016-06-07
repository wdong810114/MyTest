//
//  SpecialLayer2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/6.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "SpecialLayer2ViewController.h"

#import "ReflectionView.h"

@interface SpecialLayer2ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *containerView1;
@property (nonatomic, strong) UIView *containerView2;

@end

@implementation SpecialLayer2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];

    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -80, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.containerView.layer addSublayer:cube1];
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 80, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cube2];
    
    [self.view addSubview:self.containerView1];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView1.bounds;
    [self.containerView1.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    [self.view addSubview:self.containerView2];
    
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView2.bounds;
    [self.containerView2.layer addSublayer:replicator];
    
    replicator.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 50, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -50, 0);
    replicator.instanceTransform = transform;
    
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0.0, 0.0, 50.0, 50.0);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
    ReflectionView *reflectionView = [[ReflectionView alloc] initWithFrame:CGRectMake(10.0, 160.0, 120.0, 90.0)];
    reflectionView.dynamic = NO;
    reflectionView.reflectionScale = 1.0;
    reflectionView.reflectionAlpha = 1.0;
    reflectionView.reflectionGap = 5.0;
    UIImageView *forestImageView = [[UIImageView alloc] initWithFrame:reflectionView.bounds];
    forestImageView.image = [UIImage imageNamed:@"forest.jpg"];
    [reflectionView addSubview:forestImageView];
    [self.view addSubview:reflectionView];
}

- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;

    face.transform = transform;
    
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    CATransformLayer *cube = [CATransformLayer layer];

    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);

    cube.transform = transform;
    
    return cube;
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0) / 2, 50.0, 100.0, 100.0)];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    
    return _containerView;
}

- (UIView *)containerView1
{
    if(!_containerView1) {
        _containerView1 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0) / 2, 200.0, 100.0, 100.0)];
        _containerView1.backgroundColor = [UIColor orangeColor];
    }
    
    return _containerView1;
}

- (UIView *)containerView2
{
    if(!_containerView2) {
        _containerView2 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50.0) / 2, 350.0, 50.0, 50.0)];
        _containerView2.backgroundColor = [UIColor yellowColor];
    }
    
    return _containerView2;
}

@end
