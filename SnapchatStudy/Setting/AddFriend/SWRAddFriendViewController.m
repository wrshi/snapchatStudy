//
//  SWRAddFriendViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRAddFriendViewController.h"
#import "SWRAddFriendTableViewCell.h"

@interface SWRAddFriendViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *friendsId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString * const cellReuseIdentifier = @"addFriendCell";

@implementation SWRAddFriendViewController

#pragma mark - lazy load

- (NSArray *)allUsers
{
    if (_allUsers == nil){
        _allUsers = [NSArray array];
    }
    return _allUsers;
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

- (NSMutableArray *)friendsId
{
    if (_friendsId == nil){
        _friendsId = [NSMutableArray array];
        PFQuery *friendsQuery = [[self.currentUser relationForKey:@"FriendsRelation"] query];
        // use synchronous query.
        // is there a better way??
        NSArray *objects = [friendsQuery findObjects];
        _friendsId = [NSMutableArray arrayWithArray:[objects valueForKeyPath:@"objectId"]];
    }
    return _friendsId;
}


#pragma mark - private methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.currentUser = [PFUser currentUser];
    
    PFQuery *userQuery = [PFUser query];
    [userQuery orderByAscending:@"username"];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            self.allUsers = objects;
            self.nameArray = [self.allUsers valueForKeyPath:@"username"];
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
    
    [UINavigationBar customizedBarWithViewController:self backgroundColor:[UIColor whiteColor] textColor:tintPurpleColor title:@"添加好友" leftButton:leftButtonItem rightButton:nil];

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
    
    return [self.allUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRAddFriendTableViewCell *cell = [SWRAddFriendTableViewCell SWRAddFriendCellWithTableView:tableView];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    PFUser *user = self.allUsers[indexPath.row];
    cell.friendUser = user;
    
    if ([self.friendsId containsObject:user.objectId]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"FriendsRelation"];
    PFUser *user = self.allUsers[indexPath.row];
    if ([self.friendsId containsObject:user.objectId]){
        [friendsRelation removeObject:user];
        [self.friendsId removeObject:user.objectId];
    }
    else{
        [friendsRelation addObject:user];
        [self.friendsId addObject:user.objectId];
    }
    
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (error){
            MyLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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

#pragma mark - private methods

@end
