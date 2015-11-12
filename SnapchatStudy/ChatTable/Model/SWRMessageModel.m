//
//  SWRMessageModel.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageModel.h"

@implementation SWRMessageModel

- (instancetype)initWithUser:(PFUser *)from textMessage:(NSString *)text senderType:(SWRMessageSenderType)senderType
{
    if (self = [super init]){
        self.from = from;
        self.text = text;
        self.senderType = senderType;
    }
    return self;
}



@end
