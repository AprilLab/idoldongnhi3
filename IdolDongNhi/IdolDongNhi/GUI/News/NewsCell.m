//
//  NewsCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "NewsCell.h"
#import "ManageSize.h"
#import "UIImageView+AWebCache.h"

@interface NewsCell ()
{
    UIImageView *thumbnailImageView;
    UILabel *titleView;
}

@end

@implementation NewsCell

- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    UIFont *fontBold = [UIFont fontWithName:@"OpenSans-Bold" size:15];
    
    
    // BACKGROUND
    // set background khac nhau cho so chan va so le
    NSInteger index = [(NSString *)[info objectForKey:@"index"] integerValue];
    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha: (index % 2 == 0) ? 0.04 : 0]];
    
    
    // THUMBNAIL IMAGE
    // =====
    if(thumbnailImageView == NULL)
    {
        thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 60)];
        [thumbnailImageView setContentMode:UIViewContentModeScaleAspectFill];
        [thumbnailImageView setClipsToBounds:YES];
        [self addSubview:thumbnailImageView];
    }
    NSString *imageSource = (NSString *)[info objectForKey:@"imageSource"];
    [thumbnailImageView loadImageWithURLString:imageSource placeholderImage:nil];
    
    
    // TITLE
    // =====
    if(titleView == NULL)
    {
        titleView = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 200, 70)];
        [titleView setTextColor:[UIColor whiteColor]];
        [titleView setFont:fontBold];
        [titleView setNumberOfLines:0];
        [self addSubview:titleView];
    }
    NSString *title = (NSString *)[info objectForKey:@"title"];
    [titleView setText:title];
    
}



@end
