//
//  SPPopAnimationController.m
//  Sergio Padrino
//
//  Created by Sergio Padrino on 09/03/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPPopAnimationController.h"

@implementation SPPopAnimationController

- (id)init
{
    if (self = [super init])
	{
        self.duration = 0.3f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    [self animateTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
				   fromVC:(UIViewController *)fromVC
					 toVC:(UIViewController *)toVC
				 fromView:(UIView *)fromView
				   toView:(UIView *)toView
{

    UIView* containerView = [transitionContext containerView];

    // positions the to- view behind the from- view
	[containerView insertSubview:toView belowSubview:fromView];

	// Calculate source VC frames
    CGRect fromStartFrame = [transitionContext initialFrameForViewController:fromVC];
    
    CGRect fromEndFrame = fromStartFrame;
    fromEndFrame.origin.x = fromStartFrame.size.width;
	
	// Calculate destination VC frames
	CGRect toEndFrame = [transitionContext finalFrameForViewController:toVC];
	
    CGRect toStartFrame = toEndFrame;
    toStartFrame.origin.x = fromStartFrame.origin.x - fromStartFrame.size.width * 0.25f;
    toView.frame = toStartFrame;
    
	// Calculate navigation bar frame
	UINavigationBar *navigationBar = fromVC.navigationController.navigationBar;
	BOOL shouldMoveNavigationBar = toVC.navigationController.navigationBarHidden;

	CGRect navigationBarEndFrame = navigationBar.frame;
	navigationBarEndFrame.origin.x += navigationBarEndFrame.size.width;

	navigationBar.hidden = NO;
	navigationBar.alpha = 1;
	
	// Configure toVC title to simulate title view animation
	UIView *toTitleView = [self titleViewWithText:toVC.navigationItem.title
                                       attributes:toVC.navigationController.navigationBar.titleTextAttributes];
	toVC.navigationItem.titleView = toTitleView;
	
	CGRect toTitleEndFrame = [self frameForTitleView:toTitleView centeredInNavigationBar:navigationBar];
	
	CGRect toTitleStartFrame = toTitleEndFrame;
	toTitleStartFrame.origin.x = navigationBar.frame.size.width * 0.1f; // Title animation starts on the first 10th of the navigation bar
	
	// Round decimal numbers
	toTitleStartFrame = CGRectIntegral(toTitleStartFrame);
	toTitleEndFrame = CGRectIntegral(toTitleEndFrame);
	
	toTitleView.frame = toTitleStartFrame;
	
	// Configure fromVC title to simulate title view animation
	UIView *fromTitleView = [self titleViewWithText:fromVC.navigationItem.title
                                         attributes:fromVC.navigationController.navigationBar.titleTextAttributes];
	fromVC.navigationItem.titleView = fromTitleView;
	
	CGRect fromTitleStartFrame = [self frameForTitleView:fromTitleView centeredInNavigationBar:navigationBar];
	
	CGRect fromTitleEndFrame = fromTitleStartFrame;
	fromTitleEndFrame.origin.x = navigationBar.frame.size.width; // Title animation ends on the last 10th of the navigation bar
	
	// Round decimal numbers
	fromTitleStartFrame = CGRectIntegral(fromTitleStartFrame);
	fromTitleEndFrame = CGRectIntegral(fromTitleEndFrame);
	
	fromTitleView.frame = fromTitleStartFrame;
	
    [UIView
     animateWithDuration:self.duration
     delay:0
     options:[self animationOptionsForTransitionContext:transitionContext]
     animations:^{
		 
		 toTitleView.frame = toTitleEndFrame;
		 fromTitleView.frame = fromTitleEndFrame;
		 fromView.frame = fromEndFrame;
		 toView.frame = toEndFrame;
		 
		 if (shouldMoveNavigationBar)
		 {
			 navigationBar.frame = navigationBarEndFrame;
		 }
	 }
	 completion:^(BOOL finished) {
		 fromVC.navigationItem.titleView =
		 toVC.navigationItem.titleView = nil;
		 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
	 }];
}

- (UIView *)titleViewWithText:(NSString *)text attributes:(NSDictionary *)attributes
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
	label.textAlignment = NSTextAlignmentCenter;
	[label sizeToFit];
	label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	
	UIView *labelContainer = [[UIView alloc] initWithFrame:label.bounds];
	[labelContainer addSubview:label];
    
	return labelContainer;
}

- (CGRect)frameForTitleView:(UIView *)titleView centeredInNavigationBar:(UINavigationBar *)navigationBar
{
	return CGRectMake((navigationBar.frame.size.width - titleView.frame.size.width) / 2.f,
					  (navigationBar.frame.size.height - titleView.frame.size.height) / 2.f,
					  titleView.frame.size.width,
					  titleView.frame.size.height);
}

- (UIViewAnimationOptions)animationOptionsForTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return ([transitionContext isInteractive]
            ? UIViewAnimationOptionCurveLinear
            : UIViewAnimationOptionCurveEaseInOut);
}

@end
