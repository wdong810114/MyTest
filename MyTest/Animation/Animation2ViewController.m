//
//  Animation2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/3/22.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "Animation2ViewController.h"

@interface Animation2ViewController ()

@end

@implementation Animation2ViewController

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
    button.frame = CGRectMake(10.0, 10.0, SCREEN_WIDTH - 10.0 * 2, 40.0);
    [button setTitle:@"改变" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeUIView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.backgroundColor = [UIColor whiteColor];
    button1.frame = CGRectMake(10.0, 60.0, SCREEN_WIDTH - 10.0 * 2, 40.0);
    [button1 setTitle:@"改变" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeUIView1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)changeUIView
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (void)changeUIView1
{
    [UIView beginAnimations:@"animation1" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSLog(@"动画结束");
}

@end
