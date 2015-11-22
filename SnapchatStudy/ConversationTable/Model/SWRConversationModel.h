//
//  SWRConversationModel.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWRConversationModel : NSObject

@property (nonatomic, strong) PFUser *friendUser;
@property (nonatomic, assign, getter=isUnread) BOOL unread;

- (instancetype)initWithUser:(PFUser *)friendUser unread:(BOOL)unread;
+ (instancetype)SWRConversationModelWithUser:(PFUser *)friendUser unread:(BOOL)unread;

@end
