//
//  VideoListController.m
//  April
//
//  Created by admin on 4/18/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "VideoListController.h"
#import "VideoCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HCYoutubeParser.h"
#import "VideoDetailController.h"
#import "VideoCollectionViewFlowLayout.h"
#import "AUIFreedomController.h"
#import "AUITabBarItem.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"



@interface VideoListController ()
{
    UIActivityIndicatorView *tabMVActivityIndicator;
    UIActivityIndicatorView *tabOtherActivityIndicator;
}
@end

@implementation VideoListController

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
    self.navigationItem.title = @"VIDEO";
    
    
    // TABBAR
    // =====
    AUITabBarItem *tabbarItem1 = [[AUITabBarItem alloc] initWithTitle:@"MV Đông Nhi" image:nil];
    AUITabBarItem *tabbarItem2 = [[AUITabBarItem alloc] initWithTitle:@"Video khác" image:nil];
    
    AUITabBar *aTabbar = [[AUITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    [aTabbar setBackgroundImage:[UIImage imageNamed:@"bg_tabbar.png"]];
    [aTabbar setBottomShadowImage:[UIImage imageNamed:@"tabbar_bottom_shadow.png"]];
    [aTabbar setTabbarItems:[[NSMutableArray alloc] initWithObjects:tabbarItem1, tabbarItem2, nil]];
    
    // hack to could recieve event
    [AUITabBar hackToRecieveEventInView:self.view];
    
    aTabbar.delegate = self;
    [self.view addSubview:aTabbar];
    [self.view bringSubviewToFront:aTabbar];
    
    // set font, color
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    [aTabbar setItemsColor:myPinkColor forState:UIControlStateNormal];
    [aTabbar setItemsFont:[UIFont fontWithName:@"OpenSans" size:16]];
        
    // border bottom
    [aTabbar initSelectedItemBorderWithFrame:CGRectMake(37, 29, 85, 2) backgroundColor:myPinkColor];

    
    
    
    // TAB - MV DONG NHI
    // =====
    // noi la tab, chu thuc ra la 1 view
    // va o day se co 2 view de len nhau de lam 2 cai tab content
    
    tabMVCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 32, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 32 /*tab*/ ) collectionViewLayout:[[VideoCollectionViewFlowLayout alloc] init]];
    [tabMVCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [tabMVCollectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:@"videoCellIdentifier"];
    
    [tabMVCollectionView setDelegate:self];
    [tabMVCollectionView setDataSource:self];
    [tabMVCollectionView setTag:1];
    [self.view addSubview:tabMVCollectionView];
    
    // reload data, via delegate method to show to ui
    [tabMVCollectionView reloadData];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:tabMVCollectionView forKey:@"MVCollectionView"];
    
    
    
    
    // TAB - VIDEO KHAC
    // =====
    // noi la tab, chu thuc ra la 1 view
    // va o day se co 2 view de len nhau de lam 2 cai tab content
    
    tabOtherCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(320, 32, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 32 /*tab*/ ) collectionViewLayout:[[VideoCollectionViewFlowLayout alloc] init]];
    [tabOtherCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [tabOtherCollectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:@"videoCellIdentifier"];
    
    [tabOtherCollectionView setDelegate:self];
    [tabOtherCollectionView setDataSource:self];
    [tabOtherCollectionView setTag:2];
    //[tabOtherCollectionView setHidden:YES];
    [self.view addSubview:tabOtherCollectionView];
    
    // reload data, via delegate method to show to ui
    [tabOtherCollectionView reloadData];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:tabOtherCollectionView forKey:@"OtherCollectionView"];
    
    
    
    
    
    // LOADING VIEW
    // (popup nho nho de user biet la dang load)
    // =====
    tabMVActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [tabMVActivityIndicator setFrame:CGRectMake(135, 6, 20, 20)];
    [tabMVActivityIndicator setHidden:YES];
    [aTabbar addSubview:tabMVActivityIndicator];
    
    tabOtherActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [tabOtherActivityIndicator setFrame:CGRectMake(290, 6, 20, 20)];
    [tabOtherActivityIndicator setHidden:YES];
    [aTabbar addSubview:tabOtherActivityIndicator];
    
    
    
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // mac dinh ban dau se la select index 0
    [aTabbar selectTabAtIndex:0];
}

#pragma mark - Button delegate

-(void) menuButtonClick{
    [ManageSize showMainMenu];
}



#pragma mark - TabBar delegate

