//
//  PostFullViewController.h
//  ParallaxImages
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUIExpandableTextView.h"

@interface PostFullViewController : UIViewController<UIScrollViewDelegate>
{
    UIImageView *bgImageView;
    
    AUIExpandableTextView *contentView;
}

- (void)setImage:(UIImage *)image content:(NSString *)content like:(int)like comment:(int)comment;

@end
