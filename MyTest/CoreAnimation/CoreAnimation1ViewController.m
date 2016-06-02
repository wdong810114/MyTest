//
//  CoreAnimation1ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/5/23.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation1ViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface CoreAnimation1ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation CoreAnimation1ViewController
- (void)dealloc
{
    self.blueLayer.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.layerView];
    
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0, 50.0, 100.0, 100.0);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    blueLayer.cornerRadius = 10.0;
    blueLayer.borderWidth = 5.0;
    blueLayer.shadowOpacity = 1.0;
    self.blueLayer = blueLayer;
    [self.layerView.layer addSublayer:blueLayer];
    
    [blueLayer display];
    
//    CALayer *greenLayer = [CALayer layer];
//    greenLayer.frame = CGRectMake(80.0, 60.0, 100.0, 100.0);
//    greenLayer.backgroundColor = [UIColor greenColor].CGColor;
//    greenLayer.contentsScale = [UIScreen mainScreen].scale;
//    greenLayer.zPosition = -1.0;
//    [self.layerView.layer addSublayer:greenLayer];
    
    CGRect rect = [self.layerView.layer convertRect:blueLayer.frame toLayer:self.view.layer];
    NSLog(@"rect: %@", NSStringFromCGRect(rect));
    rect = [self.view.layer convertRect:blueLayer.frame fromLayer:self.layerView.layer];
    NSLog(@"rect: %@", NSStringFromCGRect(rect));
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
//    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
//    if([self.layerView.layer containsPoint:point]) {
//        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
//        if([self.blueLayer containsPoint:point]) {
//            NSLog(@"Inside Blue Layer");
//        } else {
//            NSLog(@"Inside White Layer");
//        }
//    }

    CALayer *layer = [self.layerView.layer hitTest:point];
    if(layer == self.blueLayer) {
        NSLog(@"Inside Blue Layer");
    } else if (layer == self.layerView.layer) {
        NSLog(@"Inside White Layer");
    }
}

- (UIView *)layerView
{
    if(!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0) / 2, 80.0, 200.0, 200.0)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _layerView;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 10.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end