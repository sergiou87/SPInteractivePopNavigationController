//
//  SPHorizontalSwipeInteractionController.h
//  Sergio Padrino
//
//  Created by Sergio Padrino on 09/03/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPHorizontalSwipeInteractionController : UIPercentDrivenInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController;

@property (nonatomic, assign) BOOL interactionInProgress;
@property (nonatomic, assign, getter = isEnabled) BOOL enabled;

@end
