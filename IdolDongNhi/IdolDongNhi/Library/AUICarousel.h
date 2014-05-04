//
//  AUICarousel.h
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 5/4/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUICarousel : UIView<UIScrollViewDelegate>{
    NSArray *images;
    int currentSlide;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) NSArray *images;

- (void)setup;
@end
