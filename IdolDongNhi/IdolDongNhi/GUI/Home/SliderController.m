//
//  SliderController.m
//  April
//
//  Created by admin on 4/23/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "SliderController.h"
#import "SliderContentController.h"
@interface SliderController ()

@end

@implementation SliderController






UIPageViewController *_pageControll;
- (void)viewDidLoad{
    [super viewDidLoad];
    
    _pageControll= [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    _pageControll.dataSource= self;
    [[_pageControll view]setFrame:[[self view]bounds]];
    SliderContentController *contentPV= [self viewControllerAtIndex:0];
    
    NSArray *viewControllers= [NSArray arrayWithObject:contentPV];
    [_pageControll setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    UIView *nview= [_pageControll view];
    [nview setFrame:CGRectMake(0, 0, 320, 230)];
    [self addChildViewController:_pageControll];
    [[self view] addSubview:nview];
    
    [_pageControll didMoveToParentViewController:self];

    _pageControll.view.backgroundColor= [UIColor grayColor];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    
    
    /*
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Menu"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem= menuButton;
     */
}










- (SliderContentController *)viewControllerAtIndex:(NSUInteger)index{
    SliderContentController *contentPV= [[SliderContentController alloc] init];
    contentPV.index= index;
    
    return contentPV;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index= [(SliderContentController *)viewController index];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index= [(SliderContentController *)viewController index];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index >=2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}




/*
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
*/




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
