//
//  SWRWhiteNavigationBar.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRWhiteNavigationBar.h"

@implementation SWRWhiteNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.barTintColor = [UIColor whiteColor];
        self.titleTextAttributes = @{
                                     NSFontAttributeName : [UIFont systemFontOfSize:24],
                                     NSForegroundColorAttributeName : tintPurpleColor
                                     };
        
        
    }
    return self;
}

@end
