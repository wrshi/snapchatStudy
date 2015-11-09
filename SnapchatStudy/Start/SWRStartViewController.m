//
//  SWRStartViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRStartViewController.h"
#import "SWRNavigationController.h"
#import "SWRWhiteNavigationBar.h"
#import "SWRLoginViewController.h"

@interface SWRStartViewController ()

@end

@implementation SWRStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)loginButtonClick:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    VSLoginViewController *loginVc = [sb instantiateViewControllerWithIdentifier:@"VSLoginViewController"];
//    VSWhiteNavigationBar *navBar = [[VSWhiteNavigationBar alloc] init];
//    [loginVc.navigationController setValue:navBar forKeyPath:@"navigationBar"];
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = loginVc;
//}

@end
