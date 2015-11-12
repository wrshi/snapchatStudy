//
//  SWRChatViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRChatViewController.h"
#import "SWRMessageTableViewController.h"

@interface SWRChatViewController ()

@property (nonatomic, strong) SWRMessageTableViewController *messageController;

@end

@implementation SWRChatViewController

- (SWRMessageTableViewController *)messageController
{
    if (_messageController == nil){
        _messageController = [[SWRMessageTableViewController alloc] init];
        _messageController.view.y = 66;
    }
    return _messageController;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
