//
//  SpecialLayer1ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/3.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "SpecialLayer1ViewController.h"

#import <CoreText/CoreText.h>
#import "LayerLabel.h"

@interface SpecialLayer1ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) LayerLabel *layerLabel;

@end

@implementation SpecialLayer1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];

    // 小人
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;

    [self.containerView.layer addSublayer:shapeLayer];
    
    // 既有圆角也有直角的矩形
    CGRect rect = CGRectMake(10, 10, 80, 60);
    CGSize radii = CGSizeMake(10, 10);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor blueColor].CGColor;
    shapeLayer.path = path.CGPath;
    [self.containerView.layer addSublayer:shapeLayer];
    
    [self.view addSubview:self.labelView];
    
    // 文字图层
//    CATextLayer *textLayer = [CATextLayer layer];
//    textLayer.frame = self.labelView.bounds;
//    textLayer.contentsScale = [UIScreen mainScreen].scale;
//    [self.labelView.layer addSublayer:textLayer];
//    
//    textLayer.foregroundColor = [UIColor blackColor].CGColor;
//    textLayer.alignmentMode = kCAAlignmentJustified;
//    textLayer.wrapped = YES;
//
//    UIFont *font = [UIFont systemFontOfSize:15];
//    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
//    textLayer.font = fontRef;
//    textLayer.fontSize = font.pointSize;
//    CGFontRelease(fontRef);
//    
//    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque.";
//    textLayer.string = text;
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.labelView.layer addSublayer:textLayer];

    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque.";
    
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];

    UIFont *font = [UIFont systemFontOfSize:15];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    CFRelease(fontRef);

    textLayer.string = string;
    
    [self.view addSubview:self.layerLabel];
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 0.0, 300.0, 300.0)];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _containerView;
}

- (UIView *)labelView
{
    if(!_labelView) {
        _labelView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 310.0, 300.0, 100.0)];
        _labelView.backgroundColor = [UIColor brownColor];
    }
    
    return _labelView;
}

- (LayerLabel *)layerLabel
{
    if(!_layerLabel) {
        _layerLabel = [[LayerLabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300.0) / 2, 420.0, 300.0, 60.0)];

        _layerLabel.font = [UIFont systemFontOfSize:12.0];
        _layerLabel.textColor = [UIColor redColor];
        _layerLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ";
    }
    
    return _layerLabel;
}

@end
