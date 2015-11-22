//
//  SWRMyFriendTableViewController.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-10.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWRMyFriendTableViewController;

@protocol SWRMyFriendTableViewControllerDelegate <NSObject>

@optional
- (void)SWRMyFriendTableViewController:(SWRMyFriendTableViewController *)myFriendTableViewController didSelectUser:(PFUser *)user;

@end

@interface SWRMyFriendTableViewController : UITableViewController

@property (nonatomic, weak) id<SWRMyFriendTableViewControllerDelegate> delegate;

@end
