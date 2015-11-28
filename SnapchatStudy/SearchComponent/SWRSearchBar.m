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
    searchField.frame = CGRectMake(5.0, 5.0, self.frame.size.width - 10.0, self.frame.size.height - 10.0);
    searchField.font = self.preferredFont;
    searchField.backgroundColor = self.barTintColor;
    searchField.textColor = self.preferredTextColor;
    
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