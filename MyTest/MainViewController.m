//
//  MainViewController.m
//  Test001
//
//  Created by wangdongdong on 16/3/17.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView   *tableView;

@end

@implementation MainViewController
{
    NSArray *_viewControllers;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        _viewControllers = @[@{@"title" : @"CAKeyframeAnimation", @"class" : @"Animation1ViewController"},
                             @{@"title" : @"UIViewAnimation", @"class" : @"Animation2ViewController"},
                             @{@"title" : @"CATransitionAnimation", @"class" : @"Animation3ViewController"},
                             @{@"title" : @"SimpleKVC", @"class" : @"KVC1ViewController"},
                             @{@"title" : @"SqliteDatabase", @"class" : @"Database1ViewController"},
                             @{@"title" : @"CoreDataDatabase", @"class" : @"Database2ViewController"},
                             @{@"title" : @"CoreAnimation", @"class" : @"CoreAnimationViewController"},
                             @{@"title" : @"GCD", @"class" : @"GCDViewController"},
                             @{@"title" : @"NSOperation", @"class" : @"OperationViewController"}];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Demo";
    
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
