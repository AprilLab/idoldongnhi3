//
//  GalleryFlowLargeImage.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "GalleryFlowLargeImage.h"

#define kNumberOfItemsPerPage 19

#define kColumnWidth 78
#define kRowHeight 76
#define kPadding 1

#define kLargeCellWidth 156
#define kLargeCellHeight 152


@implementation GalleryFlowLargeImage
-(id)init
{
    if (!(self = [super init])) return nil;
    
    // self.itemSize = CGSizeMake(106, 100);
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    
    return self;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height + 60);
}

@end
