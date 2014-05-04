//
//  AlbumTracksViewController.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AlbumTracksViewController.h"
#import "TrackCell.h"
#import "TrackCellCollectionViewFlowLayout.h"
#import "TrackAlbumsViewController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"
#import "UIImageView+AWebCache.h"

@interface AlbumTracksViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableDictionary *albums;
@property (nonatomic, strong) NSMutableArray *songs;
@end

@implementation AlbumTracksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // bat dau khoi tao giao dien
    [self.view setClipsToBounds:YES];
    
    
    // BACKGROUND
    // =====
    [self.view setBackgroundColor:[UIColor blackColor]];
    UIImage *bg_newsview = [UIImage imageNamed:@"bg_blur_2_not_include_navigation.png"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bg_newsview];
    bgImageView.frame = CGRectMake(0, 0, bg_newsview.size.width, bg_newsview.size.height);
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    
    // LEFT NAVIGATION BUTTON
    // =====
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    // TITLE
    // =====
    //self.navigationItem.title = @"ÂM NHẠC";
    self.navigationItem.title = [[self.APIListalbumListalbum objectAtIndex:self.currentPresentingAlbumId] objectForKey:@"name"];
    
    
    // TABBAR
    // =====
    // boi vi trang am nhac thi khong co tab nao het
    // nen tabbar dua vao chi voi muc dich
    // show ra cai line (1px) mau hong, va cai shadow thoi
    
    AUITabBar *aTabbar = [[AUITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    [aTabbar setBackgroundColor:myPinkColor];
    [aTabbar setBottomShadowImage:[UIImage imageNamed:@"tabbar_bottom_shadow.png"]];
    [self.view addSubview:aTabbar];

    
    
    // ALBUM COVERs
    // =====
    // hien thi cover cua cac album theo chieu ngang du don

    albumCarouselView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, 215)];
    [albumCarouselView setType:iCarouselTypeCoverFlow2];
    [albumCarouselView setDelegate:self];
    [albumCarouselView setDataSource:self];
    [self.view addSubview:albumCarouselView];
    
    // nhay toi cai album mong muon
    [albumCarouselView setCurrentItemIndex:self.currentPresentingAlbumId];
    

    
    // DANH SACH BAI HAT
    // =====
    // hien thi danh sach bai hat theo dang collection view
    
    listTrackCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 216, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - 215 /*top*/ - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight))
                                                 collectionViewLayout:[[TrackCellCollectionViewFlowLayout alloc] init]];
    [listTrackCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [listTrackCollectionView registerClass:[TrackCell class] forCellWithReuseIdentifier:@"trackCellIdentifier"];
    
    [listTrackCollectionView setDelegate:self];
    [listTrackCollectionView setDataSource:self];
    [self.view addSubview:listTrackCollectionView];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:listTrackCollectionView forKey:@"listTrackCollectionView"];
    
    
    
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // get listTracks duoc truyen tu ben view truoc qua
    // tuc la view truoc da load xong ok het list tracks roi
    // gio ben nay chi can lay ra thoi
    listTracks = [[NSMutableArray alloc] init];
    listTracks = [[self.APIListalbumListalbum objectAtIndex:self.currentPresentingAlbumId] objectForKey:@"tracks"];
    
    // ============
    // reload data, via delegate method to show to ui
    [listTrackCollectionView reloadData];
}

#pragma mark - Button delegate

-(void) menuButtonClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - View life cercle

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // refresh cai list cac bai hat update to date
    [listTrackCollectionView reloadData];
    
    // set delegate cho cai sharing music play
    [[PlayingMusicView sharePlaying] setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    albumCarouselView = nil;
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    albumCarouselView.delegate = nil;
    albumCarouselView.dataSource = nil;
    
}



#pragma mark - music playing delegate

- (void) willStartPlayNewSong
{
    // refresh cai list cac bai hat update to date
    [listTrackCollectionView reloadData];
}



#pragma mark - Collection view datasource

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [listTracks count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra item
    NSDictionary *APIListalbumListalbumItem = (NSDictionary *)[listTracks objectAtIndex:indexPath.row];
    
    // CELL
    // =====
    TrackCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"trackCellIdentifier" forIndexPath:indexPath];
    [cell setInfo:APIListalbumListalbumItem];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    // tao ra 1 cai track detail view
    // de show ra thong tin chi tiet cua cai track nay
    TrackAlbumsViewController *trackAlbums = [[TrackAlbumsViewController alloc] init];
    
    // set info cho cai view nay
    trackAlbums.trackInfo = [listTracks objectAtIndex:indexPath.row];
    trackAlbums.albumInfo = [self.APIListalbumListalbum objectAtIndex:self.currentPresentingAlbumId];
    
    // push qua thoi
    [self.navigationController pushViewController:trackAlbums animated:YES];
    
    return NO;
}



#pragma mark - iCarousel datasource methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.APIListalbumListalbum count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        // get ra data item
        NSDictionary *APIListalbumListalbumItemTmp = (NSDictionary *)[self.APIListalbumListalbum objectAtIndex:index];
        NSString *imageSource = (NSString *)[APIListalbumListalbumItemTmp objectForKey:@"imageSource"];
        
        view = (UIImageView *)[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180.0, 180.0)];
        [view setContentMode:UIViewContentModeScaleAspectFill];
        [view setClipsToBounds:YES];
        [(UIImageView *)view loadImageWithURLString:imageSource placeholderImage:[UIImage new]];
        //[((UIImageView *)view) setImage:image];
    }
    
    return view;
}


- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}


#pragma mark - iCarousel delegate methods

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    listTracks = [[NSMutableArray alloc] init];
    listTracks = [[self.APIListalbumListalbum objectAtIndex:index] objectForKey:@"tracks"];
    [listTrackCollectionView reloadData];
}

- (void) carouselWillBeginScrollingAnimation:(iCarousel *)carousel
{
}

- (void) carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    // sau khi ket thuc truot qua truot lai
    // tuc la da cho ra duoc 1 cai album
    // thi se update 1 so thu
    
    // update currentPresentingAlbumId
    self.currentPresentingAlbumId = carousel.currentItemIndex;
    
    // update title
    self.navigationItem.title = [[self.APIListalbumListalbum objectAtIndex:self.currentPresentingAlbumId] objectForKey:@"name"];
    
    // update listtracks
    listTracks = [[self.APIListalbumListalbum objectAtIndex:self.currentPresentingAlbumId] objectForKey:@"tracks"];

    // reload danh sach list track (collection view)
    [listTrackCollectionView reloadData];
}





@end
