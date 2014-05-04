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
    self.navigationItem.title = self.photoGalleryName;
    
    
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
    
    
    
    // Do any additional setup after loading the view.
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight))];
    
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    
    CGRect innerScrollFrame = self.mainScrollView.bounds;
    
    for(NSDictionary *photoItem in self.photosGallery){
        UIImageView *imageForZooming = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height)];
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
        pageScrollView.maximumZoomScale = 5.0f;
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
}

- (void) menuButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIScrollView *) scrollView {
    CGFloat currentOffset = self.mainScrollView.contentOffset.x;
    if(currentOffset >= self.mainScrollView.contentSize.width){
        [self.mainScrollView setContentOffset:CGPointMake(0, self.mainScrollView.bounds.size.height) animated:YES];
    }else{
        [self.mainScrollView setContentOffset:CGPointMake(currentOffset, self.mainScrollView.bounds.size.height) animated:YES];
    }
    return self.mainScrollView;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:100];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
