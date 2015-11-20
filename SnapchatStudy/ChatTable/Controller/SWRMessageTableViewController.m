//
//  SWRMessageTableViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageTableViewController.h"
#import "SWRMessageCell.h"
#import "SWRMessageModel.h"

@interface SWRMessageTableViewController ()

@property (nonatomic, strong) NSMutableArray *messages;

@end

static NSString *const messageCellIdentifier = @"messageCell";

@implementation SWRMessageTableViewController

@synthesize chatMessageArray = _chatMessageArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SWRMessageCell class] forCellReuseIdentifier:messageCellIdentifier];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnView)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedOnView
{
    if ([self.delegate respondsToSelector:@selector(SWRMessageTableViewConrtroller:didTappedOnView:)]){
        [self.delegate SWRMessageTableViewConrtroller:self didTappedOnView:self.view];
    }
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellIdentifier forIndexPath:indexPath];
    
    cell.messageFrame = self.messages[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRMessageFrame *message = self.messages[indexPath.row];
    return message.cellHeight;
}

#pragma mark - private methods


- (NSMutableArray *)chatMessageArray
{
    if (_chatMessageArray == nil){
        _chatMessageArray = [NSMutableArray array];
    }
    return _chatMessageArray;
}

- (NSMutableArray *)messages
{
    if (_messages == nil){
        _messages = [NSMutableArray array];
    }
    return _messages;
}

- (void)setChatMessageArray:(NSMutableArray *)chatMessageArray
{
    _chatMessageArray = chatMessageArray;
    [self getCurrentMessages:chatMessageArray];
}

- (void)getCurrentMessages:(NSMutableArray *)chatMessageArray
{
    [self.messages removeAllObjects];
    for (PFObject *message in chatMessageArray){
        PFUser *fromUser = message[@"fromUser"];
        NSString *fromUsername = fromUser.objectId;
        NSString *currentUsername = [PFUser currentUser].objectId;
        SWRMessageModel *messageModel = [SWRMessageModel initWithPFObject:message];
        if ([fromUsername isEqualToString:currentUsername]){
            messageModel.senderType = SWRMessageSenderTypeSelf;
        }
        else{
            messageModel.senderType = SWRMessageSenderTypeFriend;
        }
        SWRMessageFrame *messageFrame = [[SWRMessageFrame alloc] init];
        messageFrame.messageModel = messageModel;
        [self.messages addObject:messageFrame];
        [self.tableView reloadData];
    }
}

#pragma mark - public methods

- (void)addNewMessage:(SWRMessageFrame *)message
{
    [self.messages addObject:message];
    [self.tableView reloadData];
}


@end
