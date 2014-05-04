//
//  ScheduleViewFlowLayout.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ScheduleViewFlowLayout.h"

@implementation ScheduleViewFlowLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(46, 60);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 1.0f;
    self.minimumLineSpacing = 1.0f;
    
    return self;
}

@end
