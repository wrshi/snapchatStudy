//
//  UINavigationBar+CustomizedBar.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "UINavigationBar+CustomizedBar.h"

@implementation UINavigationBar (CustomizedBar)

+ (UINavigationBar *)customizedBarWithViewController:(UIViewController *)controller backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor title:(NSString *)title leftButton:(UIBarButtonItem *)leftButton rightButton:(UIBarButtonItem *)rightButton
{
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(controller.view.bounds), 44.0)];
    newNavBar.barTintColor = backgroundColor;
    newNavBar.titleTextAttributes = @{
                                 NSFontAttributeName : [UIFont systemFontOfSize:24],
                                 NSForegroundColorAttributeName : textColor
                                 };

    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    newItem.title = title;
    newItem.leftBarButtonItem = leftButton;
    newItem.rightBarButtonItem = rightButton;
    [newNavBar setItems:@[newItem]];

    [controller.view addSubview:newNavBar];
    
    return newNavBar;
}


@end
