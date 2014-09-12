//
//  SPInteractiveDismissTransitionDelegate.m
//  SPInteractivePopNavigationControllerExample
//
//  Created by Sergio Padrino on 12/09/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPInteractiveDismissTransitionDelegate.h"

#import "SPModalAnimationController.h"
#import "SPVerticalSwipeInteractionController.h"

@interface SPInteractiveDismissTransitionDelegate ()

@property (nonatomic, strong) SPVerticalSwipeInteractionController *interactionController;
@property (nonatomic, strong) SPModalAnimationController *animationController;

@end

@implementation SPInteractiveDismissTransitionDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _interactionController = [[SPVerticalSwipeInteractionController alloc] init];
        _animationController = [[SPModalAnimationController alloc] init];
    }
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    [self.interactionController wireToViewController:presented];
    self.animationController.dismissing = NO;
    
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animationController.dismissing = YES;
    
    return self.animationController;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return (self.interactionController.interactionInProgress
            ? self.interactionController
            : nil);
}

@end
