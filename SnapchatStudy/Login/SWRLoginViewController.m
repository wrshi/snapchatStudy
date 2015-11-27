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

@end

@implementation SWRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self.userNameText becomeFirstResponder];
    
    [self addLoginButton];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLoginButton
{
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenH * 0.4, screenW, 50)];
    loginButton.backgroundColor = tintGreenColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
