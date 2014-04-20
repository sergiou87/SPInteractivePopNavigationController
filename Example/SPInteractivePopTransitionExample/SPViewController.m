//
//  SPViewController.m
//  SPInteractivePopTransitionExample
//
//  Created by Sergio Padrino on 15/04/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPViewController.h"

#import "SPInteractivePopNavigationController.h"
#import "UIColor+SPRandomColor.h"

@interface SPViewController ()

@property (nonatomic) BOOL shouldHideNavigationBar;

@end

@implementation SPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.navigationController.viewControllers firstObject] == self) // Root view controller
	{
        self.shouldHideNavigationBar = YES;
    }
    else
    {
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc]
                                          initWithTitle:@"Return"
                                          style:UIBarButtonItemStylePlain
                                          target:self.navigationController
                                          action:@selector(popViewControllerAnimated:)];
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"%d", arc4random_uniform(2000)];
    
    self.view.backgroundColor = [UIColor sp_randomColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.shouldHideNavigationBar)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    if (self.shouldHideNavigationBar)
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (IBAction)pushButtonTap:(id)sender
{
    UIViewController *viewController = [[SPViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
