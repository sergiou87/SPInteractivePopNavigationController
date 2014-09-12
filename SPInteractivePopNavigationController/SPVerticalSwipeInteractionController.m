// SPHorizontalSwipeInteractionController.m
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


#import "SPVerticalSwipeInteractionController.h"

static CGFloat const kSPVerticalSwipeInteractionControllerSpeedFast = 200.;

@interface SPVerticalSwipeInteractionController ()

@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIPanGestureRecognizer *gesture;

@end

@implementation SPVerticalSwipeInteractionController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _enabled = YES;
        _topGestureZonePercentage = 0.6f;
    }
    return self;
}

-(void)dealloc
{
    [self.gesture.view removeGestureRecognizer:_gesture];
}

- (void)wireToViewController:(UIViewController *)viewController
{
    self.viewController = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view
{
    self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:_gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if (!self.enabled) return;
            
            BOOL topToBottomSwipe = vel.y > 0 && location.y < self.gesture.view.bounds.size.height * self.topGestureZonePercentage;
            
            // for dismiss operation, fire on top-to-bottom
            if (topToBottomSwipe)
            {
                self.interactionInProgress = YES;
                [self.viewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if (self.interactionInProgress)
            {
                // compute the current position
                CGFloat fraction = translation.y / self.gesture.view.bounds.size.height;
                fraction = fminf(fmaxf(fraction, 0.0), 1.0);
                BOOL isSwipingFast = vel.y > kSPVerticalSwipeInteractionControllerSpeedFast;
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
                if (!self.shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
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
