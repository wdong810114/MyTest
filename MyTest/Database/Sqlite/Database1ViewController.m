//
//  Database1ViewController.m
//  Test001
//
//  Created by wangdongdong on 16/3/17.
//  Copyright © 2016年 Spark. All rights reserved.
//

#import "Database1ViewController.h"

#import "DDDatabaseCreator.h"
#import "DDUserService.h"
#import "DDStatusService.h"

@interface Database1ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView   *tableView;

@end

@implementation Database1ViewController
{
    NSArray *_statuses;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DDDatabaseCreator initDatabase];
    
    [self addUsers];
//    [self removeUser];
//    [self modifyUserInfo];
    
    [self addStatus];
    
    _statuses = [[DDStatusService sharedDDStatusService] getAllStatus];
    [self.view addSubview:self.tableView];
}

- (void)addUsers
{
    DDUser *user1 = [DDUser userWithName:@"Binger" screenName:@"冰儿" profileImageUrl:@"binger.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[DDUserService sharedDDUserService] addUser:user1];
    DDUser *user2 = [DDUser userWithName:@"Xiaona" screenName:@"小娜" profileImageUrl:@"xiaona.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[DDUserService sharedDDUserService] addUser:user2];
    DDUser *user3 = [DDUser userWithName:@"Lily" screenName:@"丽丽" profileImageUrl:@"lily.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[DDUserService sharedDDUserService] addUser:user3];
    DDUser *user4 = [DDUser userWithName:@"Yanyue" screenName:@"炎月" profileImageUrl:@"yanyue.jpg" mbtype:@"mbtype.png" city:@"北京"];
    [[DDUserService sharedDDUserService] addUser:user4];
}

- (void)addStatus
{
    DDStatus *status1 = [DDStatus statusWithCreateAt:@"9:00" source:@"iPhone 6" text:@"一只雪猴在日本边泡温泉边玩iPhone的照片，获得了\"2014年野生动物摄影师\"大赛特等奖。一起来为猴子配个词" userId:1];
    [[DDStatusService sharedDDStatusService] addStatus:status1];
    DDStatus *status2 = [DDStatus statusWithCreateAt:@"9:30" source:@"iPhone 6s" text:@"【我们送iPhone6了 要求很简单】真心回馈粉丝，小编觉得现在最好的奖品就是iPhone6了。今起到12月31日，关注我们，转发微博，就有机会获iPhone6(奖品可能需要等待)！每月抽一台[鼓掌]。不费事，还是试试吧，万一中了呢" userId:2];
    [[DDStatusService sharedDDStatusService] addStatus:status2];
    DDStatus *status3 = [DDStatus statusWithCreateAt:@"9:45" source:@"iPhone 6s" text:@"重大新闻：蒂姆库克宣布出柜后，ISIS战士怒扔iPhone，沙特神职人员呼吁人们换回iPhone 4。[via Pan-Arabia Enquirer]" userId:3];
    [[DDStatusService sharedDDStatusService] addStatus:status3];
    DDStatus *status4 = [DDStatus statusWithCreateAt:@"10:07" source:@"iPhone 6" text:@"在音悦台iPhone客户端里发现一个悦单《Infinite 金明洙》，推荐给大家! " userId:1];
    [[DDStatusService sharedDDStatusService] addStatus:status4];
}

- (void)removeUser
{
    [[DDUserService sharedDDUserService] removeUserByName:@"Yanyue"];
}

- (void)modifyUserInfo
{
    DDUser *user1 = [[DDUserService sharedDDUserService] getUserByName:@"Xiaona"];
    user1.city = @"上海";
    [[DDUserService sharedDDUserService] modifyUser:user1];
    
    DDUser *user2 = [[DDUserService sharedDDUserService] getUserByName:@"Lily"];
    user2.city = @"深圳";
    [[DDUserService sharedDDUserService] modifyUser:user2];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *StatusCellIdentifier = @"StatusCellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:StatusCellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:StatusCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    DDStatus *status = _statuses[indexPath.row];
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    
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
