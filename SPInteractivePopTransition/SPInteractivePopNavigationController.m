//
//  SPNavigationController.m
//  SPInteractivePopTransitionExample
//
//  Created by Sergio Padrino on 16/04/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPInteractivePopNavigationController.h"

#import "SPPopAnimationController.h"
#import "SPHorizontalSwipeInteractionController.h"

@interface SPInteractivePopNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) SPPopAnimationController *popAnimationController;
@property (nonatomic, strong) SPHorizontalSwipeInteractionController *popInteractiveTransition;

@end

@implementation SPInteractivePopNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	if (self != nil)
	{
		self.delegate = self;
		
		_popInteractiveTransition = [[SPHorizontalSwipeInteractionController alloc] init];
		_popAnimationController = [[SPPopAnimationController alloc] init];
	}
    
	return self;
}

#pragma mark - UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								  animationControllerForOperation:(UINavigationControllerOperation)operation
											   fromViewController:(UIViewController *)fromVC
												 toViewController:(UIViewController *)toVC
{
	[self.popInteractiveTransition wireToViewController:toVC];
    
	return (operation == UINavigationControllerOperationPop
			? self.popAnimationController
			: nil);
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
						  interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
	return (self.popInteractiveTransition.interactionInProgress
			? self.popInteractiveTransition
			: nil);
}

@end
