//
//  SWRMessageTableViewController.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWRMessageTableViewController;
@class SWRMessageFrame;

@protocol SWRMessageTableViewControllerDelegate <NSObject>

@optional
- (void)SWRMessageTableViewConrtroller:(SWRMessageTableViewController *)messageTableViewController didTappedOnView:(UIView *)tappedView;

@end

@interface SWRMessageTableViewController : UITableViewController

@property (nonatomic, weak) id<SWRMessageTableViewControllerDelegate> delegate;

- (void)addNewMessage:(SWRMessageFrame *)message;

@end
