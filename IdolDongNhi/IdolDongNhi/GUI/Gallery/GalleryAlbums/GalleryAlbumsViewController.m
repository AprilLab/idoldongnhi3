//
//  GalleryAlbumsViewController.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "GalleryAlbumsViewController.h"
#import "GalleriesCollectionViewFlowLayout.h"
#import "GalleryAlbumsCell.h"
#import "GalleryPhotosController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"


@interface GalleryAlbumsViewController ()
{
    UIActivityIndicatorView *galleriesActivityIndicator;
}
@end

@implementation GalleryAlbumsViewController


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
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-nav-no-shadow.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    // TITLE
    // =====
    self.navigationItem.title = @"HÌNH ẢNH";
    
    
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
    
    
    
    
    
    // GALLERY ALBUM COLLECTION VIEW
    // =====
    // cho nay se show ra danh sach cac album hinh anh
    
    galleriesCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ )
                                                collectionViewLayout:[[GalleriesCollectionViewFlowLayout alloc] init]];
    [galleriesCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [galleriesCollectionView registerClass:[GalleryAlbumsCell class] forCellWithReuseIdentifier:@"galleryAlbumCellIdentifier"];
    
    galleriesCollectionView.delegate = self;
    galleriesCollectionView.dataSource = self;
    [self.view addSubview:galleriesCollectionView];

    // reload data, via delegate method to show to ui
    [galleriesCollectionView reloadData];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:galleriesCollectionView forKey:@"galleryAlbumCollectionView"];

    
    
    
    
    
    // LOADING VIEW
    // (popup nho nho de user biet la dang load)
    // =====
    galleriesActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [galleriesActivityIndicator setFrame:CGRectMake(280, 10, 30, 30)];
    [galleriesActivityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [galleriesActivityIndicator.layer setCornerRadius:5];
    [galleriesActivityIndicator setHidden:YES];
    [aTabbar addSubview:galleriesActivityIndicator];
    
    
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // bat dau load nhung du lieu luon
    if(APIListgalleryListgallery == NULL)
    {
        // khoi tao data
        APIListgalleryStart = 0;
        APIListgalleryCanNext = YES;
        APIListgalleryListgallery = [[NSMutableArray alloc] init];
    }
    [self performSelectorInBackground:@selector(bgthreadLoadmoreListgallery) withObject:nil];
}

#pragma mark - Button delegate

-(void) menuButtonClick{
    [ManageSize showMainMenu];
}




#pragma mark - Collection view datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [APIListgalleryListgallery count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSDictionary *APIListgalleryListgalleryItem = (NSDictionary *)[APIListgalleryListgallery objectAtIndex:indexPath.row];
    
    // CELL
    // =====
    GalleryAlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"galleryAlbumCellIdentifier" forIndexPath:indexPath];
    [cell setInfo:APIListgalleryListgalleryItem];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSDictionary *APIListgalleryListgalleryItem = (NSDictionary *)[APIListgalleryListgallery objectAtIndex:indexPath.row];
    
    // GALLERY PHOTOS VIEW
    // =====
    GalleryPhotosController *galleryPhotosController = [[GalleryPhotosController alloc] init];
    [galleryPhotosController setInfo:APIListgalleryListgalleryItem];
    
    // push len thoi
    [self.navigationController pushViewController:galleryPhotosController animated:YES];
    
    return NO;
}


#pragma mark - Collection view layout delegate


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra item
    NSDictionary *APIListgalleryListgalleryItem = (NSDictionary *)[APIListgalleryListgallery objectAtIndex:indexPath.row];
    
    UIImage *image = (UIImage *)[APIListgalleryListgalleryItem objectForKey:@"image"];
    
    return [GalleryAlbumsCell sizeForCellWithImage:image];
}




#pragma mark - Network Get json, data from server


// JSON GET/POST DATA FROM API METHODS
// =============
-(void)getListgalleryStart:(int)start limit:(int)limit
{
    NSLog(@"getListgalleryStart:%d limit:%d ...", start, limit);
    
    NSDictionary *listgalleryDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:[NSString stringWithFormat:@"listgallery/start/%i/limit/%i", start, limit]];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listgalleryDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listgalleryDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listgalleryDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get 1 so thu trong data
    NSString *dataStart = (NSString *)[data objectForKey:@"start"];
    NSString *dataLimit = (NSString *)[data objectForKey:@"limit"];
    id        dataNext  =  [data objectForKey:@"next"];
    NSArray *listgallery = (NSArray *)[data objectForKey:@"listgallery"];
    
    // update 1 so thu trong self
    APIListgalleryStart = [dataStart intValue] + [dataLimit intValue];
    APIListgalleryCanNext = (dataNext != [NSNull null]);
    
    // lap 1 vong tren listgallery vua moi get tu json ve de ma bo sung data
    for(NSDictionary *listgalleryItem in listgallery)
    {
        NSString *id            = (NSString *)[listgalleryItem objectForKey:@"id"];
        NSString *imageSource   = [(NSDictionary *)[listgalleryItem objectForKey:@"image"] objectForKey:@"source"];
        NSString *name       = (NSString *)[listgalleryItem objectForKey:@"name"];
        
        // download image from server
        UIImage *image = [ManageSize getImageFromServer:imageSource];
        
        // create new item dictionary
        NSDictionary *APIListgalleryListgalleryItem = @{@"id": id, @"image": image, @"name": name};
        
        // add to current list
        [APIListgalleryListgallery addObject:APIListgalleryListgalleryItem];
    }
    
    NSLog(@"getListgalleryStart:%d limit:%d -> done!", start, limit);
}


#pragma mark - Scroll delegate


// KEO XUONG DUOI CUNG THI SE LOAD THEM DATA
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float contentOffsetY = (float)scrollView.contentOffset.y;
    float contentHeight = (float)scrollView.contentSize.height;
    float scrollViewHeight = (float)scrollView.frame.size.height;
    
    // bat dau load new data
    if(APIListgalleryCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmoreListgallery) withObject:nil];
    
}




#pragma mark - Background and main thread

-(void)bgthreadLoadmoreListgallery
{
    if(bgthreadLoadmoreListgalleryIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmoreListgalleryIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [galleriesActivityIndicator setHidden:NO];
        [galleriesActivityIndicator startAnimating];
    });
    
    // load gallery
    [self getListgalleryStart:APIListgalleryStart limit:3];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmoreListgalleryDone) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmoreListgalleryDone
{
    [galleriesCollectionView reloadData];
    
    // done!
    bgthreadLoadmoreListgalleryIsRunning = NO;
    [galleriesActivityIndicator stopAnimating];
    [galleriesActivityIndicator setHidden:YES];
}






@end
