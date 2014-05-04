//
//  ScheduleDetailControllerViewController.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleDetailControllerViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate>

@property NSUInteger pageIndex;
@property (nonatomic, strong) NSMutableDictionary *monthData;
@property (nonatomic, strong) NSMutableArray *daysData;
@property (nonatomic, strong) NSMutableArray *eventsData;

@end
