//
//  ScheduleDetailViewFlowLayout.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ScheduleDetailViewFlowLayout.h"

@implementation ScheduleDetailViewFlowLayout
-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(280, 60);
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    
    return self;
}


@end
