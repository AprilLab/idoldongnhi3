//
//  GalleryAlbumsCell.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "GalleryAlbumsCell.h"

@interface GalleryAlbumsCell ()
{
    UIImageView *thumbnailImageView;
    UIImageView *bgImageBottomShadowView;
    UILabel *nameView;
}

@end

@implementation GalleryAlbumsCell

- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    UIFont *fontBold = [UIFont fontWithName:@"OpenSans-Bold" size:14];
    
    
    // BACKGROUND
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
    // THUMBNAIL IMAGE
    // =====
    if(thumbnailImageView == NULL)
    {
        thumbnailImageView = [[UIImageView alloc] init];
        [thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
        [thumbnailImageView setClipsToBounds:YES];
        [self addSubview:thumbnailImageView];
    }
    UIImage *image = (UIImage *)[info objectForKey:@"image"];
    // tinh toan lai kich thuoc cho phu hop
    float bgImageViewWidth = 300;
    float bgImageViewHeight = bgImageViewWidth * image.size.height / image.size.width;
    [thumbnailImageView setFrame:CGRectMake(5, 5, bgImageViewWidth, bgImageViewHeight)];
    [thumbnailImageView setImage:image];
    
    // add them inset shadow bottom
    if(bgImageBottomShadowView == NULL)
    {
        bgImageBottomShadowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_shadow_inset.png"]];
        [bgImageBottomShadowView setContentMode:UIViewContentModeBottom];
        [bgImageBottomShadowView setClipsToBounds:YES];
        [self addSubview:bgImageBottomShadowView];
    }
    [bgImageBottomShadowView setFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
    
    
    // NAME
    // =====
    if(nameView == NULL)
    {
        nameView = [[UILabel alloc] init];
        [nameView setTextColor:[UIColor whiteColor]];
        [nameView setFont:fontBold];
        [nameView setNumberOfLines:0];
        [self addSubview:nameView];
    }
    NSString *name = (NSString *)[info objectForKey:@"name"];
    [nameView setFrame:CGRectMake(10, self.frame.size.height - 40 /*text height*/  - 10 /*bottom margin*/, 240, 40)];
    [nameView setText:name];
    
    
}


+ (CGSize)sizeForCellWithImage:(UIImage *)image
{
    // image se duoc resize theo chieu ngang
    // tuc la chieu ngang se la 300px, chieu doc se duoc co dan ra
    
    // tinh toan lai kich thuoc cho phu hop
    float imageWidth = 300;
    float imageHeight = imageWidth * image.size.height / image.size.width;
    
    return CGSizeMake(imageWidth + 10, imageHeight + 10);
}



@end
