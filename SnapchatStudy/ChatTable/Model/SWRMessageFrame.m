//
//  SWRMessageFrame.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageFrame.h"


@implementation SWRMessageFrame

const CGFloat leftMargin = 8;
const CGFloat cellPadding = 2;

- (void)setMessageModel:(SWRMessageModel *)messageModel
{
    _messageModel = messageModel;
    
    NSString *username = messageModel.fromUser.objectId;
    UIFont *usernameFont = [UIFont systemFontOfSize:12.0f];
    CGFloat fromX = leftMargin;
    CGFloat fromY = cellPadding;
    CGSize fromMaxSize = CGSizeMake(screenW - leftMargin - cellPadding, MAXFLOAT);
    CGSize fromRealSize = [username boundingRectWithSize:fromMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:usernameFont} context:nil].size;
    _fromFrame = (CGRect){{fromX, fromY}, fromRealSize};
    
    UIFont *textFont = [UIFont systemFontOfSize:15.0f];
    CGFloat textX = leftMargin + leftMargin;
    CGFloat textY = CGRectGetMaxY(_fromFrame) + cellPadding;
    CGSize textMaxSize = CGSizeMake(screenW - 2 * leftMargin - cellPadding, MAXFLOAT);
    CGSize textRealSize = [messageModel.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    _textFrame = (CGRect){{textX, textY}, textRealSize};
    
    CGFloat rimLineX = leftMargin;
    CGFloat rimLineY = textY + cellPadding;
    CGFloat rimLineW = 1;
    CGFloat rimLineH = textRealSize.height;
    _rimLineFrame = CGRectMake(rimLineX, rimLineY, rimLineW, rimLineH);
    
    _cellHeight = CGRectGetMaxY(_textFrame) + cellPadding;
    
}

@end
