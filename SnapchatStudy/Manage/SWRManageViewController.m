//
//  SWRManageViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-08.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRManageViewController.h"
#import "SWRConversationViewController.h"

@interface SWRManageViewController () <UIGestureRecognizerDelegate>

@end

@implementation SWRManageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


#pragma mark - private methods

- (void)setSwipeGesture
{
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [leftRecognizer setNumberOfTouchesRequired:1];
    leftRecognizer.delegate = self;
    [self.view addGestureRecognizer:leftRecognizer];
    [self.view setUserInteractionEnabled:YES];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self performSegueWithIdentifier:@"manage2Conversation" sender:nil];
}

@end
