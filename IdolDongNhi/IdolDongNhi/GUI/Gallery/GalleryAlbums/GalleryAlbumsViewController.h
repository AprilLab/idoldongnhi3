//
//  GalleryAlbumsViewController.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryAlbumsViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
{
    // UI
    UICollectionView *galleriesCollectionView;
    
    // json info data
    int APIListgalleryStart;
    BOOL APIListgalleryCanNext;
    NSMutableArray *APIListgalleryListgallery;
    
    // used in bg thread
    BOOL bgthreadLoadmoreListgalleryIsRunning;
}

@end
