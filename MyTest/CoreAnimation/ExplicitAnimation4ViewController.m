//
//  ExplicitAnimation4ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/8.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "ExplicitAnimation4ViewController.h"

@interface ExplicitAnimation4ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIButton *changeButton;

@end

@implementation ExplicitAnimation4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.images = @[[UIImage imageNamed:@"shouye"],
                    [UIImage imageNamed:@"dating"],
                    [UIImage imageNamed:@"qushi"],
                    [UIImage imageNamed:@"jinhuodan"],
                    [UIImage imageNamed:@"geren"]];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.changeButton];
}

- (void)switchImage
{
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionFade;
//    [self.imageView.layer addAnimation:transition forKey:nil];
//
//    UIImage *currentImage = self.imageView.image;
//    NSUInteger index = [self.images indexOfObject:currentImage];
//    index = (index + 1) % [self.images count];
//    self.imageView.image = self.images[index];
    
//    [UIView transitionWithView:self.imageView
//                      duration:1.0
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
//                        UIImage *currentImage = self.imageView.image;
//                        NSUInteger index = [self.images indexOfObject:currentImage];
//                        index = (index + 1) % [self.images count];
//                        self.imageView.image = self.images[index];
//                    }
//                    completion:NULL];
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}

- (UIImageView *)imageView
{
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 50.0) / 2, 25.0, 50.0, 50.0)];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = self.images[0];
    }
    
    return _imageView;
}

- (UIButton *)changeButton
{
    if(!_changeButton) {
        _changeButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0) / 2, 100.0, 100.0, 30.0)];
        _changeButton.backgroundColor = [UIColor clearColor];
        _changeButton.layer.borderWidth = 0.5;
        _changeButton.layer.borderColor = [UIColor blackColor].CGColor;
        _changeButton.layer.cornerRadius = 3.0;
        _changeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_changeButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_changeButton setTitle:@"Switch Image" forState:UIControlStateNormal];
        [_changeButton addTarget:self action:@selector(switchImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _changeButton;
}


@end
