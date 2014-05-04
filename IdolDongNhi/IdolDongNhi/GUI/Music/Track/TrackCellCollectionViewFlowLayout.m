//
//  TrackCellCollectionViewFlowLayout.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "TrackCellCollectionViewFlowLayout.h"

@implementation TrackCellCollectionViewFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(320, 40);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    return self;
}
@end
