//
//  MJViewController.h
//  ParallaxImages
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AUITabBar.h"

@interface NewsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, AUITabBarDelegate>
{
    // UI
    UICollectionView *tabPostCollectionView;
    UICollectionView *tabNewsCollectionView;
    
    // json info data
    int APIListpostStart;
    BOOL APIListpostCanNext;
    NSMutableArray *APIListpostListpost;
    
    int APIListnewsStart;
    BOOL APIListnewsCanNext;
    NSMutableArray *APIListnewsListnews;
    
    // used in bg thread
    BOOL bgthreadLoadmoreListpostIsRunning;
    BOOL bgthreadLoadmoreListnewsIsRunning;
}
@end
