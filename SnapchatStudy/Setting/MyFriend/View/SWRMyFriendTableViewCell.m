//
//  SWRMyFriendTableViewCell.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMyFriendTableViewCell.h"

@implementation SWRMyFriendTableViewCell

+ (instancetype)SWRMyFriendCellWithTableView:(UITableView *)tableView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SWRMyFriendTableViewCell" owner:nil options:nil] firstObject];
}

- (void)setFriendUser:(PFUser *)friendUser
{
    _friendUser = friendUser;
    self.textLabel.text = friendUser.username;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
