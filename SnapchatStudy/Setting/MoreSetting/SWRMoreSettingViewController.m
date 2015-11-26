//
//  SWRMoreSettingViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMoreSettingViewController.h"
#import "SWRMoreSettingCell.h"
#import "SWRMoreSettingHeaderView.h"

@interface SWRMoreSettingViewController () <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *allTitles;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SWRMoreSettingViewController

#pragma mark - lazy load

- (NSMutableArray *)allTitles
{
    if (_allTitles == nil){
        _allTitles = [NSMutableArray array];
        
        NSMutableDictionary *accountOperation = [NSMutableDictionary dictionary];
        NSArray *titles = @[@"黑名单", @"登出"];
        [accountOperation setValue:titles forKey:@"titles"];
        [accountOperation setValue:@"账户操作" forKey:@"header"];
        
        [_allTitles addObject:accountOperation];
    }
    return _allTitles;
}

#pragma mark - private methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBar];
}

- (void)logout
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"是否登出？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"登出" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

- (void)setNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_black"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [UINavigationBar customizedBarWithViewController:self backgroundColor:[UIColor whiteColor] textColor:tintGreenColor title:@"设置" leftButton:leftButtonItem rightButton:nil];

}

- (void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = self.allTitles[section];
    NSArray *titles = dictionary[@"titles"];
    return titles.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyLog(@"------");
    SWRMoreSettingHeaderView *headerView = [SWRMoreSettingHeaderView moreSettingHeaderView];
    NSDictionary *dictionary = self.allTitles[section];
    headerView.headerTitle = dictionary[@"header"];
    
    MyLog(@"%@", headerView);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRMoreSettingCell *cell = [SWRMoreSettingCell SWRMoreSettingCellWithTableView:tableView];
    
    NSDictionary *dictionary = self.allTitles[indexPath.section];
    NSArray *titles = dictionary[@"titles"];
    cell.title = titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SWRMoreSettingCell *cellSelected = (SWRMoreSettingCell *)[self.tableView cellForRowAtIndexPath:indexPath];

    if ([cellSelected.title isEqualToString:@"登出"]) {
        [self logout];
    }
    
}

#pragma mark - ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
