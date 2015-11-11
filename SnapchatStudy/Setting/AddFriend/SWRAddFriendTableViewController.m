//
//  SWRAddFriendTableViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-10.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRAddFriendTableViewController.h"
#import <Parse/Parse.h>

@interface SWRAddFriendTableViewController ()

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) PFUser *currentUser;

@end

static NSString * const cellReuseIdentifier = @"addFriendCell";

@implementation SWRAddFriendTableViewController

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

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    self.currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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
    self.navigationItem.title = @"Add Friend";
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_black"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PFUser *user = self.allUsers[indexPath.row];
    cell.textLabel.text = user.username;
    
    PFQuery *query = [[[PFUser currentUser] relationForKey:@"FriendsRelation"] query];
    [query whereKey:@"objectId" equalTo:user.objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] > 0){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"FriendsRelation"];
    PFUser *user = self.allUsers[indexPath.row];
    [friendsRelation addObject:user];
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



@end
