// SPViewController.m
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

#import "SPViewController.h"

#import "SPInteractivePopNavigationController.h"
#import "UIColor+SPRandomColor.h"
#import "SPInteractiveDismissTransitionDelegate.h"
#import "SPDismissableViewController.h"
#import "SPInteractiveDismissNavigationController.h"

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

- (IBAction)presentButtonTap:(id)sender
{
    UIViewController *viewController = [[SPDismissableViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navigationController = [[SPInteractiveDismissNavigationController alloc] initWithRootViewController:viewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
