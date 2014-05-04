//
//  AlbumsController.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    // UI
    UICollectionView *albumCollectionView;
    UIActivityIndicatorView *albumActivityIndicator;
    
    // json info data
    int APIListalbumStart;
    BOOL APIListalbumCanNext;
    NSMutableArray *APIListalbumListalbum;
    
    // used in bg thread
    BOOL bgthreadLoadmoreListalbumIsRunning;
}

@end
