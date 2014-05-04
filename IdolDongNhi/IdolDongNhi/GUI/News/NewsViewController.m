//
//  MJViewController.m
//  ParallaxImages
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 sky. All rights reserved.
//

#import "NewsViewController.h"
#import "PostCell.h"
#import "NewsCell.h"
#import "PostFullViewController.h"
#import "NewsDetailController.h"
#import "PostCollectionViewFlowLayout.h"
#import "NewsCollectionViewFlowLayout.h"
#import "AUIFreedomController.h"
#import "AUITabBarItem.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsViewController () 
{
    UIActivityIndicatorView *tabPostActivityIndicator;
    UIActivityIndicatorView *tabNewsActivityIndicator;
}
@end

@implementation NewsViewController

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
    self.navigationItem.title = @"TIN MỚI";
    
    
    // TABBAR
    // =====
    AUITabBarItem *tabbarItem1 = [[AUITabBarItem alloc] initWithTitle:@"Đông Nhi" image:nil];
    AUITabBarItem *tabbarItem2 = [[AUITabBarItem alloc] initWithTitle:@"Tin Tức" image:nil];
    
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
    [aTabbar initSelectedItemBorderWithFrame:CGRectMake(47, 29, 65, 2) backgroundColor:myPinkColor];
    
    
    
    // TAB - POST (DONG NHI)
    // =====
    // noi la tab, chu thuc ra la 1 view
    // va o day se co 2 view de len nhau de lam 2 cai tab content
    // post co nghia la se lay cac thong tin (post cua dong nhi)
    // post tuong tu nhu 1 post tren facebook (post to wall)
    
    tabPostCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 32, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 32 /*tab*/ ) collectionViewLayout:[[PostCollectionViewFlowLayout alloc] init]];
    [tabPostCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [tabPostCollectionView registerClass:[PostCell class] forCellWithReuseIdentifier:@"postCellIdentifier"];
    
    [tabPostCollectionView setDelegate:self];
    [tabPostCollectionView setDataSource:self];
    [tabPostCollectionView setTag:1];
    [self.view addSubview:tabPostCollectionView];
    
    // reload data, via delegate method to show to ui
    [tabPostCollectionView reloadData];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:tabPostCollectionView forKey:@"tabPostCollectionView"];
    
    
    
    
    
    // TAB - TIN TUC KHAC
    // =====
    // noi la tab, chu thuc ra la 1 view
    // va o day se co 2 view de len nhau de lam 2 cai tab content
    
    tabNewsCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(320, 32, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 32 /*tab*/ ) collectionViewLayout:[[NewsCollectionViewFlowLayout alloc] init]];
    [tabNewsCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [tabNewsCollectionView registerClass:[NewsCell class] forCellWithReuseIdentifier:@"newsCellIdentifier"];
    
    [tabNewsCollectionView setDelegate:self];
    [tabNewsCollectionView setDataSource:self];
    [tabNewsCollectionView setTag:2];
    [self.view addSubview:tabNewsCollectionView];
    
    // reload data, via delegate method to show to ui
    [tabNewsCollectionView reloadData];
    
    // save cai nay vao dic than thanh luon
    // de sau nay con chay cac ham resize duoc
    [ManageSize setObject:tabNewsCollectionView forKey:@"tabNewsCollectionView"];
    
    
    
    
    
    
    // LOADING VIEW
    // (popup nho nho de user biet la dang load)
    // =====
    tabPostActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [tabPostActivityIndicator setFrame:CGRectMake(135, 6, 20, 20)];
    [tabPostActivityIndicator setHidden:YES];
    [aTabbar addSubview:tabPostActivityIndicator];
    
    tabNewsActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [tabNewsActivityIndicator setFrame:CGRectMake(290, 6, 20, 20)];
    [tabNewsActivityIndicator setHidden:YES];
    [aTabbar addSubview:tabNewsActivityIndicator];
    
    
    
    
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
    // Truy cap vao tab DONG NHI
    // =====
    if(index == 0)
    {
        // init data
        // xem coi data cua cai tab nay no duoc load chua
        // neu nhu chua load thi se bat dau load lan dau tien
        if(APIListpostListpost == NULL)
        {
            // khoi tao data
            APIListpostStart = 0;
            APIListpostCanNext = YES;
            APIListpostListpost = [[NSMutableArray alloc] init];
            
            // bat dau load listpost lan dau tien
            [self performSelectorInBackground:@selector(bgthreadLoadmoreListpost) withObject:nil];
            
        }
        
    }
    
    
    
    else if(index == 1)
    {
        // init data
        // xem coi data cua cai tab nay no duoc load chua
        // neu nhu chua load thi se bat dau load lan dau tien
        if(APIListnewsListnews == NULL)
        {
            // khoi tao data
            APIListnewsStart = 0;
            APIListnewsCanNext = YES;
            APIListnewsListnews = [[NSMutableArray alloc] init];
            
            // bat dau load listpost lan dau tien
            [self performSelectorInBackground:@selector(bgthreadLoadmoreListnews) withObject:nil];
            
        }

    }
    
    
    // animation slide
    [UIView animateWithDuration:0.4 animations:^(void){
        [tabPostCollectionView setFrame:CGRectMake(index == 0 ? 0 : -320, tabPostCollectionView.frame.origin.y, tabPostCollectionView.frame.size.width, tabPostCollectionView.frame.size.height)];
        [tabNewsCollectionView setFrame:CGRectMake(index == 0 ? 320 : 0, tabNewsCollectionView.frame.origin.y, tabNewsCollectionView.frame.size.width, tabNewsCollectionView.frame.size.height)];
    }];
}



