//
//  ParallaxCollectionViewFlow.m
//  ParallaxImages
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "ParallaxCollectionViewFlow.h"

@implementation ParallaxCollectionViewFlow

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(320, 160);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing = 0.0f;
    
    return self;
}


@end
