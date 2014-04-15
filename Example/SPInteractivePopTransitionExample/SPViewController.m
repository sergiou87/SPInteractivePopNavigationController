//
//  SPViewController.m
//  SPInteractivePopTransitionExample
//
//  Created by Sergio Padrino on 15/04/14.
//  Copyright (c) 2014 Sergio Padrino. All rights reserved.
//

#import "SPViewController.h"

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
    
    if ([[self.navigationController viewControllers] indexOfObject:self] > 0)
	{
        self.shouldHideNavigationBar = (arc4random_uniform(10) < 3);

        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc]
                                          initWithTitle:@"Return"
                                          style:UIBarButtonItemStylePlain
                                          target:self.navigationController
                                          action:@selector(popViewControllerAnimated:)];
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    self.title = [NSString stringWithFormat:@"%d", arc4random_uniform(2000)];
    
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
    UIViewController *viewController = [[[self class] alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
