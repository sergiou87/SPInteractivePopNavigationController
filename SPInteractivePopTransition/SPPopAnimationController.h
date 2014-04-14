//
//  SPPopAnimationController.h
//  Sergio Padrino
//
//  Created by Sergio Padrino on 09/03/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

@interface SPPopAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval duration;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;

@end
