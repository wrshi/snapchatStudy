//
//  SWRInputBox.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-12.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRInputBox.h"

@interface SWRInputBox () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textView;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIView *rimLine;

@end

@implementation SWRInputBox

- (UITextField *)textView
{
    if (_textView == nil){
        _textView = [[UITextField alloc] init];
        _textView.frame = CGRectMake(5, 5, self.width - 5 - 48 - 5, self.height - 2 * 5);
        _textView.font = [UIFont systemFontOfSize:16.0f];
        _textView.placeholder = @"send a chat";
        _textView.leftViewMode = UITextFieldViewModeAlways;
        _textView.delegate = self;
    }
    return _textView;
}

- (UIButton *)cameraButton
{
    if (_cameraButton == nil){
        _cameraButton = [[UIButton alloc] init];
        _cameraButton.frame = CGRectMake(self.width - 5 - 48, 5, 48, 34);
        [_cameraButton setImage:[UIImage imageNamed:@"camera_blue"] forState:UIControlStateNormal];
    
    }
    return _cameraButton;
}

- (UIView *)rimLine
{
    if (_rimLine == nil){
        _rimLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _rimLine.backgroundColor = Color(165, 165, 165);
    }
    return _rimLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.textView];
        [self addSubview:self.cameraButton];
        [self addSubview:self.rimLine];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(SWRInputBox:sendMessage:)]){
        [self.delegate SWRInputBox:self sendMessage:self.textView.text];
    }
    self.textView.text = nil;
    return YES;
}


@end
