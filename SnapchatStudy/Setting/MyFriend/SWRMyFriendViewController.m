//
//  SWRMyFriendViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMyFriendViewController.h"
#import "SWRMyFriendTableViewCell.h"

@interface SWRMyFriendViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *myFriends;

@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic, strong) NSMutableArray *nameArray;

@end

static NSString * const cellReuseIdentifier = @"MyFriendCell";

@implementation SWRMyFriendViewController

#pragma mark - lazy load

- (NSArray *)myFriends
{
    if (_myFriends == nil){
        _myFriends = [NSArray array];
    }
    return _myFriends;
}

- (NSMutableArray *)nameArray
{
    if (_nameArray == nil){
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

- (NSMutableArray *)alphabetsArray
{
    if (_alphabetsArray == nil){
        _alphabetsArray = [NSMutableArray array];
    }
    return _alphabetsArray;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    self.friendsRelation = [[PFUser currentUser] objectForKey:@"FriendsRelation"];
    PFQuery *query = [self.friendsRelation query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            self.myFriends = objects;
            self.nameArray = [self.myFriends valueForKeyPath:@"username"];
            [self createAlphabetArray];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            MyLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)setNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_purple"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [UINavigationBar customizedBarWithViewController:self backgroundColor:[UIColor whiteColor] textColor:tintPurpleColor title:@"我的好友" leftButton:leftButtonItem rightButton:nil];
}

- (void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createAlphabetArray {
    NSMutableArray *tempFirstLetterArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.nameArray count]; i++) {
        NSString *letterString = [[self.nameArray objectAtIndex:i] substringToIndex:1];
        if (![tempFirstLetterArray containsObject:letterString]) {
            [tempFirstLetterArray addObject:letterString];
        }
    }
    self.alphabetsArray = tempFirstLetterArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myFriends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    SWRMyFriendTableViewCell *cell = [SWRMyFriendTableViewCell SWRMyFriendCellWithTableView:tableView];
    
    PFUser *user = self.myFriends[indexPath.row];
    cell.friendUser = user;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *user = self.myFriends[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(SWRMyFriendViewController:didSelectUser:)]){
            [self.delegate SWRMyFriendViewController:self didSelectUser:user];
        }
    }];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.alphabetsArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    for (int i = 0; i < [self.nameArray count]; i++) {
        // return the name and match the title for first letter of name
        // and move to that row corresponding to that indexpath as below
        NSString *letterString = [[self.nameArray objectAtIndex:i] substringToIndex:1];
        if ([letterString isEqualToString:title]) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
    return 0;
}

@end
