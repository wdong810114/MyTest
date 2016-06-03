//
//  CoreAnimationViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/6/3.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView   *tableView;

@end

@implementation CoreAnimationViewController
{
    NSArray *_viewControllers;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        _viewControllers = @[@{@"title" : @"CoreAnimation1", @"class" : @"CoreAnimation1ViewController"},
                             @{@"title" : @"CoreAnimation2", @"class" : @"CoreAnimation2ViewController"},
                             @{@"title" : @"CoreAnimation3", @"class" : @"CoreAnimation3ViewController"},
                             @{@"title" : @"CoreAnimation4", @"class" : @"CoreAnimation4ViewController"},
                             @{@"title" : @"CoreAnimation5", @"class" : @"CoreAnimation5ViewController"}];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewControllers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    cell.textLabel.text = _viewControllers[indexPath.row][@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = _viewControllers[indexPath.row][@"class"];
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    viewController.title = _viewControllers[indexPath.row][@"title"];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Getter
- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

@end