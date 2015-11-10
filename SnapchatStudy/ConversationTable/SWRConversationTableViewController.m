//
//  SWRConversationTableViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRConversationTableViewController.h"
#import "SWRGreenNavigationBar.h"
#import "SWRManageViewController.h"

@interface SWRConversationTableViewController () <UIGestureRecognizerDelegate>



@end


@implementation SWRConversationTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self addRightSwipeGestureRecognizer];
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        MyLog(@"current user name: %@", currentUser.username);
    } else {
        // show the signup or login screen
    }

}

- (void)addRightSwipeGestureRecognizer
{
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [rightRecognizer setNumberOfTouchesRequired:1];
    rightRecognizer.delegate = self;
    [self.view addGestureRecognizer:rightRecognizer];
    [self.view setUserInteractionEnabled:YES];

}





- (void)rightSwipeHandle:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self performSegueWithIdentifier:@"conversation2Manage" sender:nil];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;
}

- (void)setNavigationBar
{
    self.navigationItem.title = @"snapchat";
    SWRGreenNavigationBar *navBar = [[SWRGreenNavigationBar alloc] init];
    [self.navigationController setValue:navBar forKeyPath:@"navigationBar"];
    
    UIButton *findFriendButton = [[UIButton alloc] init];
    [findFriendButton setImage:[UIImage imageNamed:@"profile_mycontacts_icon"] forState:UIControlStateNormal];
    findFriendButton.bounds = CGRectMake(0, 0, 40, 40);
    [findFriendButton addTarget:self action:@selector(clickFindFriendButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:findFriendButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *addFriendButton = [[UIButton alloc] init];
    [addFriendButton setImage:[UIImage imageNamed:@"Add_Friend_Button"] forState:UIControlStateNormal];
    addFriendButton.bounds = CGRectMake(0, 0, 40, 40);
    [addFriendButton addTarget:self action:@selector(clickAddFriendButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addFriendButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

- (void)clickFindFriendButton
{

}

- (void)clickAddFriendButton
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
