//
//  GalleryFlowSmallImage.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "GalleryFlowSmallImage.h"

@implementation GalleryFlowSmallImage

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(30, 30);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    
    return self;
}

// resize to real size
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height + 60);
}
@end
