//
//  PageViewController.m
//  April
//
//  Created by admin on 4/21/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainMenuCollectionController.h"
#import "AUIFreedomController.h"
#import "ManageSize.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setClipsToBounds:YES];

    
    // BACKGROUND
    // ======
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_menu"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    
    // MENU BUTTON
    // ======
    
    UIImage *buttonImage = [UIImage imageNamed:@"menu-nav-transparent-border.png"];
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 23, buttonImage.size.width, buttonImage.size.height)];
    
    [menuButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButton];
    
    
    UIImage *buttonImageHome = [UIImage imageNamed:@"menu-nav-transparent-border.png"];
    UIButton *menuButtonHome = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 4 - buttonImage.size.width, 23, buttonImage.size.width, buttonImage.size.height)];
    
    [menuButtonHome setBackgroundImage:buttonImageHome forState:UIControlStateNormal];
    [menuButtonHome addTarget:self action:@selector(homeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButtonHome];
    
    
    // PAGE VIEW
    // ======
    
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    
    MainMenuCollectionController *contentPV = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers= [NSArray arrayWithObject:contentPV];
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    [pageViewController.view setFrame:CGRectMake(0, 60, 320, 430)];
    
}


-(void) menuButtonClick:(id)sender
{
    [ManageSize hideMainMenu];
}

- (void) homeButtonClick: (id) sender{
    AUIFreedomController *sharedFreedomController = [AUIFreedomController sharedFreedomController];
    AUIFreedomController *mainWrapper = [sharedFreedomController getChildViewControllerWithName:@"mainWrapper"];
    
    [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"homeView"] view]];
    
    // hide menu
    [ManageSize hideMainMenu];
}






// Index nao cung chi co 1 controller
// cho nen o day se return 1 controller thoi
- (MainMenuCollectionController *)viewControllerAtIndex:(NSUInteger)index{
    MainMenuCollectionController *mainMenuCollectionController = [[MainMenuCollectionController alloc] init];
    mainMenuCollectionController.index = index;

    return mainMenuCollectionController;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index= [(MainMenuCollectionController *)viewController index];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index= [(MainMenuCollectionController *)viewController index];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index >=1) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

@end
