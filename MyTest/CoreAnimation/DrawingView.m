//
//  DrawingView.m
//  MyTest
//
//  Created by wangdongdong on 16/6/21.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DrawingView.h"

#define OPTIMIZATION

@interface DrawingView ()

@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation DrawingView

#ifdef OPTIMIZATION
+ (Class)layerClass
{
    return [CAShapeLayer class];
}
#endif

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])) {
        self.path = [[UIBezierPath alloc] init];
        
#ifdef OPTIMIZATION
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 5;
#else
        self.path.lineJoinStyle = kCGLineJoinRound;
        self.path.lineCapStyle = kCGLineCapRound;
        self.path.lineWidth = 5;
#endif
    }
    
    return self;
}

- (void)awakeFromNib
{
    self.path = [[UIBezierPath alloc] init];
    
#ifdef OPTIMIZATION
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
#else
    self.path.lineJoinStyle = kCGLineJoinRound;
    self.path.lineCapStyle = kCGLineCapRound;
    self.path.lineWidth = 5;
#endif
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];

    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.path addLineToPoint:point];
    
#ifdef OPTIMIZATION
    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
#else
    [self setNeedsDisplay];
#endif
}

#ifndef OPTIMIZATION
- (void)drawRect:(CGRect)rect
{
    [[UIColor clearColor] setFill];
    [[UIColor redColor] setStroke];
    [self.path stroke];
}
#endif

@end
