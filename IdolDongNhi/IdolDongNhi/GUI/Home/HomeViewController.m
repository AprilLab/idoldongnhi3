//
//  HomeViewController.m
//  April
//
//  Created by admin on 4/22/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "HomeViewController.h"
#import "SliderContentController.h"
#import "MainMenuViewController.h"
#import "PlayingMusicView.h"
#import "AUIFreedomController.h"
#import "ManageSize.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
UIImageView *imgThumb;
UILabel *lblNews;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setClipsToBounds:YES];
    
    
    // BACKGROUND
    // ======
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    [bgImageView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    
    

    // get data for homepage
    [self getDataHomepage];
    
    
    
    // SLIDER
    // ======
    AUICarousel *carousel = [[AUICarousel alloc] initWithFrame:CGRectMake(0, 120, 320, [[AUIFreedomController sharedFreedomController] getHeight] - 80 - 120)];
    [carousel setImages:imagesSlider];
    [self.view addSubview:carousel];
    
    UITapGestureRecognizer *tapCarousel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGallery:)];
    [carousel addGestureRecognizer:tapCarousel];
    
    
    
    // MOVING IMAGES
    // ======
    AUIMovingImages *movingImages = [[AUIMovingImages alloc] initWithFrame:CGRectMake(0, [[AUIFreedomController sharedFreedomController] getHeight] - 80, 320, 80)];
    movingImages.isMovingImage = YES;
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:12];
    movingImages.font = fontRegular;
    [movingImages setImage:movingImage andText:movingLabel];
    [self.view addSubview:movingImages];
    UITapGestureRecognizer *tapMovingView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDongNhiNews:)];
    [movingImages addGestureRecognizer:tapMovingView];
    
    
    
    // TITLE: DONG NHI
    // ======
    UILabel *lblTitle= [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 320, 80)];
    lblTitle.font = [UIFont fontWithName:@"UTM Bitsumishi Pro" size:40];
    lblTitle.textColor= [UIColor whiteColor];
    lblTitle.textAlignment= NSTextAlignmentCenter;
    lblTitle.text= @"ĐÔNG NHI";
    [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.view addSubview:lblTitle];
    
    
    
    // MENU BUTTON
    // ======
    
    UIImage *buttonImage = [UIImage imageNamed:@"menu-nav-transparent-border.png"];
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 23, buttonImage.size.width, buttonImage.size.height)];
    
    [menuButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButton];

}

- (void) showGallery:(UITapGestureRecognizer *)gesture{
    AUIFreedomController *sharedFreedomController = [AUIFreedomController sharedFreedomController];
    AUIFreedomController *mainWrapper = [sharedFreedomController getChildViewControllerWithName:@"mainWrapper"];
    
    [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"galleryView"] view]];
    
}

- (void) showDongNhiNews: (UITapGestureRecognizer *) gesture{
    AUIFreedomController *sharedFreedomController = [AUIFreedomController sharedFreedomController];
    AUIFreedomController *mainWrapper = [sharedFreedomController getChildViewControllerWithName:@"mainWrapper"];
    
    [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"newsView"] view]];
}

- (void) getDataHomepage
{
    imagesSlider = [[NSMutableArray alloc] init];
    NSDictionary *listhomepageDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:@"home"];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Connect 3g or Wifi then try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    if(listhomepageDictionary == NULL){
        [alertView show];
        return;
    }
    
    // check code return
    NSString *code = (NSString *)[listhomepageDictionary objectForKey:@"code"];
    if([code intValue] != 200){
        [alertView show];
        return;
    }
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listhomepageDictionary objectForKey:@"data"];
    if(data == NULL){
        [alertView show];
        return;
    }
    
    // get 1 so thu trong data

    NSArray *randomPhotos = (NSArray *)[data objectForKey:@"randomphotos"];
    
    for(NSDictionary *listimageItem in randomPhotos)
    {
        id        imageObj      = [listimageItem objectForKey:@"image"];
        NSString *imageSource   = (imageObj != [NSNull null]) ? [(NSDictionary *)imageObj objectForKey:@"source"] : NULL;
        
        // download image from server
        UIImage *image = (imageSource != NULL) ? [ManageSize getImageFromServer:imageSource] : [UIImage new];
        
        // create new item dictionary
        // NSDictionary *APIListpostListpostItem = @{@"image": image};
        
        // add to current list
        [imagesSlider addObject:image];
        
    }
    
    NSArray *lastPost = (NSArray *)[data objectForKey:@"lastposts"];
    if([lastPost count] > 0){
        for(NSDictionary *listpostItem in lastPost)
        {
            id        imageObj      = [listpostItem objectForKey:@"image"];
            NSString *imageSource   = (imageObj != [NSNull null]) ? [(NSDictionary *)imageObj objectForKey:@"source"] : NULL;
            
            NSString *content = [listpostItem objectForKey:@"content"];
            // download image from server
            UIImage *image = (imageSource != NULL) ? [ManageSize getImageFromServer:imageSource] : [UIImage new];
            movingImage = image;
            movingLabel = content;
            //NSLog(@"movingLabel %@", movingLabel);
            break;
        }
    }
    
}

-(void) menuButtonClick:(id)sender
{
    [ManageSize showMainMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
