//
//  ScheduleDetailCell.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ScheduleDetailCell.h"

@implementation ScheduleDetailCell

@synthesize scheduleTitle, scheduleDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.scheduleTitle = [[UILabel alloc] initWithFrame:CGRectMake(19, 10, self.frame.size.width - 20, self.frame.size.height/2 - 5)];
        [self.scheduleTitle setNumberOfLines:0];
        self.scheduleTitle.textColor= [UIColor whiteColor];
        [self.contentView addSubview:self.scheduleTitle];
        
        self.scheduleDescription = [[UILabel alloc] initWithFrame:CGRectMake(19, self.frame.size.height/2 + 10, self.frame.size.width, self.frame.size.height/2 - 2)];
        self.scheduleDescription.textColor= [UIColor whiteColor];
        [self.contentView addSubview:self.scheduleDescription];
    }
    return self;
}

@end
