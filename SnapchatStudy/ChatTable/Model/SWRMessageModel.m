//
//  SWRMessageModel.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageModel.h"

@implementation SWRMessageModel

- (instancetype)initWithUser:(PFUser *)fromUser textMessage:(NSString *)text senderType:(SWRMessageSenderType)senderType
{
    if (self = [super init]){
        self.fromUser = fromUser;
        self.text = text;
        self.senderType = senderType;
    }
    return self;
}



- (void)saveMessageModel
{
    PFObject *newMessage = [PFObject objectWithClassName:@"message"];
    [newMessage setObject:self.text forKey:@"text"];
    [newMessage setObject:self.fromUser.username forKey:@"fromUsername"];
    [newMessage setObject:self.fromUser.objectId forKey:@"senderId"];
    [newMessage saveInBackground];
}



@end
