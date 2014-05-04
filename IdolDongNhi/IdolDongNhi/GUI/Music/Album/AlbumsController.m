//
//  AlbumsController.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/24/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AlbumsController.h"
#import "AlbumsCell.h"
#import "AlbumViewFlowLayout.h"
#import "AlbumTracksViewController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"

@interface AlbumsController ()

@end

@implementation AlbumsController


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
    self.navigationItem.title = @"ALBUM";
    
    
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
    
    
    
    
    // ALBUM COVER LAYOUT
    // =====
    // cho nay se show ra cac hinh bia (cover) cua 1 album

    albumCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight))
                                             collectionViewLayout:[[AlbumViewFlowLayout alloc] init]];
    [albumCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [albumCollectionView registerClass:[AlbumsCell class] forCellWithReuseIdentifier:@"albumCellIdentifier"];
    
    [albumCollectionView setDataSource:self];
    [albumCollectionView setDelegate:self];
    [self.view addSubview:albumCollectionView];
    
    // reload data, via delegate method to show to ui
    [albumCollectionView reloadData];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:albumCollectionView forKey:@"albumCollectionView"];

    
    
    // LOADING VIEW
    // (popup nho nho de user biet la dang load)
    // =====
    albumActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [albumActivityIndicator setFrame:CGRectMake(280, 10, 30, 30)];
    [albumActivityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [albumActivityIndicator.layer setCornerRadius:5];
    [albumActivityIndicator setHidden:YES];
    [aTabbar addSubview:albumActivityIndicator];
    
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // bat dau load nhung du lieu luon
    if(APIListalbumListalbum == NULL)
    {
        // khoi tao data
        APIListalbumStart = 0;
        APIListalbumCanNext = YES;
        APIListalbumListalbum = [[NSMutableArray alloc] init];
    }
    [self performSelectorInBackground:@selector(bgthreadLoadmoreListalbum) withObject:nil];
}

#pragma mark - Button delegate

-(void) menuButtonClick{
    [ManageSize showMainMenu];
}


#pragma mark - Collection view datasource


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [APIListalbumListalbum count];
}


- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSDictionary *APIListalbumListalbumItemTmp = (NSDictionary *)[APIListalbumListalbum objectAtIndex:indexPath.row];
    NSMutableDictionary *APIListalbumListalbumItem = [[NSMutableDictionary alloc] initWithDictionary:APIListalbumListalbumItemTmp];
    
    // bo sung them data
    [APIListalbumListalbumItem setObject:@(indexPath.row) forKey:@"index"];
    
    // CELL
    // =====
    AlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"albumCellIdentifier" forIndexPath:indexPath];
    [cell setInfo:APIListalbumListalbumItem];
    
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumTracksViewController *track= [[AlbumTracksViewController alloc] init];
    track.APIListalbumListalbum = APIListalbumListalbum;
    track.currentPresentingAlbumId = indexPath.row;
    [self.navigationController pushViewController:track animated:YES];
    
    return NO;
}


#pragma mark - Collection view layout delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [AlbumsCell sizeForCellWithIndexPath:indexPath];
}



#pragma mark - Network Get json, data from server


// JSON GET/POST DATA FROM API METHODS
// =============
-(void)getListalbumStart:(int)start limit:(int)limit
{
    //NSLog(@"getListalbumStart:%d limit:%d ...", start, limit);
    
    NSDictionary *listalbumDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:[NSString stringWithFormat:@"listalbum/start/%i/limit/%i", start, limit]];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listalbumDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listalbumDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listalbumDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get 1 so thu trong data
    NSString *dataStart = (NSString *)[data objectForKey:@"start"];
    NSString *dataLimit = (NSString *)[data objectForKey:@"limit"];
    id        dataNext  =  [data objectForKey:@"next"];
    NSArray *listalbum = (NSArray *)[data objectForKey:@"listalbum"];
    
    // update 1 so thu trong self
    APIListalbumStart = [dataStart intValue] + [dataLimit intValue];
    APIListalbumCanNext = (dataNext != [NSNull null]);
    
    // lap 1 vong tren listalbum vua moi get tu json ve de ma bo sung data
    for(NSDictionary *listalbumItem in listalbum)
    {
        NSString *itemId            = (NSString *)[listalbumItem objectForKey:@"id"];
        NSString *imageSource   = [(NSDictionary *)[listalbumItem objectForKey:@"image"] objectForKey:@"source"];
        NSString *name       = (NSString *)[listalbumItem objectForKey:@"name"];
        
        // download image from server
        //UIImage *image = [ManageSize getImageFromServer:imageSource];
        
        // getlist track
        NSArray *tracks = (NSArray *)[listalbumItem objectForKey:@"tracks"];
        
        // create new item dictionary
        //NSDictionary *APIListalbumListalbumItem = @{@"id": itemId, @"image": image, @"name": name, @"tracks" : tracks};
        NSDictionary *APIListalbumListalbumItem = @{@"id": itemId, @"imageSource": imageSource, @"name": name, @"tracks" : tracks};
        
        // add to current list
        [APIListalbumListalbum addObject:APIListalbumListalbumItem];
    }
    
    //NSLog(@"getListalbumStart:%d limit:%d -> done!", start, limit);
}


#pragma mark - Scroll delegate


// KEO XUONG DUOI CUNG THI SE LOAD THEM DATA
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float contentOffsetY = (float)scrollView.contentOffset.y;
    float contentHeight = (float)scrollView.contentSize.height;
    float scrollViewHeight = (float)scrollView.frame.size.height;
    
    // bat dau load new data
    if(APIListalbumCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmoreListalbum) withObject:nil];
    
}




#pragma mark - Background and main thread

-(void)bgthreadLoadmoreListalbum
{
    if(bgthreadLoadmoreListalbumIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmoreListalbumIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [albumActivityIndicator setHidden:NO];
        [albumActivityIndicator startAnimating];
    });
    
    // load album
    [self getListalbumStart:APIListalbumStart limit:4];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmoreListalbumDone) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmoreListalbumDone
{
    [albumCollectionView reloadData];
    
    // done!
    bgthreadLoadmoreListalbumIsRunning = NO;
    [albumActivityIndicator stopAnimating];
    [albumActivityIndicator setHidden:YES];
}



    
@end
