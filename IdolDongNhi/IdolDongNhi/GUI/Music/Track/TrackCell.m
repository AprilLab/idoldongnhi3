//
//  TrackCell.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "TrackCell.h"
#import "PlayingMusicView.h"

@interface TrackCell ()
{
    UILabel *titleSong;
    UILabel *timeSong;
    UILabel *borderBottom;
    UIImageView *iconPlayPause;
}

@end


@implementation TrackCell

- (void)setInfo:(NSDictionary *)info
{
    [self setClipsToBounds:YES];
    [self setTintColor:[UIColor whiteColor]];
    
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:14];
    UIFont *fontRegularSmall = [UIFont fontWithName:@"OpenSans" size:10];
    UIColor *myPinkColor = [UIColor colorWithRed:237.0/255 green:0 blue:140.0/255 alpha:1];
    
    
    // BACKGROUND
    // =====
    [self setBackgroundColor:[UIColor colorWithWhite:(float)0.8 alpha:0.065]];
    
    // border bottom 1px
    if(borderBottom == NULL)
    {
        borderBottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, self.frame.size.width, 0.5)];
        [borderBottom setBackgroundColor:[UIColor colorWithWhite:(float)1 alpha:0.085]];
        [self addSubview:borderBottom];
    }
    
    
    // ICON PLAY/PAUSE
    // =====
    if(iconPlayPause == NULL)
    {
        iconPlayPause = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 25, self.frame.size.height)];
        [iconPlayPause setContentMode:UIViewContentModeCenter];
        [self addSubview:iconPlayPause];
    }
    // bay gio xem coi bai nay co phai la bai dang play hay khong
    // de biet ma set icon cho phu hop
    NSInteger currentPlayingSongId = [[PlayingMusicView sharePlaying] currentSongId];
    NSInteger songId = [(NSString *)[info objectForKey:@"id"] integerValue];
    [iconPlayPause setImage:[UIImage imageNamed:(currentPlayingSongId == songId) ? @"icon_pause_actived_25x25.png" : @"icon_play_25x25.png"]];
    
    
    // TITLE
    // =====
    if(titleSong == NULL)
    {
        titleSong = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 230, self.frame.size.height)];
        [titleSong setNumberOfLines:0];
        [titleSong setFont:fontRegular];
        [self addSubview:titleSong];
    }
    // set color cua title tuy vao bai dang play
    [titleSong setTextColor:(currentPlayingSongId == songId) ? myPinkColor : [UIColor whiteColor]];
    // set title
    NSString *title = (NSString *)[info objectForKey:@"title"];
    [titleSong setText:title];
    
    
    // TIME
    // =====
    if(timeSong == NULL)
    {
        timeSong = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 40, self.frame.size.height)];
        [timeSong setNumberOfLines:0];
        [timeSong setFont:fontRegularSmall];
        [timeSong setTextAlignment:NSTextAlignmentRight];
        [self addSubview:timeSong];
    }
    // set color cua title tuy vao bai dang play
    [timeSong setTextColor:(currentPlayingSongId == songId) ? myPinkColor : [UIColor whiteColor]];
    // set title
    [timeSong setText:@"04:30"];
    
}

@end
