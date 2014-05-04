//
//  ScheduleDetailCell.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ScheduleDetailCell.h"

@interface ScheduleDetailCell()
{
    // UI
    UILabel *labelTitle;
    UILabel *labelTime;
}

@end

@implementation ScheduleDetailCell

- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:17];
    UIFont *fontRegularSmall = [UIFont fontWithName:@"OpenSans" size:14];
    
    
    // BACKGROUND
    // set background khac nhau cho so chan va so le
    NSInteger index = [(NSString *)[info objectForKey:@"index"] integerValue];
    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha: (index % 2 == 0) ? 0.025 : 0]];
    
    
    // TITLE
    // =====
    if(labelTitle == NULL)
    {
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 290, 25)];
        [labelTitle setTextColor:[UIColor whiteColor]];
        [labelTitle setFont:fontRegular];
        [self addSubview:labelTitle];
    }
    NSString *title = (NSString *)[info objectForKey:@"title"];
    [labelTitle setText:title];
    
    
    // TIME
    // =====
    if(labelTime == NULL)
    {
        labelTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, 290, 25)];
        [labelTime setTextColor:[UIColor whiteColor]];
        [labelTime setFont:fontRegularSmall];
        [self addSubview:labelTime];
    }
    NSString *time = (NSString *)[info objectForKey:@"time"];
    [labelTime setText:time];
    
}

@end
