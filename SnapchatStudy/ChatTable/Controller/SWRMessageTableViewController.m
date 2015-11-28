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

#pragma mark - public methods

- (void)addNewMessage:(SWRMessageFrame *)message
{
    [self.messages addObject:message];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SWRMessageCell class] forCellReuseIdentifier:messageCellIdentifier];
    
    [self setTapGesture];
}


#pragma mark - TableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


#pragma mark - TableView delegate

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

- (void)setMessageObjs:(NSMutableArray *)messageObjs
{
    [self.messages removeAllObjects];
    NSString *currentUserId = [PFUser currentUser].objectId;
    for (PFObject *messageObj in messageObjs){
        PFUser *fromUser = messageObj[@"fromUser"];
        PFUser *toUser = messageObj[@"toUser"];
        SWRMessageModel *messageModel = [SWRMessageModel initWithPFObject:messageObj];
        if ([fromUser.objectId isEqualToString:currentUserId]){
            messageModel.senderType = SWRMessageSenderTypeSelf;
        }
        else if ([toUser.objectId isEqualToString:currentUserId]){
            messageModel.senderType = SWRMessageSenderTypeFriend;
        }
        SWRMessageFrame *message = [[SWRMessageFrame alloc] init];
        message.messageModel = messageModel;
        [self.messages addObject:message];
    }
    [self.tableView reloadData];
}

- (void)setTapGesture
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnView)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)tappedOnView
{
    if ([self.delegate respondsToSelector:@selector(SWRMessageTableViewConrtroller:didTappedOnView:)]){
        [self.delegate SWRMessageTableViewConrtroller:self didTappedOnView:self.view];
    }
}

- (NSMutableArray *)messages
{
    if (_messages == nil){
        _messages = [NSMutableArray array];
    }
    return _messages;
}

@end
