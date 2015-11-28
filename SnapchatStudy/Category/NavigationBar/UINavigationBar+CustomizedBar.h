//
//  UINavigationBar+CustomizedBar.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-25.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CustomizedBar)

+ (UINavigationBar *)customizedBarWithViewController:(UIViewController *)controller backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor title:(NSString *)title leftButton:(UIBarButtonItem *)leftButton rightButton:(UIBarButtonItem *)rightButton;

@end
