//
//  ScheduleCell.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ScheduleCell.h"

@interface ScheduleCell()
{
    // UI
    UILabel *labelWeekDay;
    UILabel *labelMonthDay;
    UIImageView *backgroundImage;
    UILabel *borderRight;
}

@end

@implementation ScheduleCell

- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:25];
    UIFont *fontRegularSmall = [UIFont fontWithName:@"OpenSans" size:12];
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    
    
    // BACKGROUND
    // =====
    NSInteger index = [(NSString *)[info objectForKey:@"index"] intValue];
    NSInteger currentSelectedDayIndex = [(NSString *)[info objectForKey:@"currentSelectedDayIndex"] intValue];
    [self setBackgroundColor: (index == currentSelectedDayIndex) ? myPinkColor : [UIColor clearColor]];
    
    
    // border right 1px
    if(borderRight == NULL)
    {
        borderRight = [[UILabel alloc] initWithFrame:CGRectMake(44.5, 0, 0.5, self.frame.size.height)];
        [borderRight setBackgroundColor:[UIColor colorWithWhite:(float)1 alpha:0.085]];
        [self addSubview:borderRight];
    }
    
    
    // WEEK DAY
    // =====
    if(labelWeekDay == NULL)
    {
        labelWeekDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 45, 20)];
        [labelWeekDay setTextAlignment:NSTextAlignmentCenter];
        [labelWeekDay setTextColor:[UIColor whiteColor]];
        [labelWeekDay setNumberOfLines:0];
        [labelWeekDay setFont:fontRegularSmall];
        [self addSubview:labelWeekDay];
    }
    NSString *weekday = (NSString *)[info objectForKey:@"weekday"];
    [labelWeekDay setText:weekday];
    
    
    // MONTH DAY
    // =====
    if(labelMonthDay == NULL)
    {
        labelMonthDay = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, 45, 30)];
        [labelMonthDay setTextAlignment:NSTextAlignmentCenter];
        [labelMonthDay setTextColor:[UIColor whiteColor]];
        [labelMonthDay setNumberOfLines:0];
        [labelMonthDay setFont:fontRegular];
        [self addSubview:labelMonthDay];
    }
    NSString *monthday = (NSString *)[info objectForKey:@"monthday"];
    [labelMonthDay setText:monthday];
    
}

@end
