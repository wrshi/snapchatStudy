//
//  SWRSearchController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-27.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRSearchController.h"


@interface SWRSearchController ()

@end

@implementation SWRSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController searchBarFrame:(CGRect)frame searchBarFont:(UIFont *)font searchBarTextColor:(UIColor *)color searchBarTintColor:(UIColor *)tintColor
{
    if (self = [super initWithSearchResultsController:searchResultsController]){
        SWRSearchBar *customSearchBar = [[SWRSearchBar alloc] initWithFrame:frame textFont:font textColor:color];
        customSearchBar.barTintColor = tintColor;
        customSearchBar.tintColor = color;
        customSearchBar.showsBookmarkButton = NO;
        customSearchBar.showsCancelButton = NO;
        self.customSearchBar = customSearchBar;
        self.customSearchBar.delegate = self;
    }
    return self;
}

- (void)terminateSearch
{
    [self.customSearchBar resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if ([self.delegate respondsToSelector:@selector(didStartSearching)]){
        [self.delegate didStartSearching];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.customSearchBar resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didTapOnSearchButton)]){
        [self.delegate didTapOnSearchButton];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.customSearchBar resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didTapOnCancelButton)]){
        [self.delegate didTapOnCancelButton];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([self.delegate respondsToSelector:@selector(didChangeSearchText:)]){
        [self.delegate didChangeSearchText:searchText];
    }
}

@end
