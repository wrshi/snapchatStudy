//
//  SWRSignupViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRSignupViewController.h"
#import "SWRWhiteNavigationBar.h"

@interface SWRSignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation SWRSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"注册";
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"Back_Button_black"] forState:UIControlStateNormal];
    backButton.bounds = CGRectMake(0, 0, 15, 20);
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    SWRWhiteNavigationBar *navBar = [[SWRWhiteNavigationBar alloc] init];
    [self.navigationController setValue:navBar forKeyPath:@"navigationBar"];
    
    [self.userNameText becomeFirstResponder];
    
    [self addSignUpButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addSignUpButton
{
    UIButton *signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenH * 0.4, screenW, 50)];
    signUpButton.backgroundColor = tintGreenColor;
    [signUpButton setTitle:@"注册" forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
}

- (void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickSignUpButton
{
    
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
