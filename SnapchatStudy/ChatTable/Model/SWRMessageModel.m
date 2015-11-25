//
//  SWRMessageModel.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageModel.h"

@implementation SWRMessageModel

- (instancetype)initWithUser:(PFUser *)fromUser textMessage:(NSString *)text
{
    if (self = [super init]){
        self.fromUser = fromUser;
        self.text = text;
    }
    return self;
}

+ (instancetype)initWithPFObject:(PFObject *)message
{
    return [[self alloc] initWithUser:message[@"fromUser"] textMessage:message[@"text"]];
}


- (PFObject *)saveMessageModel
{
    PFObject *newMessage = [PFObject objectWithClassName:@"message"];
    [newMessage setObject:self.text forKey:@"text"];
    [newMessage setObject:self.fromUser forKey:@"fromUser"];
    [newMessage setObject:self.toUser forKey:@"toUser"];
    [newMessage setObject:self.fromUser.objectId forKey:@"fromUserId"];
    [newMessage setObject:self.toUser.objectId forKey:@"toUserId"];
    [newMessage setObject:@"yes" forKey:@"unread"];
    [newMessage saveInBackground];
    return newMessage;
}



@end
