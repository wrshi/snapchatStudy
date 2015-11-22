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
#import "SWRConversationModel.h"
#import "SWRConversationTableViewCell.h"
#import "SWRChatViewController.h"
#import "SWRMessageTableViewController.h"
#import "SWRMyFriendTableViewController.h"

@interface SWRConversationTableViewController () <UIGestureRecognizerDelegate, SWRMyFriendTableViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *conversations;
@property (nonatomic, strong) PFRelation *conversationRelation;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) SWRChatViewController *chatViewController;
@property (nonatomic, strong) PFUser *currentUser;

@end


@implementation SWRConversationTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self setBackgroundImage];
    
    [self addRightSwipeGestureRecognizer];
    
    [self.tableView registerClass:[SWRConversationTableViewCell class] forCellReuseIdentifier:@"conversationCell"];
    
    
    self.currentUser = [PFUser currentUser];
    if (self.currentUser) {
        
    }
    else {
        // show the signup or login screen
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"登录不成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    [self getCurrentConversation];

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
    
    UIButton *cameraButton = [[UIButton alloc] init];
    [cameraButton setImage:[UIImage imageNamed:@"SC_All_BackToCamera_Button"] forState:UIControlStateNormal];
    cameraButton.bounds = CGRectMake(0, 0, 40, 40);
    [cameraButton addTarget:self action:@selector(clickCameraButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}


- (void)setBackgroundImage
{
    self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"send_still"]];
    [self.view addSubview:self.background];
}

- (void)clickFindFriendButton
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRMyFriendTableViewController *myfriendViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRMyFriendTableViewController"];
    myfriendViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:myfriendViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navController animated:YES completion:NULL];

}

- (void)clickCameraButton
{
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.background.y = scrollView.contentOffset.y;
    [self.view bringSubviewToFront:self.background];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversations.count;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conversationCell" forIndexPath:indexPath];
    cell.conversation = self.conversations[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SWRConversationModel *conversationModel = self.conversations[indexPath.row];
    self.chatViewController.friendUser = conversationModel.friendUser;
    self.chatViewController.currentUser = self.currentUser;
    
    [self.navigationController pushViewController:self.chatViewController animated:YES];
}

#pragma mark - SWRMyFriendTableViewController delegate

- (void)SWRMyFriendTableViewController:(SWRMyFriendTableViewController *)myFriendTableViewController didSelectUser:(PFUser *)user
{
    self.chatViewController.friendUser = user;
    [self.navigationController pushViewController:self.chatViewController animated:YES];
}

#pragma mark - private methods

- (NSMutableArray *)conversations
{
    if (_conversations == nil){
        _conversations = [NSMutableArray array];
    }
    return _conversations;
}

- (SWRChatViewController *)chatViewController
{
    if (_chatViewController == nil){
        _chatViewController = [[SWRChatViewController alloc] init];
    }
    return _chatViewController;
}

- (void)getCurrentConversation
{
    self.conversationRelation = [self.currentUser relationForKey:@"conversationRelation"];
    PFQuery *conversationQuery = [self.conversationRelation query];
    NSArray *conversationUsers = [conversationQuery findObjects];
    [self.conversations removeAllObjects];
    for (PFUser *user in conversationUsers){
        SWRConversationModel *conversation = [SWRConversationModel SWRConversationModelWithUser:user unread:NO];
        [self.conversations addObject:conversation];
    }
    
    PFQuery *messageQuery = [PFQuery queryWithClassName:@"message"];
    [messageQuery includeKey:@"toUser"];
    [messageQuery includeKey:@"fromUser"];
    [messageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSArray *conversationIds = [conversationUsers valueForKeyPath:@"objectId"];
            NSString *currentUserId = self.currentUser.objectId;
            for (PFObject *message in objects){
                PFUser *fromUser = message[@"fromUser"];
                PFUser *toUser = message[@"toUser"];
                if ([toUser.objectId isEqualToString:currentUserId]){
                    if (![conversationIds containsObject:fromUser.objectId]){
                        SWRConversationModel *conversation = [SWRConversationModel SWRConversationModelWithUser:fromUser unread:YES];
                        [self.conversations addObject:conversation];
                    }
                }
            }
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

@end











