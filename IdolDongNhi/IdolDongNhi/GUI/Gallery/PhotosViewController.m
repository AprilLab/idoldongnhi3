//
//  AprilPhotosViewController.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "PhotosViewController.h"
#import "GalleryPhotosController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"

const int kGalleryImageWidth = 320;
const int kGallerySpaceBetweenImage = 0;


@interface PhotosViewController (){
    
    CGFloat scrollSize;
    NSDate *starTime;
    BOOL isHide;
}

@end

@implementation PhotosViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // bat dau khoi tao giao dien
    [self.view setClipsToBounds:YES];
    [self.view setTintColor:[UIColor whiteColor]];
    
    //UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:15];
    //UIFont *fontBold = [UIFont fontWithName:@"OpenSans-Bold" size:15];

    
    // BACKGROUND COLOR
    // =====
    [self.view setBackgroundColor:[UIColor blackColor]];

    
    
    // BACK BUTTON
    // =====
    UIImage *backButtonImage = [UIImage imageNamed:@"back_49x49.png"];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 20, backButtonImage.size.width, backButtonImage.size.height)];
    
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    
    
    // MAIN SCROLL VIEW
    // =====
    // scroll view de show ra hinh anh
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    
    CGRect innerScrollFrame = self.mainScrollView.bounds;
    
    for(NSDictionary *photoItem in self.photosGallery)
    {
        UIImageView *imageForZooming = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageForZooming.image = [photoItem objectForKey:@"image"];
        imageForZooming.tag = 100;
        [imageForZooming setContentMode:UIViewContentModeScaleAspectFit];
        
        /* trasition */
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionFade; // there are other types but this is the nicest
        transition.duration = 0.34; // set the duration that you like
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [imageForZooming.layer addAnimation:transition forKey:nil];
        
        UIScrollView *pageScrollView = [[UIScrollView alloc]
                                        initWithFrame:innerScrollFrame];
        
        //[pageScrollView setContentMode:UIViewContentModeScaleAspectFit];
        pageScrollView.minimumZoomScale = 1.0f;
        pageScrollView.maximumZoomScale = 2.0f;
        pageScrollView.zoomScale = 1.0f;
        pageScrollView.contentSize = imageForZooming.bounds.size;
        pageScrollView.delegate = self;
        pageScrollView.showsHorizontalScrollIndicator = NO;
        pageScrollView.showsVerticalScrollIndicator = NO;
        [pageScrollView addSubview:imageForZooming];
        
        [self.mainScrollView addSubview:pageScrollView];
        
        innerScrollFrame.origin.x += innerScrollFrame.size.width;
    }
    
    scrollSize = innerScrollFrame.origin.x;
    self.mainScrollView.contentSize = CGSizeMake(innerScrollFrame.origin.x, self.mainScrollView.bounds.size.height);
    
    [self.view addSubview:self.mainScrollView];
    
    isHide = YES;
    
    
    // UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideOutOfView)];
    // [self.view addGestureRecognizer:tapGesture];
    
    // update to current selected
    
    [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.frame.size.width * self.currentPhotoId, 0) animated:YES];
    
    
    // bring back button too top
    [self.view bringSubviewToFront:backButton];
}

- (void) viewDidAppear:(BOOL)animated
{
    // hide status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void) viewWillDisappear:(BOOL)animated
{
    // tra status bar ve lai nhu cu
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}


#pragma mark - Button delegate

- (void) backButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Scroll delegate

- (UIScrollView *) scrollView
{
    CGFloat currentOffset = self.mainScrollView.contentOffset.x;
    if(currentOffset >= self.mainScrollView.contentSize.width)
    {
        [self.mainScrollView setContentOffset:CGPointMake(0, self.mainScrollView.bounds.size.height) animated:YES];
    }else{
        [self.mainScrollView setContentOffset:CGPointMake(currentOffset, self.mainScrollView.bounds.size.height) animated:YES];
    }
    return self.mainScrollView;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:100];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
