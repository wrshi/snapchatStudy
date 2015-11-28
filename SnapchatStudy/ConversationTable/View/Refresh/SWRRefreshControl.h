//
//  SWRRefreshControl.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-26.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWRRefreshControl : UIRefreshControl

@property (nonatomic, strong) NSArray *backgroundColors;
@property (nonatomic, assign) BOOL showImage;

+ (instancetype)SWRRefreshControl;


@end