#pragma mark - Collection view datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == 1)
        return [APIListpostListpost count];
    if(collectionView.tag == 2)
        return [APIListnewsListnews count];
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 1)
    {
        // get ra data item
        NSDictionary *APIListpostListpostItem = (NSDictionary *)[APIListpostListpost objectAtIndex:indexPath.row];
        
        UIImage *image = (UIImage *)[APIListpostListpostItem objectForKey:@"image"];
        NSString *content = (NSString *)[APIListpostListpostItem objectForKey:@"content"];
        
        // CELL
        // =====
        PostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCellIdentifier" forIndexPath:indexPath];
        [cell setImage:image content:content like:14515 comment:285];
        
        return cell;
    }
    
    if(collectionView.tag == 2)
    {
        
        // get ra data item
        NSDictionary *APIListnewsListnewsItemTemp = (NSDictionary *)[APIListnewsListnews objectAtIndex:indexPath.row];
        
        // bo sung them thong tin
        NSMutableDictionary *APIListnewsListnewsItem = [[NSMutableDictionary alloc] initWithDictionary:APIListnewsListnewsItemTemp];
        [APIListnewsListnewsItem setObject:@(indexPath.row) forKey:@"index"];
        
        
        // CELL
        // =====
        NewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCellIdentifier" forIndexPath:indexPath];
        [cell setInfo:APIListnewsListnewsItem];
        
        return cell;
    }
    
    return nil;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 1)
    {
        // get ra data item
        NSDictionary *APIListpostListpostItem = (NSDictionary *)[APIListpostListpost objectAtIndex:indexPath.row];
        
        UIImage *image = (UIImage *)[APIListpostListpostItem objectForKey:@"image"];
        NSString *content = (NSString *)[APIListpostListpostItem objectForKey:@"content"];
        
        // POST FULL VIEW
        // =====
        PostFullViewController *postFullViewController = [[PostFullViewController alloc] init];
        [postFullViewController setImage:image content:content like:1000 comment:2000];
        
        // present len thoi
        [self presentViewController:postFullViewController animated:YES completion:nil];
    }
    
    if(collectionView.tag == 2)
    {
        // get ra data item
        NSDictionary *APIListnewsListnewsItem = (NSDictionary *)[APIListnewsListnews objectAtIndex:indexPath.row];
        
        // NEWS DETAILD VIEW
        // =====
        NewsDetailController *newsDetailController = [[NewsDetailController alloc] init];
        [newsDetailController setInfo:APIListnewsListnewsItem];
        
        // push len thoi
        [self.navigationController pushViewController:newsDetailController animated:YES];
    }
    
    return NO;
}


#pragma mark - Collection view layout delegate


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 2)
        return CGSizeMake(320, 80);
    
    // get ra item
    NSDictionary *APIListpostListpostItem = (NSDictionary *)[APIListpostListpost objectAtIndex:indexPath.row];

    UIImage *image = (UIImage *)[APIListpostListpostItem objectForKey:@"image"];
    
    return [PostCell sizeForCellWithImage:image];
}




#pragma mark - Network Get json, data from server


