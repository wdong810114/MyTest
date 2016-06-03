//
//  CoreAnimation5ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/2.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation5ViewController.h"

#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface CoreAnimation5ViewController ()

@property (nonatomic, strong) UIView *containerView1;
@property (nonatomic, strong) UIView *layerView1;
@property (nonatomic, strong) UIView *layerView2;

@property (nonatomic, strong) UIView *containerView2;
@property (nonatomic, strong) NSMutableArray *faces;

@end

@implementation CoreAnimation5ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.faces = [NSMutableArray arrayWithCapacity:6];

    [self.view addSubview:self.containerView1];
    
    CATransform3D perspective1 = CATransform3DIdentity;
    perspective1.m34 = -1.0 / 80.0;
    self.containerView1.layer.sublayerTransform = perspective1;
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView1.layer.transform = transform1;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI, 0, 1, 0);
    self.layerView2.layer.transform = transform2;
    
    [self.view addSubview:self.containerView2];
    CATransform3D perspective2 = CATransform3DIdentity;
    perspective2.m34 = -1.0 / 500.0;
    perspective2 = CATransform3DRotate(perspective2, -M_PI_4, 1, 0, 0);
    perspective2 = CATransform3DRotate(perspective2, -M_PI_4, 0, 1, 0);
    self.containerView2.layer.sublayerTransform = perspective2;
    CATransform3D transform = CATransform3DMakeTranslation(0.0, 0.0, 50.0);
    [self addFace:0 withTransform:transform];
    transform = CATransform3DMakeTranslation(50.0, 0.0, 0.0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    transform = CATransform3DMakeTranslation(0.0, -50.0, 0.0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    transform = CATransform3DMakeTranslation(0.0, 50.0, 0.0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    transform = CATransform3DMakeTranslation(-50.0, 0.0, 0.0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    transform = CATransform3DMakeTranslation(0.0, 0.0, -50.0);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    UIView *face = [self faceWithIndex:index];
    [self.containerView2 addSubview:face];
    CGSize containerSize = self.containerView2.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
//    [self applyLightingToFace:face.layer];
}

- (UIView *)faceWithIndex:(NSInteger)index
{
    UIView *face = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
    face.backgroundColor = [UIColor whiteColor];
    
    if(index == 2) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(face.bounds) - 40.0) / 2, (CGRectGetHeight(face.bounds) - 40.0) / 2, 40.0, 40.0)];
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.cornerRadius = 8.0;
        button.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitle:@"3" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(threeClicked) forControlEvents:UIControlEventTouchUpInside];
        [face addSubview:button];
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(face.bounds) - 40.0) / 2, (CGRectGetHeight(face.bounds) - 40.0) / 2, 40.0, 40.0)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20.0];
        label.textAlignment = NSTextAlignmentCenter;
        switch(index) {
            case 0:
                label.textColor = [UIColor redColor];
                break;
            case 1:
                label.textColor = [UIColor greenColor];
                break;
            case 3:
                label.textColor = [UIColor brownColor];
                break;
            case 4:
                label.textColor = [UIColor orangeColor];
                break;
            case 5:
                label.textColor = [UIColor cyanColor];
                break;
                
            default:
                break;
        }
        label.text = [NSString stringWithFormat:@"%i", (int)(index + 1)];
        [face addSubview:label];
        face.userInteractionEnabled = NO;
    }
    
    [self.faces addObject:face];
    
    return face;
}

//- (void)applyLightingToFace:(CALayer *)face
//{
//    CALayer *layer = [CALayer layer];
//    layer.frame = face.bounds;
//    [face addSublayer:layer];
//    CATransform3D transform = face.transform;
//    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
//    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
//    GLKVector3 normal = GLKVector3Make(0, 0, 1);
//    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
//    normal = GLKVector3Normalize(normal);
//    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
//    float dotProduct = GLKVector3DotProduct(light, normal);
//    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
//    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
//    layer.backgroundColor = color.CGColor;
//}

- (void)threeClicked
{
    NSLog(@"You clicked 3.");
}

- (UIView *)containerView1
{
    if(!_containerView1) {
        _containerView1 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 180.0) / 2, 50.0, 180.0, 120.0)];
        _containerView1.backgroundColor = [UIColor whiteColor];
        
        [_containerView1 addSubview:self.layerView1];
        [_containerView1 addSubview:self.layerView2];
    }
    
    return _containerView1;
}

- (UIView *)layerView1
{
    if(!_layerView1) {
        _layerView1 = [[UIView alloc] initWithFrame:CGRectMake(20.0, 30.0, 60.0, 60.0)];
        _layerView1.backgroundColor = [UIColor clearColor];
        _layerView1.layer.contentsGravity = kCAGravityResizeAspect;
        _layerView1.layer.contentsScale = [UIScreen mainScreen].scale;
        _layerView1.layer.masksToBounds = YES;
        UIImage *image = [UIImage imageNamed:@"drinks"];
        _layerView1.layer.contents = (__bridge id)image.CGImage;
    }
    
    return _layerView1;
}

- (UIView *)layerView2
{
    if(!_layerView2) {
        _layerView2 = [[UIView alloc] initWithFrame:CGRectMake(100.0, 30.0, 60.0, 60.0)];
        _layerView2.backgroundColor = [UIColor clearColor];
        _layerView2.layer.contentsGravity = kCAGravityResizeAspect;
        _layerView2.layer.contentsScale = [UIScreen mainScreen].scale;
        _layerView2.layer.masksToBounds = YES;
        UIImage *image = [UIImage imageNamed:@"drinks"];
        _layerView2.layer.contents = (__bridge id)image.CGImage;
        _layerView2.layer.doubleSided = NO;
    }
    
    return _layerView2;
}

- (UIView *)containerView2
{
    if(!_containerView2) {
        _containerView2 = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 250.0) / 2, 220.0, 250.0, 250.0)];
        _containerView2.backgroundColor = [UIColor redColor];
    }
    
    return _containerView2;
}

@end
