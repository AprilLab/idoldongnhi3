//
//  SchedulesControllerViewController.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "SchedulesControllerViewController.h"
#import "AUIFreedomController.h"

@interface SchedulesControllerViewController ()

@end

@implementation SchedulesControllerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    _pageTitles = @[@"Thang 1", @"Thang 2", @"Thang 3", @"Thang 4"];
    
    
    // Create page view controller
    self.pageViewController = _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                                  options:[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:50.0f] forKey:UIPageViewControllerOptionInterPageSpacingKey]];
    

    self.pageViewController.dataSource = self;
    
    ScheduleDetailControllerViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    
    
    
    // set background
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_blur"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-nav"] style:UIBarButtonItemStyleBordered target:self action:@selector(menuButtonClick)];
    
    [menuButton setTintColor: [UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = menuButton;
    
}








-(void) menuButtonClick{
    
    [[AUIFreedomController sharedFreedomController] changeChildViewControllerFrame:CGRectNull withName:@"mainMenu" withDuration:0.2 delay:0];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    ScheduleDetailControllerViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (ScheduleDetailControllerViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ScheduleDetailControllerViewController *pageContentViewController = [[ScheduleDetailControllerViewController alloc] init];
    
    
    pageContentViewController.pageTitle = self.pageTitles[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ScheduleDetailControllerViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ScheduleDetailControllerViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
/*
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
 
 */
@end
