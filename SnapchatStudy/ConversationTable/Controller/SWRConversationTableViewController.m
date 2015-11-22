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
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) SWRChatViewController *chatViewController;
@property (nonatomic, strong) NSMutableDictionary *conversationDict;

@end


@implementation SWRConversationTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self setBackgroundImage];
    
    [self addRightSwipeGestureRecognizer];
    
    [self.tableView registerClass:[SWRConversationTableViewCell class] forCellReuseIdentifier:@"conversationCell"];
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
    }
    else {
        // show the signup or login screen
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"登录不成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    self.chatViewController.messageController.chatMessageArray = self.conversationDict[conversationModel.friendUser.objectId];
    [self.navigationController pushViewController:self.chatViewController animated:YES];
}

#pragma mark - SWRMyFriendTableViewController delegate

- (void)SWRMyFriendTableViewController:(SWRMyFriendTableViewController *)myFriendTableViewController didSelectUser:(PFUser *)user
{
    MyLog(@"%@", user.username);
}

#pragma mark - private methods

- (NSMutableArray *)conversations
{
    if (_conversations == nil){
        _conversations = [NSMutableArray array];
        
        PFQuery *conversationQuery = [PFQuery queryWithClassName:@"message"];
        NSArray *messageArray = [conversationQuery findObjects];
        [self classifyMessages:messageArray];
        
    }
    return _conversations;
}

- (NSMutableDictionary *)conversationDict
{
    if (_conversationDict == nil){
        _conversationDict = [NSMutableDictionary dictionary];
    }
    return _conversationDict;
}

- (SWRChatViewController *)chatViewController
{
    if (_chatViewController == nil){
        _chatViewController = [[SWRChatViewController alloc] init];
    }
    return _chatViewController;
}

- (void)classifyMessages:(NSArray *)messageArray
{
    for (PFObject *message in messageArray){
        PFUser *fromUser = message[@"fromUser"];
        PFUser *toUser = message[@"toUser"];
        NSString *fromUsername = fromUser.objectId;
        NSString *toUsername = toUser.objectId;
        NSString *currentUsername = [PFUser currentUser].objectId;
        if ([fromUsername isEqualToString:currentUsername]){
            if ([self.conversationDict objectForKey:toUsername] == nil){
                SWRConversationModel *conversation = [[SWRConversationModel alloc] init];
                conversation.friendUser = toUser;
                conversation.unread = NO;
                [_conversations addObject:conversation];
                
                NSMutableArray *newChat = [NSMutableArray array];
                [self.conversationDict setObject:newChat forKey:toUsername];
            }
            NSMutableArray *chat = [self.conversationDict objectForKey:toUsername];
            [chat addObject:message];
            
        }
        else if ([toUsername isEqualToString:currentUsername]){
            if ([self.conversationDict objectForKey:fromUsername] == nil){
                SWRConversationModel *conversation = [[SWRConversationModel alloc] init];
                conversation.friendUser = fromUser;
                conversation.unread = YES;
                [_conversations addObject:conversation];
                
                NSMutableArray *newChat = [NSMutableArray array];
                [self.conversationDict setObject:newChat forKey:fromUsername];
            }
            NSMutableArray *chat = [self.conversationDict objectForKey:fromUsername];
            [chat addObject:message];
        }
    }
}

@end











