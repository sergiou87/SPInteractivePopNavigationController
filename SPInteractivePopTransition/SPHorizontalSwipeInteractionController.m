//
//  SPHorizontalSwipeInteractionController.m
//  Sergio Padrino
//
//  Created by Sergio Padrino on 09/03/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPHorizontalSwipeInteractionController.h"

static CGFloat const kSPHorizontalSwipeInteractionControllerSpeedFast = 200.;

@interface SPHorizontalSwipeInteractionController ()

@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gesture;

@end

@implementation SPHorizontalSwipeInteractionController

-(void)dealloc
{
    [_gesture.view removeGestureRecognizer:_gesture];
}

- (void)wireToViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view
{
    _gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	_gesture.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:_gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    switch (gestureRecognizer.state)
	{
        case UIGestureRecognizerStateBegan:
		{
			if (!self.enabled) return;

            BOOL leftToRightSwipe = vel.x > 0;
            
			// for pop operation, fire on right-to-left
			if (leftToRightSwipe) {
				self.interactionInProgress = YES;
				[_viewController.navigationController popViewControllerAnimated:YES];
			}
            break;
        }
        case UIGestureRecognizerStateChanged:
		{
            if (self.interactionInProgress)
			{
                // compute the current position
                CGFloat fraction = translation.x / 320.0f;
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
				BOOL isSwipingFast = vel.x > kSPHorizontalSwipeInteractionControllerSpeedFast;
                _shouldCompleteTransition = (fraction > 0.5 || isSwipingFast);
                
                // if an interactive transitions is 100% completed via the user interaction, for some reason
                // the animation completion block is not called, and hence the transition is not completed.
                // This glorious hack makes sure that this doesn't happen.
                // see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
                if (fraction >= 1.0f)
                    fraction = 0.99f;
                
                [self updateInteractiveTransition:fraction];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (self.interactionInProgress)
			{
                self.interactionInProgress = NO;
                if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
				{
                    [self cancelInteractiveTransition];
                }
                else
				{
                    [self finishInteractiveTransition];
                }
            }
            break;
        default:
            break;
    }
}

- (UIViewAnimationCurve)completionCurve
{
    return UIViewAnimationCurveEaseOut;
}

@end
