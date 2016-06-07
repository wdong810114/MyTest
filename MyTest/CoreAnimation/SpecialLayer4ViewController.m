//
//  SpecialLayer4ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/7.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "SpecialLayer4ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface SpecialLayer4ViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation SpecialLayer4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.containerView];
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"movie" withExtension:@"mp4"];
    
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playerLayer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;

    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0;
    
    [player play];
}

- (UIView *)containerView
{
    if(!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0) / 2, 50.0, 200.0, 200.0)];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    
    return _containerView;
}

@end
