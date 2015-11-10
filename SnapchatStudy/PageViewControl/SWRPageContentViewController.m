//
//  SWRPageContentViewController.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-09.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRPageContentViewController.h"
#import "SWRPageViewController.h"
#import "SWRConversationTableViewController.h"
#import "SWRManageViewController.h"
#import "SWRGreenNavigationBar.h"

@interface SWRPageContentViewController () <UIPageViewControllerDataSource>

@property (nonatomic, strong) SWRPageViewController *pageViewController;


@end

@implementation SWRPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    [self setNavigationBar];
    
    
    SWRConversationTableViewController *conversationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversationTableViewController"];
    SWRManageViewController *manageController = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageViewController"];
    NSArray *viewcontrollers = @[conversationController];
    
    [self.pageViewController setViewControllers:viewcontrollers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[SWRConversationTableViewController class]]) {
        SWRManageViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ManageViewController"];
        [self.navigationController setNavigationBarHidden:YES];
        return  pvc;
        
    }
    
    else return nil;
    
}


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    if ([viewController isKindOfClass:[SWRManageViewController class]]) {
        SWRConversationTableViewController *conversationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ConversationTableViewController"];
        [self setNavigationBar];
        [self.navigationController setNavigationBarHidden:NO];
        return conversationController;
        
    }
    else return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if(finished && completed)
    {
        if ([[previousViewControllers lastObject] isKindOfClass:[SWRConversationTableViewController class]]){
            [self.navigationController setNavigationBarHidden:YES];
        }
        else if ([[previousViewControllers lastObject] isKindOfClass:[SWRManageViewController class]]){
            [self.navigationController setNavigationBarHidden:NO];
        }

    }
}

- (void)setNavigationBar
{
    self.navigationItem.title = @"snapchat";
    SWRGreenNavigationBar *navBar = [[SWRGreenNavigationBar alloc] init];
    [self.navigationController setValue:navBar forKeyPath:@"navigationBar"];
    
    UIButton *findFriendButton = [[UIButton alloc] init];
    [findFriendButton setImage:[UIImage imageNamed:@"profile_mycontacts_icon"] forState:UIControlStateNormal];
    findFriendButton.bounds = CGRectMake(0, 0, 40, 40);
    [findFriendButton addTarget:self action:@selector(clickFindFriendButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:findFriendButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton *addFriendButton = [[UIButton alloc] init];
    [addFriendButton setImage:[UIImage imageNamed:@"Add_Friend_Button"] forState:UIControlStateNormal];
    addFriendButton.bounds = CGRectMake(0, 0, 40, 40);
    [addFriendButton addTarget:self action:@selector(clickAddFriendButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addFriendButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
