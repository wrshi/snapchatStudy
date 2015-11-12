//
//  SWRMessageFrame.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageFrame.h"


@implementation SWRMessageFrame


- (void)setMessageModel:(SWRMessageModel *)messageModel
{
    _messageModel = messageModel;
    
    NSString *username = messageModel.from.username;
    UIFont *usernameFont = [UIFont systemFontOfSize:12.0f];
    CGFloat fromX = 0;
    CGFloat fromY = 0;
    CGSize fromMaxSize = CGSizeMake(screenW, MAXFLOAT);
    CGSize fromRealSize = [username boundingRectWithSize:fromMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:usernameFont} context:nil].size;
    _fromFrame = (CGRect){{fromX, fromY}, fromRealSize};
    
    UIFont *textFont = [UIFont systemFontOfSize:15.0f];
    CGFloat textX = 10;
    CGFloat textY = CGRectGetMaxY(_fromFrame);
    CGSize textMaxSize = CGSizeMake(screenW, MAXFLOAT);
    CGSize textRealSize = [username boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    _textFrame = (CGRect){{textX, textY}, textRealSize};
    
    CGFloat rimLineX = 5;
    CGFloat rimLineY = textY;
    CGFloat rimLineW = 2;
    CGFloat rimLineH = textRealSize.height;
    _rimLineFrame = CGRectMake(rimLineX, rimLineY, rimLineW, rimLineH);
    
    _cellHeight = CGRectGetMaxY(_textFrame);
    
}

@end
