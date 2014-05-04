//
//  CollectionController.m
//  April
//
//  Created by admin on 4/21/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "MainMenuCollectionController.h"
#import "NewsViewController.h"
#import "MainMenuCollectionCell.h"
#import "GalleryPhotosController.h"
#import "AUIFreedomController.h"
#import "VideoListController.h"
#import "ManageSize.h"

@interface MainMenuCollectionController ()

@end

@implementation MainMenuCollectionController
@synthesize index;

int _count;
- (void)viewDidLoad{
    [super viewDidLoad];
    _count= 0;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    UICollectionView *_collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 410)
                                       collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[MainMenuCollectionCell class] forCellWithReuseIdentifier:@"Cell"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    
    [self.view addSubview:_collectionView];

}



-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}






- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    MainMenuCollectionCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell= [[MainMenuCollectionCell alloc] init];
    }
    cell.cellId= _count;
    
    
    cell.imgThumb=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 57, 57)];
    [cell addSubview:cell.imgThumb];
    
    switch (_count) {
        case 0:
            cell.imgThumb.image= [UIImage imageNamed:@"news"];
            cell.lblTitle.text= @"TIN MỚI";
            break;
        case 1:
            cell.imgThumb.image= [UIImage imageNamed:@"music"];
            cell.lblTitle.text= @"ALBUM";
            break;
        case 2:
            cell.imgThumb.image= [UIImage imageNamed:@"images"];
            cell.lblTitle.text= @"HÌNH ẢNH";
            break;
        case 3:
            cell.imgThumb.image= [UIImage imageNamed:@"video"];
            cell.lblTitle.text= @"VIDEO";
            break;
        case 4:
            cell.imgThumb.image= [UIImage imageNamed:@"fanzone"];
            cell.lblTitle.text= @"FAN ZONE";
            break;
        case 5:
            cell.imgThumb.image= [UIImage imageNamed:@"calendar"];
            cell.lblTitle.text= @"LỊCH DIỄN";
            break;
        case 6:
            cell.imgThumb.image= [UIImage imageNamed:@"profile"];
            cell.lblTitle.text= @"ĐÔNG NHI";
            break;
        default:
            break;
    }
   
    _count++;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    AUIFreedomController *sharedFreedomController = [AUIFreedomController sharedFreedomController];
    AUIFreedomController *mainWrapper = [sharedFreedomController getChildViewControllerWithName:@"mainWrapper"];
    
    // show section
    switch (indexPath.row) {
        case 0:{
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"newsView"] view]];
            break;
        }
        case 1:{
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"musicView"] view]];
            break;
        }
        case 2:{
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"galleryView"] view]];
            break;
        }
        case 3:{
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"videoView"] view]];
            break;
        }
        case 4:
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"fanzoneView"] view]];
            break;
        case 5:{
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"scheduleView"] view]];
            break;
        }
        case 6:
            [mainWrapper.view bringSubviewToFront:[[sharedFreedomController getChildViewControllerWithName:@"dongnhiView"] view]];
            break;
        default:
            break;
    }
             
             
     // hide menu
    [ManageSize hideMainMenu];
}






- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize mElementSize = CGSizeMake(90, 120);
    return mElementSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
    //left right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
    //top bottom
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 30, 30, 0);  // top, left, bottom, right
}








- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
