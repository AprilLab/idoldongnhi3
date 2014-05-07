//
//  MJCollectionViewCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "PostCell.h"

@interface PostCell ()
{
    UIImageView *bgImageView;
    UIImageView *bgImageBottomShadowView;
    UILabel *contentView;
    UIImageView *imageHeartView;
    UIImageView *imageCommentView;
    UILabel *totalLikeView;
    UILabel *totalCommentView;
}

@end

@implementation PostCell

- (void)setImage:(UIImage *)image content:(NSString *)content like:(int)like comment:(int)comment
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:14];
    UIFont *fontBold = [UIFont fontWithName:@"OpenSans-Bold" size:15];

    
    // BACKGROUND
    // =====
    [self setBackgroundColor:[UIColor blackColor]];
    
    if(bgImageView == NULL)
    {
        bgImageView = [[UIImageView alloc] init];
        [self addSubview:bgImageView];
    }
    // tinh toan lai kich thuoc cho phu hop
    float bgImageViewWidth = self.frame.size.width;
    float bgImageViewHeight = bgImageViewWidth * image.size.height / image.size.width;
    [bgImageView setFrame:CGRectMake(0, 0, bgImageViewWidth, bgImageViewHeight)];
    [bgImageView setImage:image];
    
    // add them inset shadow bottom
    if(bgImageBottomShadowView == NULL)
    {
        bgImageBottomShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_shadow_inset.png"]];
        bgImageBottomShadowView.contentMode = UIViewContentModeBottom;
        [self addSubview:bgImageBottomShadowView];
    }
    [bgImageBottomShadowView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    // CONTENT
    // =====
    if(contentView == NULL)
    {
        contentView = [[UILabel alloc] init];
        [contentView setTextColor:[UIColor whiteColor]];
        [contentView setFont:fontRegular];
        [contentView setNumberOfLines:0];
        [self addSubview:contentView];
    }
    [contentView setFrame:CGRectMake(4, self.frame.size.height - 40 /*text height*/  - 4 /*bottom margin*/, 195, 40)];
    [contentView setText:content];
    
    
    // ICON LIKE
    // =====
    if(imageHeartView == NULL)
    {
        UIImage *icon_heart = [UIImage imageNamed:@"icon_heart_20x20"];
        imageHeartView = [[UIImageView alloc] initWithImage:icon_heart];
        [self addSubview:imageHeartView];
    }
    [imageHeartView setFrame:CGRectMake(215, self.frame.size.height - 20 /*image height*/  - 23 /*bottom margin*/, 20, 20)];
    
    
    
    // ICON COMMENT
    // =====
    if(imageCommentView == NULL)
    {
        UIImage *icon_comment = [UIImage imageNamed:@"icon_comment_20x20"];
        imageCommentView = [[UIImageView alloc] initWithImage:icon_comment];
        [self addSubview:imageCommentView];
    }
    [imageCommentView setFrame:CGRectMake(265, self.frame.size.height - 20 /*image height*/  - 23 /*bottom margin*/, 20, 20)];
    
    
    // TEXT LIKE (total like)
    // ====
    if(totalLikeView == NULL)
    {
        totalLikeView = [[UILabel alloc] init];
        [totalLikeView setTextAlignment:NSTextAlignmentCenter];
        [totalLikeView setTextColor:[UIColor whiteColor]];
        [totalLikeView setFont:fontBold];
        
        [self addSubview:totalLikeView];
    }
    [totalLikeView setFrame:CGRectMake(200, self.frame.size.height - 15 /*height*/  - 6 /*bottom margin*/, 50, 15)];
    [totalLikeView setText:[NSString stringWithFormat:@"%i", like]];
    
    
    // TEXT COMMENT (total comment)
    // ====
    if(totalCommentView == NULL)
    {
        totalCommentView = [[UILabel alloc] init];
        [totalCommentView setTextAlignment:NSTextAlignmentCenter];
        [totalCommentView setTextColor:[UIColor whiteColor]];
        [totalCommentView setFont:fontBold];
        [self addSubview:totalCommentView];
    }
    [totalCommentView setFrame:CGRectMake(250, self.frame.size.height - 15 /*height*/  - 6 /*bottom margin*/, 50, 15)];
    [totalCommentView setText:[NSString stringWithFormat:@"%i", comment]];
    
}


+ (CGSize)sizeForCellWithImage:(UIImage *)image
{
    // image se duoc resize theo chieu ngang
    // tuc la chieu ngang se la 320px, chieu doc se duoc co dan ra
    
    // tinh toan lai kich thuoc cho phu hop
    float width = 300;
    float height = width * image.size.height / image.size.width;
    
    return CGSizeMake(width, height);
}



@end
