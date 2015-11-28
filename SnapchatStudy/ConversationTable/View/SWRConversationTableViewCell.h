//
//  SWRConversationTableViewCell.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRConversationModel.h"

@class SWRConversationTableViewCell;

@protocol SWRConversationTableViewCellProtocol <NSObject>

@optional
- (void)cellfinishedAnimationAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SWRConversationTableViewCell : UITableViewCell

@property (nonatomic, strong) SWRConversationModel *conversation;
@property (nonatomic, weak) id<SWRConversationTableViewCellProtocol> delegate;
@property (nonatomic, strong) UIView *topView;

- (void)cellAnimationWhenSwiped:(UISwipeGestureRecognizer *)recognizer indexPath:(NSIndexPath *)indexPath;


@end
