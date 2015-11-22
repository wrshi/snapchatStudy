//
//  SWRConversationModel.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRConversationModel.h"

@implementation SWRConversationModel

- (instancetype)initWithUser:(PFUser *)friendUser unread:(BOOL)unread
{
    if (self = [super init]){
        self.friendUser = friendUser;
        self.unread = unread;
    }
    return self;
}

+ (instancetype)SWRConversationModelWithUser:(PFUser *)friendUser unread:(BOOL)unread
{
    return [[self alloc] initWithUser:friendUser unread:unread];
}


@end
