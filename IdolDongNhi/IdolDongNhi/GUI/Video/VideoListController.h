//
//  VideoListController.h
//  April
//
//  Created by admin on 4/18/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUITabBar.h"

@interface VideoListController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, AUITabBarDelegate>
{
    // UI
    UICollectionView *tabMVCollectionView;
    UICollectionView *tabOtherCollectionView;
    
    // json info data
    int APIPlaylistMVListvideoStart;
    BOOL APIPlaylistMVListvideoCanNext;
    NSMutableArray *APIPlaylistMVListvideoListvideo;
    
    int APIPlaylistOtherListvideoStart;
    BOOL APIPlaylistOtherListvideoCanNext;
    NSMutableArray *APIPlaylistOtherListvideoListvideo;
    
    // used in bg thread
    BOOL bgthreadLoadmorePlaylistMVListvideoIsRunning;
    BOOL bgthreadLoadmorePlaylistOtherListvideoIsRunning;
}


@end
