//
//  UIColor+SPRandomColor.m
//  SPInteractivePopTransitionExample
//
//  Created by Sergio Padrino on 16/04/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "UIColor+SPRandomColor.h"

@implementation UIColor (SPRandomColor)

+ (NSArray *)sp_colors
{
    static NSArray *colors = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = @[
                   [UIColor whiteColor],
                   [UIColor redColor],
                   [UIColor yellowColor],
                   [UIColor greenColor],
                   [UIColor purpleColor],
                   [UIColor orangeColor],
                   [UIColor brownColor],
                   [UIColor lightGrayColor],
                   ];
    });
    
    return colors;
}

+ (UIColor *)sp_randomColor
{
    NSArray *colors = [[self class] sp_colors];
    return colors[arc4random_uniform([colors count])];
}

@end