-(void)aTabBar:(AUITabBar *)aTabBar didSelectItem:(AUITabBarItem *)item atIndex:(int)index
{
    // Truy cap vao tab MV DONG NHI
    // =====
    if(index == 0)
    {
        //[tabMVCollectionView setHidden:NO];
        //[tabOtherCollectionView setHidden:YES];
        
        // init data
        // xem coi data cua cai tab nay no duoc load chua
        // neu nhu chua load thi se bat dau load lan dau tien
        if(APIPlaylistMVListvideoListvideo == NULL)
        {
            
            // khoi tao data
            APIPlaylistMVListvideoStart = 0;
            APIPlaylistMVListvideoCanNext = YES;
            APIPlaylistMVListvideoListvideo = [[NSMutableArray alloc] init];
            
            // bat dau load listpost lan dau tien
            [self performSelectorInBackground:@selector(bgthreadLoadmorePlaylistMVListvideo) withObject:nil];
            
        }
    }
    
    
    // truy cap vao tab Video Khac
    else if(index == 1)
    {
        //[tabMVCollectionView setHidden:YES];
        //[tabOtherCollectionView setHidden:NO];
        
        // init data
        // xem coi data cua cai tab nay no duoc load chua
        // neu nhu chua load thi se bat dau load lan dau tien
        if(APIPlaylistOtherListvideoListvideo == NULL)
        {
            
            // khoi tao data
            APIPlaylistOtherListvideoStart = 0;
            APIPlaylistOtherListvideoCanNext = YES;
            APIPlaylistOtherListvideoListvideo = [[NSMutableArray alloc] init];
            
            // bat dau load listpost lan dau tien
            [self performSelectorInBackground:@selector(bgthreadLoadmorePlaylistOtherListvideo) withObject:nil];
            
        }

    }
    
    
    // animation slide
    [UIView animateWithDuration:0.4 animations:^(void){
        [tabMVCollectionView setFrame:CGRectMake(index == 0 ? 0 : -320, tabMVCollectionView.frame.origin.y, tabMVCollectionView.frame.size.width, tabMVCollectionView.frame.size.height)];
        [tabOtherCollectionView setFrame:CGRectMake(index == 0 ? 320 : 0, tabOtherCollectionView.frame.origin.y, tabOtherCollectionView.frame.size.width, tabOtherCollectionView.frame.size.height)];
    }];
    
}



#pragma mark - Collection view datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == 1)
        return [APIPlaylistMVListvideoListvideo count];
    
    if(collectionView.tag == 2)
        return [APIPlaylistOtherListvideoListvideo count];
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSMutableDictionary *APIPlaylistCommonListvideoListvideoItem;
    if(collectionView.tag == 1)
        APIPlaylistCommonListvideoListvideoItem = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)[APIPlaylistMVListvideoListvideo objectAtIndex:indexPath.row]];
    if(collectionView.tag == 2)
        APIPlaylistCommonListvideoListvideoItem = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)[APIPlaylistOtherListvideoListvideo objectAtIndex:indexPath.row]];
    
    // bo sung them index
    [APIPlaylistCommonListvideoListvideoItem setObject:@(indexPath.row) forKey:@"index"];
    
    
    // CELL
    // =====
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"videoCellIdentifier" forIndexPath:indexPath];
    [cell setInfo:APIPlaylistCommonListvideoListvideoItem];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSMutableDictionary *APIPlaylistCommonListvideoListvideoItem;
    if(collectionView.tag == 1)
        APIPlaylistCommonListvideoListvideoItem = (NSMutableDictionary *)[APIPlaylistMVListvideoListvideo objectAtIndex:indexPath.row];
    if(collectionView.tag == 2)
        APIPlaylistCommonListvideoListvideoItem = (NSMutableDictionary *)[APIPlaylistOtherListvideoListvideo objectAtIndex:indexPath.row];
    
    
    // VIDEO DETAIL VIEW
    // =====
    VideoDetailController *videoDetailController = [[VideoDetailController alloc] init];
    [videoDetailController setItemInfo:APIPlaylistCommonListvideoListvideoItem];
    
    
    // stop play nhac
    if([[PlayingMusicView sharePlaying] isPlaying])
       [[PlayingMusicView sharePlaying] pauseAudio];
    
    
    // push len thoi
    [self.navigationController pushViewController:videoDetailController animated:YES];
    
    return NO;
}




#pragma mark - Network Get json, data from server


