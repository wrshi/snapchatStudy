//
//  SWRMoreSettingHeaderView.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRMoreSettingHeaderView.h"

@interface SWRMoreSettingHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;


@end

@implementation SWRMoreSettingHeaderView

+ (instancetype)moreSettingHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SWRMoreSettingHeaderView" owner:nil options:nil] firstObject];
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle = headerTitle;
    self.headerLabel.text = headerTitle;
}

@end
