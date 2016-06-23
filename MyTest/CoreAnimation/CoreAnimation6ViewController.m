//
//  CoreAnimation6ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/21.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation6ViewController.h"

#import "DrawingView.h"
#import "DrawingView1.h"

@interface CoreAnimation6ViewController ()

//@property (nonatomic, strong) DrawingView *drawingView;
@property (nonatomic, strong) DrawingView1 *drawingView;

@end

@implementation CoreAnimation6ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.drawingView];
}

- (DrawingView1 *)drawingView
{
    if(!_drawingView) {
        _drawingView = [[DrawingView1 alloc] initWithFrame:CGRectMake(10.0, 10.0, SCREEN_WIDTH - 10.0 * 2, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - 10.0 * 2)];
        _drawingView.backgroundColor = [UIColor whiteColor];
    }
    
    return _drawingView;
}

@end
