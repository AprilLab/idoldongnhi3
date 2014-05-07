//
//  AUICarousel.m
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 5/4/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AUICarousel.h"

@implementation AUICarousel

@synthesize images;

- (void)setImages:(NSArray *)newImages
{
    if (newImages != images)
    {
        images = newImages;
        [self setup];
    }
}

#pragma mark - Carousel setup

- (void)setup
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 64, 280, 250)];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setScrollEnabled:YES];
    
    CGSize scrollViewSize = scrollView.frame.size;
    
    for (NSInteger i = 0; i < [self.images count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        [imageView setImage:[self.images objectAtIndex:i]];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
        [scrollView addSubview:imageView];
    }
    
    
    [scrollView setContentSize:CGSizeMake(scrollViewSize.width * [self.images count], scrollViewSize.height)];
    
    [self addSubview:scrollView];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(sliderImages) userInfo:nil repeats:YES];
}



-(void)sliderImages
{
    if (currentSlide==0) {
        currentSlide++;
    }else if(currentSlide==[images count]){
        currentSlide=0;
    }

    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * currentSlide, 0) animated:YES];
    currentSlide++;
}

#pragma scrollview delegate

- (UIScrollView *) scrollView {
    CGFloat currentOffset = self.scrollView.contentOffset.x;
    if(currentOffset >= self.scrollView.contentSize.width){
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.bounds.size.height) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(currentOffset, self.scrollView.bounds.size.height) animated:YES];
    }
    return self.scrollView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
