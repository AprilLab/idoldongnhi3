//
//  VideoDetailController.m
//  April
//
//  Created by admin on 4/20/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "VideoDetailController.h"
#import "HCYoutubeParser.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"
#import <objc/message.h>

@interface VideoDetailController ()

@end

@implementation VideoDetailController

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad{
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
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    // TITLE
    // =====
    self.navigationItem.title = @"VIDEO";
    
    
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
    
    
    
    // TITLE OF VIDEO
    // =====
    UILabel *titleVideo = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    [titleVideo setFont:[UIFont fontWithName:@"OpenSans-Bold" size:14]];
    [titleVideo setText:(NSString *)[videoInfo objectForKey:@"title"]];
    [titleVideo setTextColor:[UIColor whiteColor]];
    [titleVideo setNumberOfLines:0];
    [titleVideo setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleVideo];
    
    
    
    // ADD VIDEO VIA WEBWIEW
    // =====
    
    // LINK DATA VIDEO
    NSString *link = (NSString *)[videoInfo objectForKey:@"link"];
    
    // YOUTUBE ID WILL BE PARSED THEN RECEIVE LINK
    NSString *videoId = [HCYoutubeParser youtubeIDFromYoutubeURL:[NSURL URLWithString:link]];
    
    // CREATE DEFINE STRING WITH PARAMETER IS YOUTUBE ID
    // UPDATE
    // PARAM WITH WIDHT AND HEIGHT
    
    
    // static NSString *youTubeVideoHTML = @"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head><body style=\"background:#000;margin-top:0px;margin-left:0px\"><div><object width=\"320\" height=\"240\"><embed src=\"http://www.youtube.com/v/%@\"type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"%f\" height=\"%f\"></embed></object></div></body></html>";
    
    static NSString *youTubeVideoHTML2 = @"<html><body style='margin:0px;padding:0px;'><script type='text/javascript'src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo(); }</script><iframe id='playerId' type='text/html' width='%f' height='%f'src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&controls=1&showinfo=1' frameborder='0'></body></html>";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, 320, 240)];
    [webView setAllowsInlineMediaPlayback:NO];
    [webView setMediaPlaybackRequiresUserAction:NO];
    
    [webView loadHTMLString:[NSString stringWithFormat:youTubeVideoHTML2, webView.frame.size.width, webView.frame.size.height, videoId]  baseURL:[[NSBundle mainBundle] resourceURL]];
    [webView setDelegate:self];
    [self.view addSubview:webView];
    
    
    
    
    
    // LOADING VIEW (popup nho nho de user biet la dang load)
    // =====
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setFrame:CGRectMake(145, 150, 30, 30)];
    [activityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [activityIndicator.layer setCornerRadius:5];
    [activityIndicator setHidden:YES];
    [aTabbar addSubview:activityIndicator];
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator setHidden:NO];
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
    [activityIndicator setHidden:YES];
}

#pragma mark - Button delegate

-(void) menuButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setItemInfo:(NSDictionary *)info
{
    videoInfo = info;
}


@end
