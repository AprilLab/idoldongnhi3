//
//  TrackAlbumsViewController.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingMusicView.h"
#import "JingRoundView.h"

@interface TrackAlbumsViewController : UIViewController<AVAudioPlayerDelegate, PlayingMusicViewDelegate, JingRoundViewDelegate>

@property (nonatomic, strong) NSDictionary *albumInfo;
@property (nonatomic, strong) NSDictionary *trackInfo;

@end
