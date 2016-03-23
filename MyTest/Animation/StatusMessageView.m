//
//  StatusMessageView.m
//  MyTest
//
//  Created by wangdongdong on 16/3/23.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "StatusMessageView.h"

@implementation StatusMessageView

+ (instancetype)messageViewWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    StatusMessageView *statusMessageView  = [[StatusMessageView alloc] initWithFrame:STATUS_BAR_FRAME];
    statusMessageView.backgroundColor     = backgroundColor;
    
    UILabel *messagelabel           = [[UILabel alloc] initWithFrame:statusMessageView.bounds];
    messagelabel.backgroundColor    = [UIColor clearColor];
    messagelabel.textAlignment      = NSTextAlignmentCenter;
    messagelabel.font               = [UIFont systemFontOfSize:10.0];
    messagelabel.textColor          = [UIColor darkGrayColor];
    messagelabel.text               = title;
    [statusMessageView addSubview:messagelabel];
    
    return statusMessageView;
}

- (void)showWithDuration:(NSTimeInterval)seconds
{
    self.alpha = 0.0;
    
    [UIView animateWithDuration:seconds
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)hideWithDuration:(NSTimeInterval)seconds
{
    [UIView animateWithDuration:seconds
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         self.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
