//
//  SWRMessageFrame.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-11.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWRMessageModel.h"

@interface SWRMessageFrame : NSObject

@property (nonatomic, strong) SWRMessageModel *messageModel;
@property (nonatomic, assign) CGRect fromFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect rimLineFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
