//
//  Animation3ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/3/23.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "Animation3ViewController.h"

#import "StatusMessageHandle.h"
#import "StatusMessageView.h"

@interface Animation3ViewController ()

@property (nonatomic, strong) UIView *moveView;

@end

@implementation Animation3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT)];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(10.0, 10.0, 60.0, 40.0);
    [button setTitle:@"改变" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeUIView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.moveView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 80.0, 200.0, 40.0)];
    self.moveView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.moveView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.backgroundColor = [UIColor whiteColor];
    button1.frame = CGRectMake(100.0, 10.0, 60.0, 40.0);
    [button1 setTitle:@"移动" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeUIView1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.backgroundColor = [UIColor whiteColor];
    button2.frame = CGRectMake(190.0, 10.0, 60.0, 40.0);
    [button2 setTitle:@"透明度" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeUIView2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    [self performSelector:@selector(showStatusMessage) withObject:nil afterDelay:2.0];
}

- (void)changeUIView
{
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.type = kCATransitionPush;
    // Private
//    transition.type = @"cube";          // 立方体
//    transition.type = @"suckEffect";    // 吸收
//    transition.type = @"oglFlip";       // 翻转
//    transition.type = @"rippleEffect";  // 波纹
//    transition.type = @"pageCurl";      // 翻页
//    transition.type = @"pageUnCurl";    // 反翻页
//    transition.type = @"cameraIrisHollowOpen";  // 镜头开
//    transition.type = @"cameraIrisHollowClose"; // 镜头关
    transition.subtype = kCATransitionFromTop;
//    transition.startProgress = 0.1;
//    transition.endProgress = 0.5;
    [self.view.layer addAnimation:transition forKey:@"animation"];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
}

- (void)changeUIView1
{
    [UIView animateWithDuration:1.5
                     animations:^{
                         self.moveView.frame = CGRectMake(10.0, 270.0, 200.0, 40.0);
                     } completion:^(BOOL finished) {
                         UIView *insertView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 80.0, 200.0, 40.0)];
                         insertView.backgroundColor = [UIColor redColor];
                         [self.view addSubview:insertView];
                     }];
}

- (void)changeUIView2
{
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.moveView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0
                                               delay:1.0
                                             options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
                                                 [UIView setAnimationRepeatCount:2.5];
                                                 self.moveView.alpha = 1.0;
                                             } completion:^(BOOL finished) {
                                             }];
                     }];
}

- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype view:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = type;
    if(subtype) {
        animation.subtype = subtype;
    }
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)showStatusMessage
{
    [StatusMessageHandle showAndHideDuration:2.0];
    [StatusMessageHandle showWithView:[StatusMessageView messageViewWithTitle:@"Hello world!" backgroundColor:[UIColor whiteColor]]
                     hideAfterSeconds:3.0];
}

@end