// JSON GET/POST DATA FROM API METHODS
// =============
-(void)getListpostStart:(int)start limit:(int)limit
{
//    NSLog(@"getListpostStart:%d limit:%d ...", start, limit);
    
    NSDictionary *listpostDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:[NSString stringWithFormat:@"listpost/start/%i/limit/%i", start, limit]];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listpostDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listpostDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listpostDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get 1 so thu trong data
    NSString *dataStart = (NSString *)[data objectForKey:@"start"];
    NSString *dataLimit = (NSString *)[data objectForKey:@"limit"];
    id        dataNext  =  [data objectForKey:@"next"];
    NSArray *listpost = (NSArray *)[data objectForKey:@"listpost"];
    
    // update 1 so thu trong self
    APIListpostStart = [dataStart intValue] + [dataLimit intValue];
    APIListpostCanNext = (dataNext != [NSNull null]);
    
    // lap 1 vong tren listpost vua moi get tu json ve de ma bo sung data
    for(NSDictionary *listpostItem in listpost)
    {
        NSString *itemId            = (NSString *)[listpostItem objectForKey:@"id"];
        id        imageObj      = [listpostItem objectForKey:@"image"];
        NSString *imageSource   = (imageObj != [NSNull null]) ? [(NSDictionary *)imageObj objectForKey:@"source"] : NULL;
        NSString *content       = (NSString *)[listpostItem objectForKey:@"content"];
        
        // download image from server
        UIImage *image = (imageSource != NULL) ? [ManageSize getImageFromServer:imageSource] : [UIImage new];
        
        // create new item dictionary
        NSDictionary *APIListpostListpostItem = @{@"id": itemId, @"image": image, @"content": content};
        
        // add to current list
        [APIListpostListpost addObject:APIListpostListpostItem];
    }
    
//    NSLog(@"getListpostStart:%d limit:%d -> done!", start, limit);
}

-(void)getListnewsStart:(int)start limit:(int)limit
{
    //NSLog(@"getListnewsStart:%d limit:%d ...", start, limit);
    
    NSDictionary *listnewsDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:[NSString stringWithFormat:@"listnews/start/%i/limit/%i", start, limit]];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listnewsDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listnewsDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listnewsDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get 1 so thu trong data
    NSString *dataStart = (NSString *)[data objectForKey:@"start"];
    NSString *dataLimit = (NSString *)[data objectForKey:@"limit"];
    id        dataNext  =  [data objectForKey:@"next"];
    NSArray *listnews = (NSArray *)[data objectForKey:@"listnews"];
    
    // update 1 so thu trong self
    APIListnewsStart = [dataStart intValue] + [dataLimit intValue];
    APIListnewsCanNext = (dataNext != [NSNull null]);
    
    // lap 1 vong tren listnews vua moi get tu json ve de ma bo sung data
    for(NSDictionary *listnewsItem in listnews)
    {
        NSString *itemId            = (NSString *)[listnewsItem objectForKey:@"id"];
        id        imageObj      = [listnewsItem objectForKey:@"image"];
        NSString *imageSource   = (imageObj != [NSNull null]) ? [(NSDictionary *)imageObj objectForKey:@"source"] : NULL;
        NSString *title       = (NSString *)[listnewsItem objectForKey:@"title"];
        
        // create new item dictionary
        NSDictionary *APIListnewsListnewsItem = @{@"id": itemId, @"imageSource": imageSource, @"title": title};
        
        // add to current list
        [APIListnewsListnews addObject:APIListnewsListnewsItem];
    }
    
    //NSLog(@"getListnewsStart:%d limit:%d -> done!", start, limit);
}


#pragma mark - Scroll delegate


// KEO XUONG DUOI CUNG THI SE LOAD THEM DATA
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{ 
    float contentOffsetY = (float)scrollView.contentOffset.y;
    float contentHeight = (float)scrollView.contentSize.height;
    float scrollViewHeight = (float)scrollView.frame.size.height;
    
    // bat dau load new data
    if(scrollView.tag == 1 && APIListpostCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmoreListpost) withObject:nil];
    
    if(scrollView.tag == 2 && APIListnewsCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmoreListnews) withObject:nil];
}         


         
#pragma mark - Background and main thread

-(void)bgthreadLoadmoreListpost
{
    if(bgthreadLoadmoreListpostIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmoreListpostIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tabPostActivityIndicator setHidden:NO];
        [tabPostActivityIndicator startAnimating];
    });
    
    // load post
    [self getListpostStart:APIListpostStart limit:3];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmoreListpostDone) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmoreListpostDone
{
    [tabPostCollectionView reloadData];
    
    // done!
    bgthreadLoadmoreListpostIsRunning = NO;
    [tabPostActivityIndicator stopAnimating];
    [tabPostActivityIndicator setHidden:YES];
}



-(void)bgthreadLoadmoreListnews
{
    if(bgthreadLoadmoreListnewsIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmoreListnewsIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tabNewsActivityIndicator setHidden:NO];
        [tabNewsActivityIndicator startAnimating];
    });
    
    
    // load post
    [self getListnewsStart:APIListnewsStart limit:6];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmoreListnewsDone) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmoreListnewsDone
{
    [tabNewsCollectionView reloadData];
    
    // done!
    bgthreadLoadmoreListnewsIsRunning = NO;
    [tabNewsActivityIndicator stopAnimating];
    [tabNewsActivityIndicator setHidden:YES];
}



@end
