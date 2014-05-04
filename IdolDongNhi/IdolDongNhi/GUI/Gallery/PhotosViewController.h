//
//  AprilPhotosViewController.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, strong) NSMutableArray *photosGallery;
@property int currentPhotoId;
@property (nonatomic, strong) NSString *photoGalleryName;
@end
