//
//  SWRSearchController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-27.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRSearchController.h"
#import "SWRSearchBar.h"

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
        customSearchBar.showsCancelButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
