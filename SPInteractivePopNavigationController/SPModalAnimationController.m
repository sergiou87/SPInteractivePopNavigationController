// SPDismissAnimationController.m
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Sergio Padrino
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SPModalAnimationController.h"

@interface SPModalAnimationController ()

@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation SPModalAnimationController

- (id)init
{
    if (self = [super init])
    {
        _duration = 0.3f;
        _overlayColor = [UIColor blackColor];
        _presentingViewScale = 0.8f;
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
    
    if (self.dismissing)
    {
        [self animateDismissTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
    else
    {
        [self animatePresentTransition:transitionContext fromVC:fromVC toVC:toVC fromView:fromView toView:toView];
    }
}

- (void)animateDismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                          fromVC:(UIViewController *)fromVC
                            toVC:(UIViewController *)toVC
                        fromView:(UIView *)fromView
                          toView:(UIView *)toView
{
    UIView* containerView = [transitionContext containerView];
    
    // positions the to- view behind the from- view
    [containerView insertSubview:toView belowSubview:fromView];
    containerView.backgroundColor = self.overlayColor;
    
    // Calculate VC frames
    CGRect fromStartFrame = [transitionContext initialFrameForViewController:fromVC];
    
    CGRect fromEndFrame = fromStartFrame;
    fromEndFrame.origin.y += fromStartFrame.size.height;
    
    // Configure VCs
    fromView.frame =
    toView.frame = fromStartFrame;
    
    toView.transform = CGAffineTransformMakeScale(self.presentingViewScale, self.presentingViewScale);
    
    // Set up overlay view to fade out
    UIView *overlayView = [[UIView alloc] initWithFrame:fromStartFrame];
    overlayView.backgroundColor = self.overlayColor;
    [containerView insertSubview:overlayView aboveSubview:toView];
    
    [UIView
     animateWithDuration:self.duration
     delay:0
     options:[self animationOptionsForTransitionContext:transitionContext]
     animations:^{
         
         fromView.frame = fromEndFrame;
         overlayView.alpha = 0.f;
         toView.transform = CGAffineTransformIdentity;
     }
     completion:^(BOOL finished) {
         toView.transform = CGAffineTransformIdentity;
         [overlayView removeFromSuperview];
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

- (void)animatePresentTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                          fromVC:(UIViewController *)fromVC
                            toVC:(UIViewController *)toVC
                        fromView:(UIView *)fromView
                          toView:(UIView *)toView
{
    
    UIView* containerView = [transitionContext containerView];
    containerView.backgroundColor = self.overlayColor;
    
    // positions the to- view behind the from- view
    [containerView insertSubview:toView aboveSubview:fromView];
    
    // Calculate VC frames
    CGRect fromStartFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect toStartFrame = fromStartFrame;
    toStartFrame.origin.y += fromStartFrame.size.height;
    
    // Configure VCs
    fromView.frame = fromStartFrame;
    toView.frame = toStartFrame;
    
    // Put an overlay view to fade in
    UIView *overlayView = [[UIView alloc] initWithFrame:fromStartFrame];
    overlayView.backgroundColor = self.overlayColor;
    overlayView.alpha = 0.f;
    [containerView insertSubview:overlayView aboveSubview:fromView];
    
    fromView.transform = CGAffineTransformIdentity;
    
    [UIView
     animateWithDuration:self.duration
     delay:0
     options:[self animationOptionsForTransitionContext:transitionContext]
     animations:^{
         
         toView.frame = fromStartFrame;
         overlayView.alpha = 1.f;
         fromView.transform = CGAffineTransformMakeScale(self.presentingViewScale, self.presentingViewScale);
     }
     completion:^(BOOL finished) {
         fromView.transform = CGAffineTransformIdentity;
         [overlayView removeFromSuperview];
         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

- (UIViewAnimationOptions)animationOptionsForTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return ([transitionContext isInteractive]
            ? UIViewAnimationOptionCurveLinear
            : UIViewAnimationOptionCurveEaseInOut);
}

@end
