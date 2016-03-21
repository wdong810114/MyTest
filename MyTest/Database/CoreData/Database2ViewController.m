//
//  Database2ViewController.m
//  MyTest
//
//  Created by wangdongdong on 16/3/18.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "Database2ViewController.h"

#import "UserDAO.h"

@interface Database2ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView   *tableView;

@end

@implementation Database2ViewController
{
    UserDAO *_userDAO;
    NSArray *_users;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        _userDAO = [[UserDAO alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self addUsers];
    
    _users = [_userDAO findAll];
    [self.view addSubview:self.tableView];
}

- (void)addUsers
{
    [_userDAO addUserWithName:@"Binger" screenName:@"冰儿" profileImageUrl:@"binger.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [_userDAO addUserWithName:@"Xiaona" screenName:@"小娜" profileImageUrl:@"xiaona.jpg" mbtype:@"mbtype.png" city:@"北京"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *UserCellIdentifier = @"UserCellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:UserCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    User *user = _users[indexPath.row];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = user.city;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter
- (UITableView *)tableView
{
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

@end
