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

@end

@implementation SWRChatViewController

- (SWRMessageTableViewController *)messageController
{
    if (_messageController == nil){
        _messageController = [[SWRMessageTableViewController alloc] init];
       
        _messageController.view.y = statusbarH + navigationbarH;
        _messageController.delegate = self;
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


- (void)setUser:(PFUser *)user
{
    _user = user;
    self.navigationItem.title = user.username;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.messageController.view];
    [self.view addSubview:self.inputBoxController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.inputBoxController.view.transform = CGAffineTransformMakeTranslation(0, frame.origin.y - screenH);
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
    [message.messageModel saveMessageModel];
}

@end
