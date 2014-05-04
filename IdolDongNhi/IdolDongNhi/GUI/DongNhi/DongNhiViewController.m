//
//  DongNhiViewController.m
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 5/4/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "DongNhiViewController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"

#define ABOUTURL @"http://idol.april.com.vn/news/about/dongnhi"

@interface DongNhiViewController ()
{
    // infomation
    NSInteger articleId;
    NSString *title;
    
    // UI
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation DongNhiViewController

- (void)setInfo:(NSDictionary *)info
{
    articleId = [(NSString *)[info objectForKey:@"id"] intValue];
    title = (NSString *)[info objectForKey:@"title"];
}

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
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-nav-no-shadow"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    // TITLE
    // =====
    self.navigationItem.title = @"ĐÔNG NHI";
    
    
    // TABBAR
    // =====
    // boi vi trang video detail thi khong co tab nao het
    // nen tabbar dua vao chi voi muc dich
    // show ra cai line (1px) mau hong, va cai shadow thoi
    
    AUITabBar *aTabbar = [[AUITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    [aTabbar setBackgroundColor:myPinkColor];
    [aTabbar setBottomShadowImage:[UIImage imageNamed:@"tabbar_bottom_shadow.png"]];
    [self.view addSubview:aTabbar];
    
    
    
    
    // MAIN CONTENT - WEB VIEW
    // =====
    UIWebView *mainContentWewView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight))];
    [mainContentWewView setBackgroundColor:[UIColor clearColor]];
    [mainContentWewView setOpaque:NO];
    [mainContentWewView setDelegate:self];
    [mainContentWewView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ABOUTURL]]];
    [self.view addSubview:mainContentWewView];
    
    
    // for test only:
    // log user agent apply for this web view
    //NSString *userAgent = [mainContentWewView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    //NSLog(@"userAgent: %@", userAgent);
    
    
    
    
    // LOADING VIEW (popup nho nho de user biet la dang load)
    // =====
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setFrame:CGRectMake(280, 10, 30, 30)];
    [activityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [activityIndicator.layer setCornerRadius:5];
    [activityIndicator setHidden:YES];
    [aTabbar addSubview:activityIndicator];
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
}


#pragma mark - Button delegate

-(void) menuButtonClick{
    [ManageSize showMainMenu];
}


#pragma mark - Web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator setHidden:NO];
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = [request URL];
    if(UIWebViewNavigationTypeLinkClicked == navigationType)
    {
        [[UIApplication sharedApplication] openURL:url];
        return NO;
    }
    
    return YES;
}


@end
