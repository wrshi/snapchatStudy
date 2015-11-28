//
//  SWRConversationViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRConversationViewController.h"
#import "SWRConversationViewController.h"
#import "SWRManageViewController.h"
#import "SWRConversationModel.h"
#import "SWRConversationTableViewCell.h"
#import "SWRChatViewController.h"
#import "SWRMessageTableViewController.h"
#import "SWRMyFriendViewController.h"
#import "SWRRefreshControl.h"

@interface SWRConversationViewController ()  <UIGestureRecognizerDelegate, SWRMyFriendViewControllerDelegate, SWRChatViewControllerDelegate, SWRConversationTableViewCellProtocol, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *conversations;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) SWRChatViewController *chatViewController;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) SWRRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL isRefreshAnimating;

@end

@implementation SWRConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundImage];
    
    [self addRightSwipeGestureRecognizer];
    
    [self addLeftSwipeGestureRecognizer];
    
    [self setupRefeshControl];
    
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

- (void)setupRefeshControl
{
    [self.tableView addSubview:self.refreshControl];
    
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)animateRefresh
{
    if (self.tableView.contentOffset.y < -74){
        self.refreshControl.showImage = YES;
    }
    self.isRefreshAnimating = YES;
    static int index = 0;
    [UIView animateWithDuration:0.7 animations:^{
        self.refreshControl.backgroundColor = self.refreshControl.backgroundColors[index];
        index = (index + 1) % self.refreshControl.backgroundColors.count;
    } completion:^(BOOL finished) {
        if (self.tableView.contentOffset.y < -64){
            [self animateRefresh];
        }
        else{
            self.isRefreshAnimating = NO;
        }
    }];
    
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [self getCurrentConversation];
    [self.refreshControl endRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavigationBar];
    [self getCurrentConversation];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.background.y = scrollView.contentOffset.y;
    [self.view bringSubviewToFront:self.background];
    
    if (self.tableView.contentOffset.y < -64 && !self.isRefreshAnimating){
        [self animateRefresh];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.refreshControl.showImage = NO;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conversationCell" forIndexPath:indexPath];
    cell.conversation = self.conversations[indexPath.row];
    cell.delegate = self;
    cell.userInteractionEnabled = NO;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - UIGestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - SWRMyFriendTableViewController delegate

- (void)SWRMyFriendViewController:(SWRMyFriendViewController *)myFriendViewController didSelectUser:(PFUser *)user
{
    self.chatViewController.friendUser = user;
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:self.chatViewController animated:YES];
}

#pragma mark - SWRChatViewController delegate

- (void)SWRChatViewController:(SWRChatViewController *)chatViewController didFinishChatWithFriend:(PFUser *)friendUser
{
    [self getCurrentConversation];
}

#pragma mark - SWRConversationTableViewCell delegate

- (void)cellfinishedAnimationAtIndexPath:(NSIndexPath *)indexPath
{
    SWRConversationModel *conversationModel = self.conversations[indexPath.row];
    self.chatViewController.friendUser = conversationModel.friendUser;
    self.chatViewController.delegate = self;
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:self.chatViewController animated:NO];
}

#pragma mark - lazy load


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

- (SWRRefreshControl *)refreshControl
{
    if (_refreshControl == nil){
        _refreshControl = [SWRRefreshControl SWRRefreshControl];
    }
    return _refreshControl;
}

#pragma mark - private methods

- (void)addLeftSwipeGestureRecognizer
{
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    leftRecognizer.delegate = self;
    [self.view addGestureRecognizer:leftRecognizer];
    [self.view setUserInteractionEnabled:YES];
    
}

- (void)addRightSwipeGestureRecognizer
{
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    rightRecognizer.delegate = self;
    [self.view addGestureRecognizer:rightRecognizer];
    [self.view setUserInteractionEnabled:YES];
    
}

- (void)swipeHandle:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        [self leftSwipeHandle:gestureRecognizer];
    }
    if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
        [self rightSwipeHandle:gestureRecognizer];
    }
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self performSegueWithIdentifier:@"conversation2Manage" sender:nil];
    
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer *)gestureRecognizer
{
    CGPoint currentPoint = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentPoint];
    SWRConversationTableViewCell *cell = (SWRConversationTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];

    [cell cellAnimationWhenSwiped:gestureRecognizer indexPath:indexPath];
    
}

- (void)setNavigationBar
{
    // hide the existing nav bar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIButton *findFriendButton = [[UIButton alloc] init];
    [findFriendButton setImage:[UIImage imageNamed:@"profile_mycontacts_icon"] forState:UIControlStateNormal];
    findFriendButton.bounds = CGRectMake(0, 0, 40, 40);
    [findFriendButton addTarget:self action:@selector(clickFindFriendButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:findFriendButton];
    
    UIButton *cameraButton = [[UIButton alloc] init];
    [cameraButton setImage:[UIImage imageNamed:@"SC_All_BackToCamera_Button"] forState:UIControlStateNormal];
    cameraButton.bounds = CGRectMake(0, 0, 40, 40);
    [cameraButton addTarget:self action:@selector(clickCameraButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    [UINavigationBar customizedBarWithViewController:self backgroundColor:tintGreenColor textColor:[UIColor whiteColor] title:@"snapchat" leftButton:leftButtonItem rightButton:rightButtonItem];
    
}


- (void)setBackgroundImage
{
    self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"send_still"]];
    [self.tableView addSubview:self.background];
}

- (void)clickFindFriendButton
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRMyFriendViewController *myfriendViewController = [storyboard instantiateViewControllerWithIdentifier:@"SWRMyFriendViewController"];
    myfriendViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:myfriendViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navController animated:YES completion:NULL];
}

- (void)clickCameraButton
{
    
}


- (void)getCurrentConversation
{
    [self.conversations removeAllObjects];
    NSArray *currentConversations = [NSMutableArray array];
    
    PFQuery *conversationQuery = [PFQuery queryWithClassName:@"Conversation"];
    [conversationQuery includeKey:@"toUser"];
    [conversationQuery includeKey:@"fromUser"];
    [conversationQuery whereKey:@"toUserId" equalTo:self.currentUser.objectId];
    currentConversations = [conversationQuery findObjects];
    for (PFObject *conversation in currentConversations)
    {
        SWRConversationModel *conversationModel = [SWRConversationModel SWRConversationModelWithUser:conversation[@"fromUser"] unread:YES];
        [self.conversations addObject:conversationModel];
        
    }
    
    PFQuery *conversationQuery2 = [PFQuery queryWithClassName:@"Conversation"];
    [conversationQuery2 includeKey:@"toUser"];
    [conversationQuery2 includeKey:@"fromUser"];
    [conversationQuery2 whereKey:@"fromUserId" equalTo:self.currentUser.objectId];
    currentConversations = [conversationQuery2 findObjects];
    for (PFObject *conversation in currentConversations)
    {
        SWRConversationModel *conversationModel = [SWRConversationModel SWRConversationModelWithUser:conversation[@"toUser"] unread:NO];
        [self.conversations addObject:conversationModel];
    }
    [self.tableView reloadData];
    
}

@end
