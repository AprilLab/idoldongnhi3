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
#import "AUIFreedomController.h"
#import "PlayingMusicView.h"

@interface ScheduleDetailControllerViewController ()
{
    // UI
    UICollectionView *dayCollectionView;
    UITableView *eventTableView;
    
    // temp variable
    NSInteger currentSelectedDayIndex;
}

@end

@implementation ScheduleDetailControllerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // bat dau khoi tao giao dien
    [self.view setClipsToBounds:YES];
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:16];
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    
    
    // CAI DONG - THANG 01 NAM 2014...
    // =====
    UILabel *labelMonthYearText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [labelMonthYearText setText:[NSString stringWithFormat:@"Tháng %@ Năm %@", [self.monthData objectForKey:@"month"], [self.monthData objectForKey:@"year"]]];
    [labelMonthYearText setTextAlignment: NSTextAlignmentCenter];
    [labelMonthYearText setTextColor: [UIColor whiteColor]];
    [labelMonthYearText setBackgroundColor:myPinkColor];
    [labelMonthYearText setFont:fontRegular];
    [self.view addSubview:labelMonthYearText];
    
    
    // chen 1 cai image background cho cai thang collection view
    // de cho luon luon thay background nay
    UIImageView *dayCollectionViewBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 60)];
    [dayCollectionViewBackground setContentMode:UIViewContentModeRight];
    [dayCollectionViewBackground setImage:[UIImage imageNamed:@"bg_schedule_day_long_320x60.png"]];
    [self.view addSubview:dayCollectionViewBackground];
    
    
    // COLLECTION VIEW SHOW RA CAC NGAY TRONG THANG
    // =====
    ScheduleViewFlowLayout *flow = [[ScheduleViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    dayCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, 320, 60) collectionViewLayout:flow];
    [dayCollectionView setShowsHorizontalScrollIndicator:NO];
    [dayCollectionView setBackgroundColor:[UIColor clearColor]];
    
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [dayCollectionView registerClass:[ScheduleCell class] forCellWithReuseIdentifier:@"scheduleCellIdentifier"];
    
    [dayCollectionView setDataSource:self];
    [dayCollectionView setDelegate:self];
    [self.view addSubview:dayCollectionView];

        
    
    // TABLE SHOW RA CAC EVENT TRONG 1 NGAY
    // =====
    eventTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height-160)];
    [eventTableView setDataSource:self];
    [eventTableView setDelegate:self];
    [eventTableView setBackgroundColor: [UIColor clearColor]];
    [eventTableView setSeparatorColor: [UIColor clearColor]];
    [self.view addSubview:eventTableView];
    
    
    
    // shadow che cai thang table 1 xiu
    UIImageView *eventTableViewBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 7)];
    [eventTableViewBackground setContentMode:UIViewContentModeRight];
    [eventTableViewBackground setImage:[UIImage imageNamed:@"tabbar_bottom_shadow.png"]];
    [self.view addSubview:eventTableViewBackground];
    
    
    
    // =====
    // bat dau load data
    currentSelectedDayIndex = 0;
    self.eventsData = (NSMutableArray *)[(NSDictionary *)[self.daysData objectAtIndex:currentSelectedDayIndex] objectForKey:@"events"];
    
    // reload data
    [dayCollectionView reloadData];
    [eventTableView reloadData];
    [self fixTableViewHeight];
}



#pragma mark - Collection view datasource (day)

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.daysData count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSMutableDictionary *dayInfo = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)[self.daysData objectAtIndex:indexPath.row]];
    
    [dayInfo setObject:@(currentSelectedDayIndex) forKey:@"currentSelectedDayIndex"];
    [dayInfo setObject:@(indexPath.row) forKey:@"index"];
    
    // CELL
    // =====
    ScheduleCell *cell = (ScheduleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"scheduleCellIdentifier" forIndexPath:indexPath];
    [cell setInfo:dayInfo];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // don gian la thay lai data thoi
    currentSelectedDayIndex = indexPath.row;
    self.eventsData = (NSMutableArray *)[(NSDictionary *)[self.daysData objectAtIndex:currentSelectedDayIndex] objectForKey:@"events"];
    
    // reload lai cai table thoi
    [dayCollectionView reloadData];
    [eventTableView reloadData];
    [self fixTableViewHeight];
    
    return NO;
}



#pragma mark - Table view datasource (event)


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventsData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSMutableDictionary *eventInfo = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)[self.eventsData objectAtIndex:indexPath.row]];
    
    [eventInfo setObject:@(indexPath.row) forKey:@"index"];
    
    // CELL
    // =====
    ScheduleDetailCell *cell = (ScheduleDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ScheduleTableCell"];
    if (cell == nil)
        cell = [[ScheduleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScheduleTableCell"];
    
    [cell setInfo:eventInfo];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(void)fixTableViewHeight
{
    int screenHeight = [[AUIFreedomController sharedFreedomController] getHeight];
    int tempX = eventTableView.frame.origin.x;
    int tempY = eventTableView.frame.origin.y;
    int tempW = eventTableView.frame.size.width;
    int tempH = screenHeight - 164 - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight);
    
    eventTableView.frame = CGRectMake(tempX, tempY, tempW, tempH);
}

@end
