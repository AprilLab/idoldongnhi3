//
//  AprilCarouselViewController.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "PlayingMusicView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AlbumTracksViewController : UIViewController<iCarouselDataSource, iCarouselDelegate, UICollectionViewDataSource, UICollectionViewDelegate, PlayingMusicViewDelegate>
{
    // UI
    iCarousel *albumCarouselView;
    UICollectionView *listTrackCollectionView;
    
    // data
    NSMutableArray *listTracks;
}


@property (nonatomic, strong) NSMutableArray *APIListalbumListalbum;
@property int currentPresentingAlbumId;

@end
