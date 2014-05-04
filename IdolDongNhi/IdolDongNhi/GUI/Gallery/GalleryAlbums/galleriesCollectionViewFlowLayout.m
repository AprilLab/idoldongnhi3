//
//  GalleriesCollectionViewFlowLayout.m
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "GalleriesCollectionViewFlowLayout.h"

@implementation GalleriesCollectionViewFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(310, 210);
    self.sectionInset = UIEdgeInsetsMake(8, 5, 8, 5);
    self.minimumLineSpacing = 8;
    
    return self;
}


@end