// JSON GET/POST DATA FROM API METHODS
// =============
-(void)getPlaylistHasId:(int)playlistId listvideoStart:(int)start limit:(int)limit
{
    //NSLog(@"getPlaylist:%d ListvideoStart:%d limit:%d ...", playlistId, start, limit);
    
    NSDictionary *listvideoDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:[NSString stringWithFormat:@"playlist/hasid/%i/listvideo/start/%i/limit/%i", playlistId, start, limit]];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listvideoDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listvideoDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listvideoDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get 1 so thu trong data
    NSString *dataStart = (NSString *)[data objectForKey:@"start"];
    NSString *dataLimit = (NSString *)[data objectForKey:@"limit"];
    id        dataNext  =  [data objectForKey:@"next"];
    NSArray *listvideo = (NSArray *)[data objectForKey:@"listvideo"];
    
    // update 1 so thu trong self
    if(playlistId == 154)
    {
        APIPlaylistMVListvideoStart = [dataStart intValue] + [dataLimit intValue];
        APIPlaylistMVListvideoCanNext = (dataNext != [NSNull null]);
    }
    if(playlistId == 158)
    {
        APIPlaylistOtherListvideoStart = [dataStart intValue] + [dataLimit intValue];
        APIPlaylistOtherListvideoCanNext = (dataNext != [NSNull null]);
    }
    
    
    // lap 1 vong tren listvideo vua moi get tu json ve de ma bo sung data
    for(NSDictionary *listvideoItem in listvideo)
    {
        NSString *id            = (NSString *)[listvideoItem objectForKey:@"id"];
        NSString *imageSource   = [(NSDictionary *)[listvideoItem objectForKey:@"image"] objectForKey:@"source"];
        NSString *title       = (NSString *)[listvideoItem objectForKey:@"title"];
        NSString *link       = (NSString *)[listvideoItem objectForKey:@"link"];
        
        // download image from server
        //UIImage *image = [ManageSize getImageFromServer:imageSource];
        
        // create new item dictionary
        //NSDictionary *APIPlaylistCommonListvideoListvideoItem = @{@"id": id, @"image": image, @"title": title, @"link": link};
        NSDictionary *APIPlaylistCommonListvideoListvideoItem = @{@"id": id, @"imageSource": imageSource, @"title": title, @"link": link};
        
        // data for tab mv dong nhi
        if(playlistId == 154)
        {
            // add to current list
            [APIPlaylistMVListvideoListvideo addObject:APIPlaylistCommonListvideoListvideoItem];
        }
        
        
        // data for tab video khac
        if(playlistId == 158)
        {
            // add to current list
            [APIPlaylistOtherListvideoListvideo addObject:APIPlaylistCommonListvideoListvideoItem];
        }
    }
    
    //NSLog(@"getPlaylist: %d ListvideoStart:%d limit:%d -> done!", playlistId, start, limit);
}




#pragma mark - Scroll delegate


// KEO XUONG DUOI CUNG THI SE LOAD THEM DATA
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float contentOffsetY = (float)scrollView.contentOffset.y;
    float contentHeight = (float)scrollView.contentSize.height;
    float scrollViewHeight = (float)scrollView.frame.size.height;
    
    // bat dau load new data
    if(scrollView.tag == 1 && APIPlaylistMVListvideoCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmorePlaylistMVListvideo) withObject:nil];
    
    if(scrollView.tag == 2 && APIPlaylistOtherListvideoCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmorePlaylistOtherListvideo) withObject:nil];
}




#pragma mark - Background and main thread

-(void)bgthreadLoadmorePlaylistMVListvideo
{
    if(bgthreadLoadmorePlaylistMVListvideoIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmorePlaylistMVListvideoIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tabMVActivityIndicator setHidden:NO];
        [tabMVActivityIndicator startAnimating];
    });
    
    // load post
    [self getPlaylistHasId:154 listvideoStart:APIPlaylistMVListvideoStart limit:6];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmorePlaylistMVListvideoDone) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmorePlaylistMVListvideoDone
{
    [tabMVCollectionView reloadData];
    
    // done!
    bgthreadLoadmorePlaylistMVListvideoIsRunning = NO;
    [tabMVActivityIndicator stopAnimating];
    [tabMVActivityIndicator setHidden:YES];
}


-(void)bgthreadLoadmorePlaylistOtherListvideo
{
    if(bgthreadLoadmorePlaylistOtherListvideoIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmorePlaylistOtherListvideoIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tabOtherActivityIndicator setHidden:NO];
        [tabOtherActivityIndicator startAnimating];
    });
    
    // load post
    [self getPlaylistHasId:158 listvideoStart:APIPlaylistOtherListvideoStart limit:6];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmorePlaylistOtherListvideoDone) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmorePlaylistOtherListvideoDone
{
    [tabOtherCollectionView reloadData];
    
    // done!
    bgthreadLoadmorePlaylistOtherListvideoIsRunning = NO;
    [tabOtherActivityIndicator stopAnimating];
    [tabOtherActivityIndicator setHidden:YES];
}






@end
