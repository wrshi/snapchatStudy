//
//  SWRInputBoxController.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWRInputBoxController;
@class SWRMessageFrame;

@protocol SWRInputBoxControllerDelegate <NSObject>

@optional
- (void)SWRInputBoxController:(SWRInputBoxController *)inputBoxController sendMessage:(SWRMessageFrame *)message;

@end

@interface SWRInputBoxController : UIViewController

@property (nonatomic, weak) id<SWRInputBoxControllerDelegate> delegate;


@end
