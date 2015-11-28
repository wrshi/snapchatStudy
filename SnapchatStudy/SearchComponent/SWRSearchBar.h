//
//  SWRSearchBar.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-27.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWRSearchBar : UISearchBar

@property (nonatomic, strong) UIFont *preferredFont;
@property (nonatomic, strong) UIColor *preferredTextColor;

- (instancetype)initWithFrame:(CGRect)frame textFont:(UIFont *)font textColor:(UIColor *)textColor;

@end
