//
//  HomeViewController.h
//  April
//
//  Created by admin on 4/22/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUICarousel.h"
#import "AUIMovingImages.h"

@interface HomeViewController : UIViewController{
    NSMutableArray *imagesSlider;
    UIImage *movingImage;
    NSString *movingLabel;
}

@end
