//
//  SWRGreenNavigationBar.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRGreenNavigationBar.h"

@implementation SWRGreenNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.barTintColor = tintGreenColor;
        self.titleTextAttributes = @{
                                     NSFontAttributeName : [UIFont systemFontOfSize:28],
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     };
    }
    return self;
}

@end
