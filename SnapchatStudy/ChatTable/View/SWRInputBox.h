//
//  SWRInputBox.h
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWRInputBox;

@protocol SWRInputBoxDelegate <NSObject>

@optional
- (void)SWRInputBox:(SWRInputBox *)inputBox sendMessage:(NSString *)messageString;

@end

@interface SWRInputBox : UIView

@property (nonatomic, weak) id<SWRInputBoxDelegate> delegate;

@end
