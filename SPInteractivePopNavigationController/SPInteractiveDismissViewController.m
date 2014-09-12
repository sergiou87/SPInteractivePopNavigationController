//
//  SPInteractiveDismissViewController.m
//  SPInteractivePopNavigationControllerExample
//
//  Created by Sergio Padrino on 12/09/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPInteractiveDismissViewController.h"

#import "SPInteractiveDismissTransitionDelegate.h"

@interface SPInteractiveDismissViewController ()

@property (nonatomic, strong) SPInteractiveDismissTransitionDelegate *interactiveDismissTransitionDelegate;

@end

@implementation SPInteractiveDismissViewController

- (id<UIViewControllerTransitioningDelegate>)transitioningDelegate
{
    return self.interactiveDismissTransitionDelegate;
}

- (SPInteractiveDismissTransitionDelegate *)interactiveDismissTransitionDelegate
{
    if (!_interactiveDismissTransitionDelegate)
    {
        _interactiveDismissTransitionDelegate = [[SPInteractiveDismissTransitionDelegate alloc] init];
    }
    
    return _interactiveDismissTransitionDelegate;
}

@end
