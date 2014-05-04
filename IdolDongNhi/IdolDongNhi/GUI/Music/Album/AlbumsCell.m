//
//  AlbumsCell.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AlbumsCell.h"
#import "UIImageView+AWebCache.h"

@interface AlbumsCell ()
{
    UIImageView *thumbnailImageView;
    UIImageView *backgroundImageView;
    UILabel *nameView;
}

@end

@implementation AlbumsCell

- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:12];
    
    NSInteger index = [(NSString *)[info objectForKey:@"index"] intValue];
    
    
    // BACKGROUND (la icon disk)
    // =====
    [self setBackgroundColor:[UIColor clearColor]];
    if(backgroundImageView == NULL)
    {
        backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_disk_72x72.png"]];
        [backgroundImageView setFrame:CGRectMake(0, 0, 90, 76)];
        [backgroundImageView setContentMode:UIViewContentModeRight];
        [backgroundImageView setClipsToBounds:YES];
        [self addSubview:backgroundImageView];
    }
    // trong truong hop album dau tien thi se hide di
    [backgroundImageView setHidden:(index == 0)];
    
    
    // THUMBNAIL IMAGE
    // =====
    if(thumbnailImageView == NULL)
    {
        thumbnailImageView = [[UIImageView alloc] init];
        [thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
        [thumbnailImageView setClipsToBounds:YES];
        [self addSubview:thumbnailImageView];
    }
    // trong truong hop album dau tien thi se hien thi to dep
    [thumbnailImageView setFrame: (index == 0) ? CGRectMake(0, 0, 290, 290) : CGRectMake(0, 0, 76, 76)];
    
    NSString *imageSource = (NSString *)[info objectForKey:@"imageSource"];
    [thumbnailImageView loadImageWithURLString:imageSource placeholderImage:[UIImage new]];
    
    
    // NAME
    // =====
    if(nameView == NULL)
    {
        nameView = [[UILabel alloc] init];
        [nameView setFrame:CGRectMake(0, 76, 76, 40)];
        [nameView setTextColor:[UIColor whiteColor]];
        [nameView setFont:fontRegular];
        [nameView setNumberOfLines:0];
        [self addSubview:nameView];
    }
    // trong truong hop album dau tien thi se hide di
    [nameView setHidden:(index == 0)];
    
    NSString *name = (NSString *)[info objectForKey:@"name"];
    [nameView setText:name];
    
    
}


+ (CGSize)sizeForCellWithIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return CGSizeMake(290, 300);

    return CGSizeMake(90, 115);
}


@end
