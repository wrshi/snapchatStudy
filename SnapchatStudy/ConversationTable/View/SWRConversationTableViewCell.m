//
//  SWRConversationTableViewCell.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRConversationTableViewCell.h"


@interface SWRConversationTableViewCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *unreadSymbol;
@property (nonatomic, strong) UILabel *friendNameLabel;
@property (nonatomic, strong) UIButton *backgroundButton;


@property (nonatomic, assign) CGPoint swipeStartPoint;

@end


@implementation SWRConversationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundButton = [[UIButton alloc] init];
        self.backgroundButton.backgroundColor = tintBlueColor;
        [self.backgroundButton setImage:[UIImage imageNamed:@"chat-icon"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.backgroundButton];
        
        self.topView = [[UIView alloc] init];
        self.topView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topView];
        
        self.unreadSymbol = [[UIImageView alloc] init];
        self.unreadSymbol.contentMode = UIViewContentModeCenter;
        [self.topView addSubview:self.unreadSymbol];
        
        self.friendNameLabel = [[UILabel alloc] init];
        [self.topView addSubview:self.friendNameLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = 60;
    
    self.backgroundButton.frame = CGRectMake(0, 0, self.height, self.height);
    
    self.topView.frame = CGRectMake(0, 0, self.width, self.height);
    
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
    self.friendNameLabel.text = conversation.friendUser.username;
    if (conversation.isUnread){
        self.unreadSymbol.image = [UIImage imageNamed:@"loading_00015"];
    }
    else{
        self.unreadSymbol.image = [UIImage imageNamed:@"open_box_purple"];
    }
}

- (void)cellAnimationWhenSwiped:(UISwipeGestureRecognizer *)recognizer indexPath:(NSIndexPath *)indexPath
{

    if (recognizer.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            self.topView.x = self.height;
        } completion:^(BOOL finished) {
            if ([self.delegate respondsToSelector:@selector(cellfinishedAnimationAtIndexPath:)]){
                [self.delegate cellfinishedAnimationAtIndexPath:indexPath];
            }
        }];
        
    }
    
}





@end
