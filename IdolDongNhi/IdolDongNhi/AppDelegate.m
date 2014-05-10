//
//  AppDelegate.m
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 4/26/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AppDelegate.h"
#import "AUIFreedomController.h"
#import "HomeViewController.h"
#import "PlayingMusicView.h"
#import "MainMenuViewController.h"
#import "LoginViewController.h"
#import "NewsViewController.h"
#import "GalleryAlbumsViewController.h"
#import "VideoListController.h"
#import "AlbumsController.h"
#import "AlbumTracksViewController.h"
#import "SchedulesControllerViewController.h"
#import "FanzoneViewController.h"
#import "DongNhiViewController.h"
#import <CoreText/CoreText.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // LOAD FONTS
    // ======
    
    // UTM Bitsumishi Pro
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"UTM Bitsumishi Pro Regular" withExtension:@"ttf"];
    CFErrorRef error;
    CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
    error = nil;
    
    // Open Sans Light
    url = [[NSBundle mainBundle] URLForResource:@"OpenSans-Light" withExtension:@"ttf"];
    CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
    error = nil;
    
    // Open Sans Regular
    url = [[NSBundle mainBundle] URLForResource:@"OpenSans-Regular" withExtension:@"ttf"];
    CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
    error = nil;
    
    // Open Sans Bold
    url = [[NSBundle mainBundle] URLForResource:@"OpenSans-Bold" withExtension:@"ttf"];
    CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
    error = nil;
    
    
    // CHANGE USER AGENT
    // =====
    NSDictionary *defaultDic = @{@"UserAgent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36"};
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultDic];
    
    
    // WINDOW
    // ======
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    
    // NAVIGATION BAR
    // ========
    
    // background cua navigation
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    // khong co cho bottom border 1px
    [[UINavigationBar appearance] setShadowImage:nil];
    // mau sac cua button tren navigation
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    // title
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSShadowAttributeName: [[NSShadow alloc] init],
                                                           NSFontAttributeName: [UIFont fontWithName:@"OpenSans" size:20]
                                                           }];
    
    
    
    // < FREEDOM CONTAINER CONTROLLER >
    
    AUIFreedomController *sharedFreedomController = [AUIFreedomController sharedFreedomController];
    self.window.rootViewController = sharedFreedomController;
    
    
    // < MAIN WRAPPER >
    
    AUIFreedomController *mainWrapperController = [[AUIFreedomController alloc] init];
    [sharedFreedomController addChildViewController:mainWrapperController withName:@"mainWrapper" withFrame:CGRectNull];
    
    // < NEWS >
    NewsViewController *newsViewController = [[NewsViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"newsView" withFrame:CGRectNull];
    // </ NEWS >
    
    // < MUSIC >
    AlbumsController *albumViewController = [[AlbumsController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:albumViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"musicView" withFrame:CGRectNull];
    // < /MUSIC >
    
    // < GALLERY >
    GalleryAlbumsViewController *galleryViewController = [[GalleryAlbumsViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:galleryViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"galleryView" withFrame:CGRectNull];
    // < /GALLERY >
    
    // < VIDEO >
    VideoListController *videoViewController = [[VideoListController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:videoViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"videoView" withFrame:CGRectNull];
    // < / VIDEO >
    
    
    // < SCHEDULE >
    SchedulesControllerViewController *scheduleViewController = [[SchedulesControllerViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:scheduleViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"scheduleView" withFrame:CGRectNull];
    // < /SCHEDULE >
    
    // < FANZONE >
    FanzoneViewController *fanzoneViewController = [[FanzoneViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:fanzoneViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"fanzoneView" withFrame:CGRectNull];
    // < /FANZONE >
    
    // < DONGNHI >
    DongNhiViewController *dongnhiViewController = [[DongNhiViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:dongnhiViewController];
    [navController.view setClipsToBounds:YES];
    [mainWrapperController addChildViewController:navController withName:@"dongnhiView" withFrame:CGRectNull];
    // < /DONGNHI >
    
    
    // < HOME PAGE >
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    [mainWrapperController addChildViewController:homeViewController withName:@"homeView" withFrame:CGRectNull];
    
    // </ HOME PAGE >
    
    
    // </ MAIN WRAPPER >
    
    
    
    
    // < PLAYING MUSIC BAR >
    
    PlayingMusicView *playingMusicView = [PlayingMusicView sharePlaying];
    [sharedFreedomController addChildViewController:playingMusicView withName:@"playingMusicBar" withFrame:CGRectNull];
    
    // set vi tri cho thang music bar nam duoi cung
    int tempX = 0;
    int tempY = [sharedFreedomController getHeight] + 10;
    int tempW = [sharedFreedomController getWidth];
    int tempH = playingMusicViewHeight;
    
    [sharedFreedomController changeChildViewControllerFrame:CGRectMake(tempX, tempY, tempW, tempH) withName:@"playingMusicBar"];
    
    // set backround
    [playingMusicView.view setBackgroundColor:[UIColor blackColor]];
    
    // sau do phai bao default la co dang hide hay khong
    playingMusicView.isHide = YES;
    
    // </ PLAYING MUSIC BAR >
    
    
    
    // < MAIN MENU >
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    //[sharedFreedomController addChildViewController:mainMenuViewController withName:@"mainMenu" withFrame:CGRectMake(0, 0, [sharedFreedomController getWidth], 0)];
    [sharedFreedomController addChildViewController:mainMenuViewController withName:@"mainMenu" withFrame:CGRectNull];
    [mainMenuViewController.view setHidden:YES];
    
    // </ MAIN MENU >
    
    
    
    // < LOGIN VIEW >
    //LoginViewController *loginViewController = [[LoginViewController alloc] init];
    //[sharedFreedomController addChildViewController:loginViewController withName:@"loginView" withFrame:CGRectNull];
    //[loginViewController.view setHidden:NO];
    
    // </ LOGIN VIEW >

    
    
    
    // </ FREEDOM CONTAINER CONTROLLER >
    
    
    return YES;
}

@end
