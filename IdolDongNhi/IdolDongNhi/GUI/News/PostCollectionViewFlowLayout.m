//
//  PostCollectionViewFlowLayout.m
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "PostCollectionViewFlowLayout.h"

@implementation PostCollectionViewFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(300, 175);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 10;
    
    return self;
}


@end
