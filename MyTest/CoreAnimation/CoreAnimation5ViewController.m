//
//  CoreAnimation5ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/2.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimation5ViewController.h"

@interface CoreAnimation5ViewController ()

@property (nonatomic, strong) UIView *layerView;

@end

@implementation CoreAnimation5ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.layerView];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerView.layer.affineTransform = transform;
}

- (UIView *)layerView
{
    if(!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0) / 2, 80.0, 100.0, 100.0)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _layerView;
}

@end
