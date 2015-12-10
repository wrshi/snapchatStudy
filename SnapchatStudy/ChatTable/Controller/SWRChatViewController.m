//
//  SWRChatViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRChatViewController.h"
#import "SWRMessageTableViewController.h"
#import "SWRInputBoxController.h"
#import "SWRMessageModel.h"
#import "SWRMessageFrame.h"

@interface SWRChatViewController () <SWRMessageTableViewControllerDelegate, SWRInputBoxControllerDelegate>

@property (nonatomic, strong) SWRMessageTableViewController *messageController;
@property (nonatomic, strong) SWRInputBoxController *inputBoxController;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSTimer *timer;

@end


static const NSTimeInterval secondBeforeDelete = 10.0;

@implementation SWRChatViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.messageController.view];
    [self.view addSubview:self.inputBoxController.view];
    
    self.currentUser = [PFUser currentUser];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBar];
    [self getCurrentMessages];
    [self deleteCurrentConversation];
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.delegate respondsToSelector:@selector(SWRChatViewController:didFinishChatWithFriend:)]){
        [self.delegate SWRChatViewController:self didFinishChatWithFriend:self.friendUser];
    }
    [self.timer invalidate];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark - SWRMessageTableViewController delegate

- (void)SWRMessageTableViewConrtroller:(SWRMessageTableViewController *)messageTableViewController didTappedOnView:(UIView *)tappedView
{
    [self.inputBoxController resignFirstResponder];
}


#pragma mark - SWRInputBoxController delegate

- (void)SWRInputBoxController:(SWRInputBoxController *)inputBoxController sendMessage:(SWRMessageFrame *)message
{
    [self.messageController addNewMessage:message];
    message.messageModel.toUser = self.friendUser;
    [message.messageModel saveMessageModel];
    
    PFQuery *conversationQuery = [PFQuery queryWithClassName:@"Conversation"];
    [conversationQuery whereKey:@"toUserId" equalTo:self.friendUser.objectId];
    [conversationQuery whereKey:@"fromUserId" equalTo:self.currentUser.objectId];
    [conversationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 0){
                PFObject *conversation = [PFObject objectWithClassName:@"Conversation"];
                conversation[@"toUserId"] = self.friendUser.objectId;
                conversation[@"fromUserId"] = self.currentUser.objectId;
                conversation[@"toUser"] = self.friendUser;
                conversation[@"fromUser"] = self.currentUser;
                [conversation saveInBackground];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


#pragma mark - private methods

#pragma mark set exterior

- (void)setNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_blue_flipped"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [UINavigationBar customizedBarWithViewController:self backgroundColor:[UIColor whiteColor] textColor:tintBlueColor title:self.friendUser.username leftButton:nil rightButton:rightButtonItem];
}

- (void)clickBackButton
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.inputBoxController.view.transform = CGAffineTransformMakeTranslation(0, frame.origin.y - screenH);
}

#pragma mark update data

- (void)getCurrentMessages
{
    [self.messages removeAllObjects];
    PFQuery *messageQuery = [PFQuery queryWithClassName:@"message"];
    [messageQuery includeKey:@"toUser"];
    [messageQuery includeKey:@"fromUser"];
    [messageQuery addAscendingOrder:@"createdAt"];
    [messageQuery whereKey:@"toUserId" equalTo:self.currentUser.objectId];
    [messageQuery whereKey:@"fromUserId" equalTo:self.friendUser.objectId];
    
    PFQuery *messageQuery2 = [PFQuery queryWithClassName:@"message"];
    [messageQuery2 includeKey:@"toUser"];
    [messageQuery2 includeKey:@"fromUser"];
    [messageQuery2 whereKey:@"toUserId" equalTo:self.friendUser.objectId];
    [messageQuery2 whereKey:@"fromUserId" equalTo:self.currentUser.objectId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *currentMessages = [messageQuery findObjects];
        [self.messages addObjectsFromArray:currentMessages];
        for (PFObject *message in currentMessages){
            message[@"unread"] = @"no";
            [message saveInBackground];
        }
        currentMessages = [messageQuery2 findObjects];
        [self.messages addObjectsFromArray:currentMessages];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.messageController.messageObjs = self.messages;
        });
    });

}
    

- (void)deleteCurrentConversation
{
    PFQuery *conversationQuery = [PFQuery queryWithClassName:@"Conversation"];
    [conversationQuery whereKey:@"toUserId" equalTo:self.currentUser.objectId];
    [conversationQuery whereKey:@"fromUserId" equalTo:self.friendUser.objectId];
    [conversationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects){
                [object deleteInBackground];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (void)deleteMessge
{
    PFQuery *messageQuery = [PFQuery queryWithClassName:@"message"];
    [messageQuery whereKey:@"toUserId" equalTo:self.currentUser.objectId];
    [messageQuery whereKey:@"fromUserId" equalTo:self.friendUser.objectId];
    [messageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects){
                if ([object[@"unread"] isEqualToString:@"no"]){
                    [object deleteInBackground];
                }
            }
            [self getCurrentMessages];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

#pragma mark set timer

- (void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:secondBeforeDelete target:self selector:@selector(deleteMessge) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


#pragma mark - lazy load

- (SWRMessageTableViewController *)messageController
{
    if (_messageController == nil){
        _messageController = [[SWRMessageTableViewController alloc] init];
        
        _messageController.view.y = statusbarH + navigationbarH;
        _messageController.delegate = self;
        _messageController.friendUser = self.friendUser;
    }
    return _messageController;
}

- (SWRInputBoxController *)inputBoxController
{
    if (_inputBoxController == nil){
        _inputBoxController = [[SWRInputBoxController alloc] init];
        _inputBoxController.view.y = screenH - _inputBoxController.view.height;
        _inputBoxController.delegate = self;
    }
    return _inputBoxController;
}

- (NSMutableArray *)messages
{
    if (_messages == nil){
        _messages = [NSMutableArray array];
    }
    return _messages;
}

- (void)setFriendUser:(PFUser *)friendUser
{
    _friendUser = friendUser;
    self.navigationItem.title = friendUser.objectId;
}

@end
