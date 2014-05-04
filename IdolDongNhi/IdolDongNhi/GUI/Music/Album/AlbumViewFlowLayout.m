//
//  AlbumViewFlowLayout.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AlbumViewFlowLayout.h"

@implementation AlbumViewFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(90, 120);
    self.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    return self;
}

@end
