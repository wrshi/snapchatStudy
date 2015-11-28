//
//  SWRSearchController.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-27.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRSearchBar.h"

@class SWRSearchController;

@protocol SWRSearchControllerDelegate <NSObject>

@optional
- (void)didStartSearching;

- (void)didTapOnSearchButton;

- (void)didTapOnCancelButton;

- (void)didChangeSearchText:(NSString *)searchText;


@end

@interface SWRSearchController : UISearchController

@property (nonatomic, strong) SWRSearchBar *customSearchBar;
@property (nonatomic, weak) id<SWRSearchControllerDelegate> delegate;

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController searchBarFrame:(CGRect)frame searchBarFont:(UIFont *)font searchBarTextColor:(UIColor *)color searchBarTintColor:(UIColor *)tintColor;
- (void)terminateSearch;

@end
