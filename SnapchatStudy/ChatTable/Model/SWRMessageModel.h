//
//  SWRMessageModel.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SWRMessageSenderType) {
    SWRMessageSenderTypeSelf,
    SWRMessageSenderTypeFriend
};

@interface SWRMessageModel : NSObject

@property (nonatomic, copy) NSString *text;
//@property (nonatomic, strong) PFUser from;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, assign) SWRMessageSenderType senderType;

- (instancetype)initWithUser:(NSString *)from textMessage:(NSString *)text senderType:(SWRMessageSenderType)senderType;

@end