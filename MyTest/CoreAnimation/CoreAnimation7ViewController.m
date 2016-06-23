//
//  CoreAnimation7ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/23.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation7ViewController.h"

#define WIDTH 100
#define HEIGHT 100
#define DEPTH 10
#define SIZE 100
#define SPACING 150
#define CAMERA_DISTANCE 500
#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)

@interface CoreAnimation7ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableSet *recyclePool;

@end

@implementation CoreAnimation7ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.recyclePool = [NSMutableSet set];
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    [self.view addSubview:self.scrollView];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform;
}

- (void)viewDidLayoutSubviews
{
    [self updateLayers];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateLayers];
}

- (void)updateLayers
{
    CGRect bounds = self.scrollView.bounds;
    bounds.origin = self.scrollView.contentOffset;
    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
    
    [self.recyclePool addObjectsFromArray:self.scrollView.layer.sublayers];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    int recycled = 0;
    NSMutableArray *visibleLayers = [NSMutableArray array];
    for(int z = DEPTH - 1; z >= 0; z--) {
        CGRect adjusted = bounds;
        adjusted.size.width /= PERSPECTIVE(z*SPACING);
        adjusted.size.height /= PERSPECTIVE(z*SPACING);
        adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2;
        adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2;
        for(int y = 0; y < HEIGHT; y++) {
            if(y*SPACING < adjusted.origin.y || y*SPACING >= adjusted.origin.y + adjusted.size.height) {
                continue;
            }
            
            for(int x = 0; x < WIDTH; x++) {
                if(x*SPACING < adjusted.origin.x ||x*SPACING >= adjusted.origin.x + adjusted.size.width) {
                    continue;
                }
                
                CALayer *layer = [self.recyclePool anyObject];
                if(layer) {
                    recycled++;
                    [self.recyclePool removeObject:layer];
                } else {
                    layer = [CALayer layer];
                    layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                }
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING;
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                [visibleLayers addObject:layer];
            }
        }
    }
    
    [CATransaction commit];
    
    self.scrollView.layer.sublayers = visibleLayers;

    NSLog(@"displayed: %i/%i recycled: %i", (int)[visibleLayers count], DEPTH*HEIGHT*WIDTH, recycled);
}

- (UIScrollView *)scrollView
{
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

@end
