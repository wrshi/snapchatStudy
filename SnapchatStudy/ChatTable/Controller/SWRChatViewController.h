//
//  SWRChatViewController.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWRMessageTableViewController;

@interface SWRChatViewController : UIViewController

@property (nonatomic, strong) PFUser *friendUser;
@property (nonatomic, strong) SWRMessageTableViewController *messageController;


@end
