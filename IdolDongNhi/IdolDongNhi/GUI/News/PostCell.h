//
//  MJCollectionViewCell.h
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UICollectionViewCell

- (void)setImage:(UIImage *)image content:(NSString *)content like:(int)like comment:(int)comment;
+ (CGSize)sizeForCellWithImage:(UIImage *)image;

@end
