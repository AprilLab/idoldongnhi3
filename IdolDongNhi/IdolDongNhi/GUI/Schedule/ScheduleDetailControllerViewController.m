//
//  ScheduleDetailControllerViewController.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ScheduleDetailControllerViewController.h"
#import "ScheduleCell.h"
#import "ScheduleDetailCell.h"
#import "ScheduleDetailViewFlowLayout.h"
#import "ScheduleViewFlowLayout.h"

@interface ScheduleDetailControllerViewController (){
    NSDictionary *_tableData;
    NSDictionary *_collectionData;
    ScheduleDetailCell *_scheduleCell;
    NSArray *days;
}

@end

@implementation ScheduleDetailControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = self.view.frame;
    
    
    
    // Collection View
    ScheduleViewFlowLayout *flow = [[ScheduleViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    
    self.schedulesCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, 320, 60) collectionViewLayout:flow];
    [self.schedulesCollectionView setDataSource:self];
    [self.schedulesCollectionView setDelegate:self];
    self.schedulesCollectionView.backgroundColor= [UIColor colorWithRed:42.0/255 green:14.0/255 blue:37/255.0 alpha:1];
    //self.schedulesCollectionView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarCellGroupBg"]];
    
    [self.schedulesCollectionView registerClass:[ScheduleCell class] forCellWithReuseIdentifier:@"cellIdentifier"];

    [self.view addSubview:self.schedulesCollectionView];

    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 60)];
    
    UIImage *image = [UIImage imageNamed:@"image001.jpg"];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    imageview.image = image;
    [scrollView addSubview:imageview];
    
    UIImage *image2 = [UIImage imageNamed:@"image002.jpg"];
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 100, 40)];
    imageview.image = image2;
    [scrollView addSubview:imageview2];
    
    UIImage *image3 = [UIImage imageNamed:@"image003.jpg"];
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 100, 40)];
    imageview3.image = image3;
    [scrollView addSubview:imageview3];
    
    UIImage *image4 = [UIImage imageNamed:@"image001.jpg"];
    UIImageView *imageview4 = [[UIImageView alloc] initWithFrame:CGRectMake(300, 0, 100, 40)];
    imageview4.image = image4;
    [scrollView addSubview:imageview4];
    
    [scrollView setContentSize:CGSizeMake(400, 40)];
    
    
    UIImage *imageTitle = [UIImage imageNamed:@"calendartitle"];
    UIImageView *imageviewTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    imageviewTitle.image = imageTitle;
    [self.view addSubview:imageviewTitle];
    
    self.lPageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
    self.lPageTitle.text= @"abc";
    self.lPageTitle.textAlignment= NSTextAlignmentCenter;
    [self.view addSubview:self.lPageTitle];
    self.lPageTitle.textColor= [UIColor whiteColor];
    [self.view bringSubviewToFront:self.lPageTitle];
    
    
    
    //[self.view addSubview:scrollView];
    
    _tableData = [[NSMutableDictionary alloc] init];
    
    NSArray *values1 = [NSArray arrayWithObjects:
                        @"San Khau Lan Anh",
                        @"San Khau Lan Anh 2",
                        @"San Khau Lan Anh 3",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        @"San Khau Lan Anh 4",
                        nil];
    
    NSArray *values2 = [NSArray arrayWithObjects:
                        @"7:00",
                        @"9:00",
                        @"10:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        @"11:00",
                        nil];
    _tableData = [NSDictionary dictionaryWithObjectsAndKeys:values1, @"location", values2, @"time", nil];
    
    
    days = [NSArray arrayWithObjects:
                     @"1/1",
                     @"1/10",
                     @"1/20",
                     @"1/21",
                     @"1/22",
                     @"1/23",
                     @"1/24",
                     @"1/25",
                     nil];
    NSLog(@"total row %d", [[_tableData valueForKey:@"location"] count]);
    
    
    
    
    
    self.scheduleDetailsTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height-160)];
    [self.scheduleDetailsTableView setDataSource:self];
    [self.scheduleDetailsTableView setDelegate:self];
    self.scheduleDetailsTableView.backgroundColor= [UIColor clearColor];
    self.scheduleDetailsTableView.separatorColor= [UIColor clearColor];
    [self.view addSubview:self.scheduleDetailsTableView];
    
}


#pragma monthly
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [days count];
}



- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ScheduleCell *cell = (ScheduleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.scheduleTimer = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, cell.frame.size.width, 60)];
    [cell.scheduleTimer setNumberOfLines:0];
    cell.scheduleTimer.text = @"1";
    cell.scheduleTimer.font = [UIFont fontWithName:@"Arial" size:22];
    cell.scheduleTimer.textColor= [UIColor whiteColor];
    cell.scheduleTimer.textAlignment= NSTextAlignmentCenter;
    [cell.contentView addSubview:cell.scheduleTimer];
    
    
    cell.scheduleTDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, cell.frame.size.width, 10)];
    [cell.scheduleTDay setNumberOfLines:0];
    cell.scheduleTDay.text = @"T1";
    cell.scheduleTDay.font = [UIFont fontWithName:@"Arial" size:14];
    cell.scheduleTDay.textColor= [UIColor whiteColor];
    cell.scheduleTDay.textAlignment= NSTextAlignmentCenter;
    [cell.contentView addSubview:cell.scheduleTDay];
    
    
    //cell.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"CalendarCellBg"]];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ScheduleDetailCell *cell = (ScheduleDetailCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor blackColor]];
    
    return YES;
}


NSIndexPath *_prevIndex;
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_prevIndex) {
        ScheduleDetailCell *preCell = (ScheduleDetailCell *)[collectionView cellForItemAtIndexPath:_prevIndex];
        [preCell setBackgroundColor:[UIColor colorWithRed:42.0/255 green:14.0/255 blue:37/255.0 alpha:1]];
        
    }
    ScheduleDetailCell *cell = (ScheduleDetailCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor colorWithRed:237.0/255 green:0 blue:140.0/255 alpha:1]];
    
    _prevIndex= indexPath;
}



#pragma scheduleDetail
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_tableData valueForKey:@"location"] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleDetailCell *cell = (ScheduleDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ScheduleTableCell"];
    if (cell == nil) {
        cell = [[ScheduleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScheduleTableCell"];
    }
    // Just want to test, so I hardcode the data
    cell.scheduleTitle.text = [[_tableData valueForKey:@"location"] objectAtIndex:indexPath.row];
    cell.scheduleDescription.text = [[_tableData valueForKey:@"time"] objectAtIndex:indexPath.row];
    cell.backgroundColor= [UIColor clearColor];
    if (!(indexPath.row%2)) {
        cell.backgroundColor= [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    }
    return cell;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %d row", indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}



- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
