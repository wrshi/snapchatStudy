//
//  SWRMessageCell.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMessageCell.h"
#import "SWRMessageModel.h"

@interface SWRMessageCell ()

@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *messageTextLabel;
@property (nonatomic, strong) UIView *rimLine;

@end

@implementation SWRMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.fromLabel];
        [self.contentView addSubview:self.messageTextLabel];
        [self.contentView addSubview:self.rimLine];
    }
    return self;
}

- (void)setMessageFrame:(SWRMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    SWRMessageModel *messageModel = messageFrame.messageModel;
    
    self.fromLabel.frame = messageFrame.fromFrame;
    self.fromLabel.text = messageModel.fromUser.username;

    self.messageTextLabel.frame = messageFrame.textFrame;
    self.messageTextLabel.text = messageModel.text;
    
    self.rimLine.frame = messageFrame.rimLineFrame;
    if (messageModel.senderType == SWRMessageSenderTypeSelf){
        self.rimLine.backgroundColor = tintRedColor;
        self.fromLabel.textColor = tintRedColor;
    }
    else if (messageModel.senderType == SWRMessageSenderTypeFriend){
        self.rimLine.backgroundColor = tintBlueColor;
        self.fromLabel.textColor = tintBlueColor;
    }
}

- (UILabel *)fromLabel
{
    if (_fromLabel == nil){
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.textAlignment = NSTextAlignmentLeft;
        _fromLabel.numberOfLines = 0;
        _fromLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _fromLabel;
}

- (UILabel *)messageTextLabel
{
    if (_messageTextLabel == nil){
        _messageTextLabel = [[UILabel alloc] init];
        _messageTextLabel.textAlignment = NSTextAlignmentLeft;
        _messageTextLabel.numberOfLines = 0;
        _messageTextLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return _messageTextLabel;
}

- (UIView *)rimLine
{
    if (_rimLine == nil){
        _rimLine = [[UIView alloc] init];
    }
    return _rimLine;
}

@end
