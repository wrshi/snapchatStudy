//
//  SWRLoginViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRLoginViewController.h"

@interface SWRLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation SWRLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.userNameText becomeFirstResponder];
    
    [self.userNameText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self addLoginButton];
    [self textChange];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setNavigationBar];
}

- (void)setNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_black"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [UINavigationBar customizedBarWithViewController:self backgroundColor:[UIColor whiteColor] textColor:tintPurpleColor title:@"登录" leftButton:leftButtonItem rightButton:nil];
}

- (void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addLoginButton
{
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(-screenW, screenH * 0.4, screenW, 50)];
    loginButton.backgroundColor = tintGreenColor;
    loginButton.alpha = 0;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    self.loginButton = loginButton;
}

/*
 check text status and make button animation
 */
- (void)textChange
{
    if (self.userNameText.text.length && self.passwordText.text.length) {
        [UIView animateWithDuration:0.5 animations:^{
            self.loginButton.x = 0;
            self.loginButton.alpha = 1;
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.loginButton.x = -screenW;
            self.loginButton.alpha = 0;
        }];
        
    }
}

- (void)clickLoginButton
{
    [PFUser logInWithUsernameInBackground:self.userNameText.text password:self.passwordText.text block:^(PFUser *user, NSError *error){
        if (user) {
            [self performSegueWithIdentifier:@"login2Conversations" sender:nil];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            MyLog(@"login error: %@", errorString);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"用户名或密码不正确喔，再试一下？" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    
}

@end
