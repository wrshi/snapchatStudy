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

- (void)addNewMessage:(SWRMessageFrame *)message
{
    [self.messages addObject:message];
    [self.tableView reloadData];
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

#pragma mark - get fake data

- (NSMutableArray *)messages
{
    if (_messages == nil){
        _messages = [NSMutableArray array];
        
        SWRMessageModel *model1 = [[SWRMessageModel alloc] initWithUser:@"Lu Yi" textMessage:@"Hello, you are so beautiful! May I have dinner with you tonight?" senderType:SWRMessageSenderTypeFriend];
        SWRMessageFrame *message1 = [[SWRMessageFrame alloc] init];
        message1.messageModel = model1;
        [_messages addObject:message1];
        
        SWRMessageModel *model2 = [[SWRMessageModel alloc] initWithUser:@"Me" textMessage:@"Sure. See you. " senderType:SWRMessageSenderTypeSelf];
        SWRMessageFrame *message2 = [[SWRMessageFrame alloc] init];
        message2.messageModel = model2;
        [_messages addObject:message2];
        
    }
    return _messages;
}

@end
