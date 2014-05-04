//
//  GalleryPhotoCell.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "GalleryPhotoCell.h"
@interface GalleryPhotoCell()
{
    UIImageView *thumbnailImageView;
}

@end

@implementation GalleryPhotoCell

/*
- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)), 5, 5)];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:self.imageView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}

-(void)prepareForReuse
{
    [self setImage:nil];
}

- (void)setInfo:(NSDictionary *)info
{
    
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}
 */


- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    // BACKGROUND
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
    // THUMBNAIL IMAGE
    // =====
    if(thumbnailImageView == NULL)
    {
        thumbnailImageView = [[UIImageView alloc] init];
        [thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
        [thumbnailImageView setClipsToBounds:YES];
        [thumbnailImageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth ];
        [self addSubview:thumbnailImageView];
    }
    UIImage *image = (UIImage *)[info objectForKey:@"image"];
    [thumbnailImageView setFrame:CGRectMake(3, 3, self.frame.size.width - 6, self.frame.size.height - 6)];
    [thumbnailImageView setImage:image];
    
}


@end
