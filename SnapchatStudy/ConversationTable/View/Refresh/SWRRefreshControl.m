//
//  SWRRefreshControl.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-26.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRRefreshControl.h"

@interface SWRRefreshControl ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation SWRRefreshControl

- (instancetype)init
{
    if (self = [super init]){
        self.backgroundColor = tintBlueColor;
        self.tintColor = [UIColor clearColor];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:@"Blocked_Snapchatters"];
        
        [self addSubview:self.imageView];
        
        self.backgroundColors = @[tintPurpleColor, tintRedColor,  tintBlueColor];
    }
    return self;
}

+ (instancetype)SWRRefreshControl
{
    return [[self alloc] init];
}

- (void)layoutSubviews
{
    self.imageView.bounds = CGRectMake(0, 0, 50, 50);
    self.imageView.x = (screenW - self.imageView.width) / 2;
    self.imageView.y = 8;
}



@end
