//
//  GalleryAlbumsCell.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_HEIGHT 250
#define IMAGE_OFFSET_SPEED 30

@interface GalleryAlbumsCell : UICollectionViewCell

- (void)setInfo:(NSDictionary *)info;
+ (CGSize)sizeForCellWithImage:(UIImage *)image;

@end
