//
//  NewsCollectionViewFlowLayout.m
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "NewsCollectionViewFlowLayout.h"

@implementation NewsCollectionViewFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(320, 80);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumLineSpacing = 0;
    
    return self;
}


@end
