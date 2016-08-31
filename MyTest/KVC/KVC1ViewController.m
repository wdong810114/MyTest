//
//  KVC1ViewController.m
//  Test001
//
//  Created by wangdongdong on 16/3/17.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "KVC1ViewController.h"

#import "PersonInfoModel.h"

#define _STRING(x) #x
#define STRING(x) _STRING(x)
#define paster(n) printf("token"#n" = %d\n", token##n)

@interface KVC1ViewController ()

@end

@implementation KVC1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Y.X.",  @"name",
                          @"26",    @"age",
                          @"1987",  @"id",
                          @"海淀区", @"address", nil];
    PersonInfoModel *model = [[PersonInfoModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    NSLog(@"%@", model.name);
    NSLog(@"%@", model.age);
    NSLog(@"%@", model.address);
    NSLog(@"%@", model.myID);
    
//    char* pChar = STRING(__FILE__);
//    char* pChar1 = _STRING(__FILE__);
//    printf("%s %s %s\n", pChar, pChar1, __FILE__);
//
//    int token9 = 100;
//    paster(9);
//
//    NSNumber *num = @999;
//    NSLog(@"num: %@", [NSString stringWithFormat:@"%@", num]);
//    NSLog(@"num: %@", num);
    
    NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    [URLs enumerateObjectsUsingBlock:^(NSURL *URL, NSUInteger idx, BOOL *stop) {
        NSLog(@"URL: %@", URL.absoluteString);
    }];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    [view1 setBounds:CGRectMake(-30, -30, 200, 200)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    NSLog(@"view1 frame:%@=========view1 bounds:%@", NSStringFromCGRect(view1.frame), NSStringFromCGRect(view1.bounds));
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view2.backgroundColor = [UIColor yellowColor];
    [view1 addSubview:view2];
    NSLog(@"view2 frame:%@=========view2 bounds:%@", NSStringFromCGRect(view2.frame), NSStringFromCGRect(view2.bounds));
}

@end
