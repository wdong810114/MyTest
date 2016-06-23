//
//  DrawingView1.m
//  MyTest
//
//  Created by wangdongdong on 16/6/21.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "DrawingView1.h"

#define OPTIMIZATION
#define BRUSH_SIZE 27

@interface DrawingView1 ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation DrawingView1

- (instancetype)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])) {
        self.strokes = [NSMutableArray array];
    }
    
    return self;
}

- (void)awakeFromNib
{
    self.strokes = [NSMutableArray array];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self addBrushStrokeAtPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self addBrushStrokeAtPoint:point];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point
{
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
#ifdef OPTIMIZATION
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
#else
    [self setNeedsDisplay];
#endif
}

#ifdef OPTIMIZATION
- (CGRect)brushRectForPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}
#endif

- (void)drawRect:(CGRect)rect
{
    for(NSValue *value in self.strokes) {
        CGPoint point = [value CGPointValue];
#ifdef OPTIMIZATION
        CGRect brushRect = [self brushRectForPoint:point];
        if(CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"brush"] drawInRect:brushRect];
        }
#else
        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
        [[UIImage imageNamed:@"brush"] drawInRect:brushRect];
#endif
    }
}

@end
