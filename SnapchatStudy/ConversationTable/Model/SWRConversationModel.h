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

@end
