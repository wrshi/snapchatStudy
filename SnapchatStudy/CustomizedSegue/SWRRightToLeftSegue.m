//
//  SWRRightToLeftSegue.m
//  SnapchatStudy
//
//  Created by Weiran Shi on 2015-11-09.
//  Copyright (c) 2015 Vera Shi. All rights reserved.
//

#import "SWRRightToLeftSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation SWRRightToLeftSegue

-(void)perform {
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    
    
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    [sourceViewController.navigationController popViewControllerAnimated:YES];
    
}


@end
