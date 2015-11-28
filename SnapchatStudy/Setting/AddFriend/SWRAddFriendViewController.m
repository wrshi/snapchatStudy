//
//  SWRAddFriendViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRAddFriendViewController.h"
#import "SWRAddFriendTableViewCell.h"
#import "SWRSearchController.h"

@interface SWRAddFriendViewController () <UITableViewDataSource, UITableViewDelegate, SWRSearchControllerDelegate>

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) NSMutableArray *alphabetsArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *friendsId;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) SWRSearchController *customSearchController;
@property (nonatomic, assign) BOOL shouldShowSearchResults;
@property (nonatomic, strong) NSArray *filteredArray;

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

- (SWRSearchController *)customSearchController
{
    if (_customSearchController == nil){
        _customSearchController = [[SWRSearchController alloc] initWithSearchResultsController:self searchBarFrame:CGRectMake(0, 0, screenW, 44.0) searchBarFont:[UIFont systemFontOfSize:15.0] searchBarTextColor:[UIColor blackColor] searchBarTintColor:[UIColor whiteColor]];
        _customSearchController.customSearchBar.placeholder = @"搜索";
        _customSearchController.delegate = self;
        
    }
    return _customSearchController;
}

- (NSArray *)filteredArray
{
    if (_filteredArray == nil){
        _filteredArray = [NSArray array];
    }
    return _filteredArray;
}


#pragma mark - private methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    self.tableView.tableHeaderView = self.customSearchController.customSearchBar;
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.customSearchController terminateSearch];
    self.shouldShowSearchResults = NO;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.shouldShowSearchResults){
        return self.filteredArray.count;
    }
    else{
        return self.allUsers.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRAddFriendTableViewCell *cell = [SWRAddFriendTableViewCell SWRAddFriendCellWithTableView:tableView];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PFUser *user = nil;
    if (self.shouldShowSearchResults){
        user = self.filteredArray[indexPath.row];
        
    }
    else{
        user = self.allUsers[indexPath.row];
    }
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
    
    PFUser *user = nil;
    if (self.shouldShowSearchResults){
        user = self.filteredArray[indexPath.row];
        
    }
    else{
        user = self.allUsers[indexPath.row];
    }
    
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


#pragma mark - SWRSearchController delegate

- (void)didStartSearching
{
    self.shouldShowSearchResults = YES;
    [self.tableView reloadData];
}

- (void)didTapOnSearchButton
{
    if (!self.shouldShowSearchResults){
        self.shouldShowSearchResults = YES;
        [self.tableView reloadData];
    }
}

- (void)didTapOnCancelButton
{
    self.shouldShowSearchResults = NO;
    [self.tableView reloadData];
}

- (void)didChangeSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.username BEGINSWITH [CD] %@", searchText];
    self.filteredArray = [self.allUsers filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
    
}

#pragma mark - private methods

@end
