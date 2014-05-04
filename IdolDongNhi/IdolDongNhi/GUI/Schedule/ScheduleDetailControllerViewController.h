//
//  ScheduleDetailControllerViewController.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleDetailControllerViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *schedulesCollectionView;
@property (nonatomic, strong) IBOutlet UITableView *scheduleDetailsTableView;

@property (nonatomic, strong) IBOutlet UILabel *lPageTitle;
@property (nonatomic, strong) NSString *pageTitle;
@property NSUInteger pageIndex;
@property (nonatomic, strong) NSMutableArray *schedules;
@property (nonatomic, strong) NSMutableArray *schedulesDetails;

@end
