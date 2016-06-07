//
//  ScrollView.m
//  MyTest
//
//  Created by wangdongdong on 16/6/6.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (void)setUp
{
    self.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])) {
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setUp];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint offset = self.bounds.origin;
    NSLog(@"offset: %f, %f", offset.x, offset.y);
    NSLog(@"translationInView: %f, %f", [recognizer translationInView:self].x, [recognizer translationInView:self].y);
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    [recognizer setTranslation:CGPointZero inView:self];
}

@end
