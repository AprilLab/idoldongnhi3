//
//  SchedulesControllerViewController.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "SchedulesControllerViewController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"


@interface SchedulesControllerViewController ()
{
    // data
    NSArray *APIListUpcomingEvent;
    
    
    // UI
    UIPageViewController *monthPageView;
    UIActivityIndicatorView *scheduleActivityIndicator;
    
    // json info data
    //int APIGalleryCustomListphotoStart;
    
    // used in bg thread
    BOOL bgthreadLoadUpcomingEventsIsRunning;
}

@end

@implementation SchedulesControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // bat dau khoi tao giao dien
    [self.view setClipsToBounds:YES];
    
    
    // BACKGROUND
    // =====
    [self.view setBackgroundColor:[UIColor blackColor]];
    UIImage *bg_newsview = [UIImage imageNamed:@"bg_blur_2_not_include_navigation.png"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bg_newsview];
    bgImageView.frame = CGRectMake(0, 0, bg_newsview.size.width, bg_newsview.size.height);
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    
    // LEFT NAVIGATION BUTTON
    // =====
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-nav-no-shadow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    // TITLE
    // =====
    self.navigationItem.title = @"LỊCH DIỄN";
    
    
    // TABBAR
    // =====
    // boi vi trang am nhac thi khong co tab nao het
    // nen tabbar dua vao chi voi muc dich
    // show ra cai line (1px) mau hong, va cai shadow thoi
    
    AUITabBar *aTabbar = [[AUITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    [aTabbar setBackgroundColor:myPinkColor];
    [aTabbar setBottomShadowImage:[UIImage imageNamed:@"tabbar_bottom_shadow.png"]];
    [self.view addSubview:aTabbar];
    
    
    
    
    
    
    // PAGE VIEW THANG NAM
    // =====
    // level tren cung se la thang cua 1 nam
    // va cai nay that ra se la 1 cai page view thoi
    monthPageView = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                  options:@{UIPageViewControllerOptionInterPageSpacingKey: @0}];
    [monthPageView.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [monthPageView setDataSource:self];
    [self addChildViewController:monthPageView];
    [self.view addSubview:monthPageView.view];    
    
    
    
    // LOADING VIEW
    // (popup nho nho de user biet la dang load)
    // =====
    scheduleActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [scheduleActivityIndicator setFrame:CGRectMake(280, 10, 30, 30)];
    [scheduleActivityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [scheduleActivityIndicator.layer setCornerRadius:5];
    [scheduleActivityIndicator setHidden:YES];
    [aTabbar addSubview:scheduleActivityIndicator];

    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // bat dau load nhung du lieu luon
    [self performSelectorInBackground:@selector(bgthreadLoadUpcomingEvents) withObject:nil];
}


#pragma mark - Button delegate

-(void) menuButtonClick{
    [ManageSize showMainMenu];
}



#pragma mark - Page View Controller Data Source

- (ScheduleDetailControllerViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if(([APIListUpcomingEvent count] == 0) || (index >= [APIListUpcomingEvent count]))
        return nil;
    
    // Create a new view controller and pass suitable data.
    ScheduleDetailControllerViewController *monthDetailPageController = [[ScheduleDetailControllerViewController alloc] init];
    
    // set info
    monthDetailPageController.pageIndex = index;
    monthDetailPageController.monthData = (NSMutableDictionary *)[APIListUpcomingEvent objectAtIndex:index];
    monthDetailPageController.daysData = (NSMutableArray *)[monthDetailPageController.monthData objectForKey:@"days"];
    
    return monthDetailPageController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ScheduleDetailControllerViewController*) viewController).pageIndex;
    
    if((index == 0) || (index == NSNotFound))
        return nil;
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ScheduleDetailControllerViewController*) viewController).pageIndex;
    
    if (index == NSNotFound)
        return nil;
    
    index++;
    if(index == [APIListUpcomingEvent count])
        return nil;

    return [self viewControllerAtIndex:index];
}








#pragma mark - Network Get json, data from server


// JSON GET/POST DATA FROM API METHODS
// =============
//-(void)getGalleryHasId:(int)localGalleryId listphotoStart:(int)start limit:(int)limit
-(void)getUpcomingEvents
{
    //NSLog(@"getUpcomingEvents ...");
    
    NSDictionary *listupcomingeventDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:@"listupcomingevent"];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listupcomingeventDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listupcomingeventDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listupcomingeventDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get ra list upcoming event luon
    APIListUpcomingEvent = (NSArray *)[data objectForKey:@"listupcomingevent"];
    
    //NSLog(@"getUpcomingEvents: done!");
}





#pragma mark - Background and main thread

-(void)bgthreadLoadUpcomingEvents
{
    if(bgthreadLoadUpcomingEventsIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadUpcomingEventsIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [scheduleActivityIndicator setHidden:NO];
        [scheduleActivityIndicator startAnimating];
    });
    
    // load upcoming event
    [self getUpcomingEvents];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadUpcomingEvents) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadUpcomingEvents
{
    // bay gio moi bat dau set may cai thang child controller vao
    // set tung cai page (la tung thang) vao trong cai month page view nay
    ScheduleDetailControllerViewController *startingViewController = [self viewControllerAtIndex:0];
    [monthPageView setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    // done!
    bgthreadLoadUpcomingEventsIsRunning = NO;
    [scheduleActivityIndicator stopAnimating];
    [scheduleActivityIndicator setHidden:YES];
    [scheduleActivityIndicator removeFromSuperview];
}



@end
