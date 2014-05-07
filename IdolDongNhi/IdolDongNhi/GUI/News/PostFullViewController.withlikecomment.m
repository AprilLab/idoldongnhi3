//
//  PostFullViewController.m
//  ParallaxImages
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "PostFullViewController.h"
#import "AUIExpandableTextView.h"

@interface PostFullViewController ()

@end

@implementation PostFullViewController


- (void)setImage:(UIImage *)image content:(NSString *)content like:(int)like comment:(int)comment
{
    [self.view setClipsToBounds:YES];
    [self.view setTintColor:[UIColor whiteColor]];
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:15];
    UIFont *fontBold = [UIFont fontWithName:@"OpenSans-Bold" size:15];
    
    
    // BACKGROUND
    // =====
    [self.view setBackgroundColor:[UIColor blackColor]];
    bgImageView = [[UIImageView alloc] initWithImage:image];
    
    // tinh toan lai kich thuoc cho phu hop
    bgImageView.frame = self.view.frame;
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIScrollView *scrollBgImageView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollBgImageView setMaximumZoomScale:2];
    [scrollBgImageView setDelegate:self];
    [self.view addSubview:scrollBgImageView];
    [scrollBgImageView addSubview:bgImageView];
    
    
    // add them inset shadow bottom
    UIImageView *bgImageBottomShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_shadow_inset_darker.png"]];
    bgImageBottomShadowView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    bgImageBottomShadowView.contentMode = UIViewContentModeBottom;
    [self.view addSubview:bgImageBottomShadowView];
    
    
    // BACK BUTTON
    // =====
    UIImage *backButtonImage = [UIImage imageNamed:@"back.png"];
    UIButton *backButtonClick = [[UIButton alloc] initWithFrame:CGRectMake(16, 32, backButtonImage.size.width, backButtonImage.size.height)];
    
    [backButtonClick setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButtonClick addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButtonClick];
    
    
    // ICON LIKE
    // =====
    UIImage *icon_heart = [UIImage imageNamed:@"icon_heart_20x20"];
    UIImageView *imageHeartView = [[UIImageView alloc] initWithImage:icon_heart];
    //[imageHeartView setBackgroundColor:[UIColor blackColor]];
    imageHeartView.frame = CGRectMake(235, self.view.frame.size.height - 20 /*image height*/  - 23 /*bottom margin*/, icon_heart.size.width, icon_heart.size.height);
    //[self.view addSubview:imageHeartView];
    
    
    // ICON COMMENT
    // =====
    UIImage *icon_comment = [UIImage imageNamed:@"icon_comment_20x20"];
    UIImageView *imageCommentView = [[UIImageView alloc] initWithImage:icon_comment];
    //[imageCommentView setBackgroundColor:[UIColor blackColor]];
    imageCommentView.frame = CGRectMake(285, self.view.frame.size.height - 20 /*image height*/  - 23 /*bottom margin*/, icon_heart.size.width, icon_heart.size.height);
    //[self.view addSubview:imageCommentView];
    
    
    // TEXT LIKE (total like)
    // ====
    UILabel *totalLikeView = [[UILabel alloc] init];
    totalLikeView.frame = CGRectMake(220, self.view.frame.size.height - 15 /*height*/  - 6 /*bottom margin*/, 50, 15);
    //[totalLikeView setBackgroundColor:[UIColor redColor]];
    [totalLikeView setTextAlignment:NSTextAlignmentCenter];
    [totalLikeView setTextColor:[UIColor whiteColor]];
    [totalLikeView setFont:fontBold];
    [totalLikeView setText:[NSString stringWithFormat:@"%i", like]];
    [self.view addSubview:totalLikeView];
    
    
    // TEXT COMMENT (total comment)
    // ====
    UILabel *totalCommentView = [[UILabel alloc] init];
    totalCommentView.frame = CGRectMake(270, self.view.frame.size.height - 15 /*height*/  - 6 /*bottom margin*/, 50, 15);
    //[totalCommentView setBackgroundColor:[UIColor redColor]];
    [totalCommentView setTextAlignment:NSTextAlignmentCenter];
    [totalCommentView setTextColor:[UIColor whiteColor]];
    [totalCommentView setFont:fontBold];
    [totalCommentView setText:[NSString stringWithFormat:@"%i", comment]];
    [self.view addSubview:totalCommentView];
    

    
    // CONTENT (Expandable TextView)
    // =====
    
    contentView = [[AUIExpandableTextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40 /*text height*/  - 40  /*bottom margin*/, 320, 40) andMaxHeight:200];
    [contentView setTextContainerInset:UIEdgeInsetsMake(0, 4, 0, 4)];
    [contentView setTextColor:[UIColor whiteColor]];
    [contentView setFont:fontRegular];
    [contentView setText:content];
    //[contentView setTextShadowColor:[UIColor blackColor] offset:CGSizeMake(1, 1)];
    
    // render lai
    [contentView render];
    [self.view addSubview:contentView];
    
    
    
}


#pragma mark - Button delegate

- (void) backButtonClick: (UIButton *) button{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Scroll delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return bgImageView;
}

@end
