//
//  SWRConversationTableViewCell.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRConversationTableViewCell.h"


@interface SWRConversationTableViewCell ()

@property (nonatomic, strong) UIImageView *unreadSymbol;
@property (nonatomic, strong) UILabel *friendNameLabel;

@end


@implementation SWRConversationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.unreadSymbol = [[UIImageView alloc] init];
        self.unreadSymbol.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:self.unreadSymbol];
        
        self.friendNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.friendNameLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = 60;
    
    CGFloat unreadSymbolX = 0;
    CGFloat unreadSymbolY = 0;
    CGFloat unreadSymbolWH = self.frame.size.height;
    self.unreadSymbol.frame = CGRectMake(unreadSymbolX, unreadSymbolY, unreadSymbolWH, unreadSymbolWH);
    
    CGFloat friendNameLabelX = CGRectGetMaxX(self.unreadSymbol.frame);
    CGFloat friendNameLabelY = 0;
    CGFloat friendNameLabelW = self.frame.size.width - unreadSymbolWH;
    CGFloat friendNameLabelH = unreadSymbolWH;
    self.friendNameLabel.frame = CGRectMake(friendNameLabelX, friendNameLabelY, friendNameLabelW, friendNameLabelH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{

}

- (void)setConversation:(SWRConversationModel *)conversation
{
    _conversation = conversation;
    self.friendNameLabel.text = conversation.friendName;
    if (conversation.isUnread){
        self.unreadSymbol.image = [UIImage imageNamed:@"open_box_purple"];
    }
    else{
        self.unreadSymbol.image = [UIImage imageNamed:@"loading_00015"];
    }
}



@end
