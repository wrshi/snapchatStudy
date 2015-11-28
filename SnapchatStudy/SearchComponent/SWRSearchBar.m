//
//  SWRSearchBar.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-27.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRSearchBar.h"

@implementation SWRSearchBar

- (instancetype)initWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)textColor
{
    if (self = [super initWithFrame:frame]){
        self.frame = frame;
        self.preferredFont = font;
        self.preferredTextColor = textColor;
        self.searchBarStyle = UISearchBarStyleProminent;
        self.translucent = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (void)drawRect:(CGRect)rect {
    int index = [self indexOfSearchFieldInSubviews];
    UIView *searchBarView = self.subviews[0];
    UITextField *searchField = searchBarView.subviews[index];
    searchField.frame = CGRectMake(10.0, 6.0, self.frame.size.width, self.frame.size.height);
    searchField.font = self.preferredFont;
    searchField.backgroundColor = self.barTintColor;
    searchField.textColor = self.preferredTextColor;
    searchField.textAlignment = NSTextAlignmentLeft;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 18)];
    iconView.image = [UIImage imageNamed:@"friend_tab_bar_search_normal"];
    searchField.leftView = iconView;
    
    [super drawRect:rect];
    
}

- (int)indexOfSearchFieldInSubviews
{
    UIView *searchBarView = self.subviews[0];
    for (int i = 0; i < searchBarView.subviews.count; i++){
        if ([searchBarView.subviews[i] isKindOfClass:[UITextField class]]){
            return i;
        }
    }
    return 0;
}

@end
