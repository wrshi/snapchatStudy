//
//  SWRLoginViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRLoginViewController.h"
#import "SWRNavigationController.h"
#import "SWRWhiteNavigationBar.h"

@interface SWRLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation SWRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"登录";
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_black"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    SWRWhiteNavigationBar *navBar = [[SWRWhiteNavigationBar alloc] init];
    [self.navigationController setValue:navBar forKeyPath:@"navigationBar"];
    
    [self.userNameText becomeFirstResponder];
    
    [self addLoginButton];
    
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

- (void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickLoginButton
{
    [self performSegueWithIdentifier:@"login2Conversations" sender:nil];
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
