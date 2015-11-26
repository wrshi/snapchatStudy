//
//  SWRMyFriendViewController.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWRMyFriendViewController;

@protocol SWRMyFriendViewControllerDelegate <NSObject>

@optional
- (void)SWRMyFriendViewController:(SWRMyFriendViewController *)myFriendTableViewController didSelectUser:(PFUser *)user;

@end

@interface SWRMyFriendViewController : UIViewController

@property (nonatomic, weak) id<SWRMyFriendViewControllerDelegate> delegate;

@end
