//
//  AprilViewController.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/17/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "GalleryPhotosController.h"
#import "GalleryPhotoCell.h"
#import "GalleryFlowLargeImage.h"
#import "GalleryFlowSmallImage.h"
#import "PhotosViewController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"



@interface GalleryPhotosController ()
{
    // infomation
    NSInteger galleryId;
    NSString *name;
    
    // drap
    GalleryFlowLargeImage *largeLayout;
    CHTCollectionViewWaterfallLayout *chtLayOut;
    NSArray *images;
    NSMutableArray *cellSizes;
    
    
    // UI
    UICollectionView *galleryPhotoCollectionView;
    UIActivityIndicatorView *galleryPhotoActivityIndicator;
    
    // json info data
    int APIGalleryCustomListphotoStart;
    BOOL APIGalleryCustomListphotoCanNext;
    NSMutableArray *APIGalleryCustomListphotoListphoto;
    
    // used in bg thread
    BOOL bgthreadLoadmoreGalleryCustomListphotoIsRunning;
    
}
@end

@implementation GalleryPhotosController


- (void)setInfo:(NSDictionary *)info
{
    galleryId = [(NSString *)[info objectForKey:@"id"] intValue];
    name = (NSString *)[info objectForKey:@"name"];
}

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
    self.navigationItem.title = name;
    
    
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

    
    
    
    // GALLERY PHOTOS COLLECTION VIEW
    // =====
    // cho nay se show ra cac hinh anh cua 1 gallery
    
    largeLayout = [[GalleryFlowLargeImage alloc] init];
    largeLayout.sectionInset = UIEdgeInsetsMake(8, 5, 8, 5);
    
    chtLayOut = [[CHTCollectionViewWaterfallLayout alloc] init];
    chtLayOut.sectionInset = UIEdgeInsetsMake(8, 5, 8, 5);
    chtLayOut.minimumColumnSpacing = 2;
    chtLayOut.minimumInteritemSpacing = 2;
    
    galleryPhotoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, self.view.frame.size.width, self.view.frame.size.height - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight))
                               collectionViewLayout:chtLayOut];
    [galleryPhotoCollectionView setBackgroundColor:[UIColor clearColor]];
    
    // dang ky class cho 1 cai cell de ma reuse duoc
    [galleryPhotoCollectionView registerClass:[GalleryPhotoCell class] forCellWithReuseIdentifier:@"galleryPhotoCellIdentifier"];
    
    [galleryPhotoCollectionView setDelegate:self];
    [galleryPhotoCollectionView setDataSource:self];
    [self.view addSubview:galleryPhotoCollectionView];
    
    // reload data, via delegate method to show to ui
    [galleryPhotoCollectionView reloadData];
    
    
    
    // add Swipe gesture
    // =====
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    rightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightGesture];
    
    
    
    
    
    // LOADING VIEW
    // (popup nho nho de user biet la dang load)
    // =====
    galleryPhotoActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [galleryPhotoActivityIndicator setFrame:CGRectMake(280, 10, 30, 30)];
    [galleryPhotoActivityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [galleryPhotoActivityIndicator.layer setCornerRadius:5];
    [galleryPhotoActivityIndicator setHidden:YES];
    [aTabbar addSubview:galleryPhotoActivityIndicator];
    
    
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // bat dau load nhung du lieu luon
    if(APIGalleryCustomListphotoListphoto == NULL)
    {
        // khoi tao data
        APIGalleryCustomListphotoStart = 0;
        APIGalleryCustomListphotoCanNext = YES;
        APIGalleryCustomListphotoListphoto = [[NSMutableArray alloc] init];
    }
    [self performSelectorInBackground:@selector(bgthreadLoadmoreGalleryCustomListphoto) withObject:nil];
}

#pragma mark - Button delegate

-(void) menuButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) handleSwipe:(UIGestureRecognizer *)gesture{
    if (galleryPhotoCollectionView.collectionViewLayout == chtLayOut)
    {
        [largeLayout invalidateLayout];
        [galleryPhotoCollectionView setCollectionViewLayout:largeLayout animated:YES];
    }
    else
    {
        [chtLayOut invalidateLayout];
        [galleryPhotoCollectionView setCollectionViewLayout:chtLayOut animated:YES];
    }

}



#pragma mark - Collection view datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [APIGalleryCustomListphotoListphoto count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    NSDictionary *APIGalleryCustomListphotoListphotoItem =(NSDictionary *)[APIGalleryCustomListphotoListphoto objectAtIndex:indexPath.row];
    
    // CELL
    // =====
    GalleryPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"galleryPhotoCellIdentifier" forIndexPath:indexPath];
    [cell setInfo:APIGalleryCustomListphotoListphotoItem];
    
    return cell;
}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // get ra data item
    //NSDictionary *APIGalleryCustomListphotoListphotoItem =(NSDictionary *)[APIGalleryCustomListphotoListphoto objectAtIndex:indexPath.row];
    // he he he
    // ha ha ha
    
    // VIDEO DETAIL VIEW
    // =====
    PhotosViewController *photosViewController = [[PhotosViewController alloc] init];
    
    
    // push len thoi
    photosViewController.photosGallery = APIGalleryCustomListphotoListphoto;
    photosViewController.photoGalleryName = name;
    photosViewController.currentPhotoId = indexPath.row;
    [self.navigationController pushViewController:photosViewController animated:YES];
    
    return NO;
}

- (NSMutableArray *)cellSizes {
    if (!cellSizes) {
        cellSizes = [NSMutableArray array];
        for (NSInteger i = 0; i < 19; i++) {
            CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
            cellSizes[i] = [NSValue valueWithCGSize:size];
        }
    }
    return cellSizes;
}


#pragma mark - Collection view layout (Waterfall Layout) delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellSizes[indexPath.item] CGSizeValue];
}




#pragma mark - Network Get json, data from server


// JSON GET/POST DATA FROM API METHODS
// =============
-(void)getGalleryHasId:(int)localGalleryId listphotoStart:(int)start limit:(int)limit
{
    //NSLog(@"getGallery:%d listphotoStart:%d limit:%d ...", localGalleryId, start, limit);

    NSDictionary *listphotoDictionary = [ManageSize getDictionaryJSONFromServerWithAPIPath:[NSString stringWithFormat:@"gallery/hasid/%i/listphoto/start/%i/limit/%i", localGalleryId, start, limit]];
    
    // xem coi co load ra ok ko, neu nhu khong ok thi thoi
    if(listphotoDictionary == NULL)
        return;
    
    // check code return
    NSString *code = (NSString *)[listphotoDictionary objectForKey:@"code"];
    if([code intValue] != 200)
        return;
    
    // get the data
    NSDictionary *data = (NSDictionary *)[listphotoDictionary objectForKey:@"data"];
    if(data == NULL)
        return;
    
    // get 1 so thu trong data
    NSString *dataStart = (NSString *)[data objectForKey:@"start"];
    NSString *dataLimit = (NSString *)[data objectForKey:@"limit"];
    id        dataNext  =  [data objectForKey:@"next"];
    NSArray *listphoto = (NSArray *)[data objectForKey:@"listphoto"];
    
    // update 1 so thu trong self
    APIGalleryCustomListphotoStart = [dataStart intValue] + [dataLimit intValue];
    APIGalleryCustomListphotoCanNext = (dataNext != [NSNull null]);
    
    
    // lap 1 vong tren listphoto vua moi get tu json ve de ma bo sung data
    for(NSDictionary *listphotoItem in listphoto)
    {
        NSString *id            = (NSString *)[listphotoItem objectForKey:@"id"];
        NSString *imageSource   = [(NSDictionary *)[listphotoItem objectForKey:@"image"] objectForKey:@"source"];
        NSString *caption       = (NSString *)[listphotoItem objectForKey:@"caption"];
        
        // download image from server
        UIImage *image = [ManageSize getImageFromServer:imageSource];
        
        // create new item dictionary
        NSDictionary *APIGalleryCommonListphotoListphotoItem = @{@"id": id, @"image": image, @"caption": caption};
        
        // add to current list
        [APIGalleryCustomListphotoListphoto addObject:APIGalleryCommonListphotoListphotoItem];
        
    }
    
    //NSLog(@"getGallery: %d listphotoStart:%d limit:%d -> done!", galleryId, start, limit);
}




#pragma mark - Scroll delegate


// KEO XUONG DUOI CUNG THI SE LOAD THEM DATA
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float contentOffsetY = (float)scrollView.contentOffset.y;
    float contentHeight = (float)scrollView.contentSize.height;
    float scrollViewHeight = (float)scrollView.frame.size.height;
    
    // bat dau load new data
    if(APIGalleryCustomListphotoCanNext && contentHeight - contentOffsetY - scrollViewHeight < 500)
        [self performSelectorInBackground:@selector(bgthreadLoadmoreGalleryCustomListphoto) withObject:nil];
}




#pragma mark - Background and main thread

-(void)bgthreadLoadmoreGalleryCustomListphoto
{
    if(bgthreadLoadmoreGalleryCustomListphotoIsRunning)
        return;
    
    // bat dau running...
    bgthreadLoadmoreGalleryCustomListphotoIsRunning = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [galleryPhotoActivityIndicator setHidden:NO];
        [galleryPhotoActivityIndicator startAnimating];
    });
    
    // load post
    [self getGalleryHasId:galleryId listphotoStart:APIGalleryCustomListphotoStart limit:10];
    
    // reload view in main thread
    [self performSelectorOnMainThread:@selector(mainthreadLoadmoreGalleryCustomListphoto) withObject:nil waitUntilDone:YES];
    
}
-(void)mainthreadLoadmoreGalleryCustomListphoto
{
    [galleryPhotoCollectionView reloadData];
    
    // done!
    bgthreadLoadmoreGalleryCustomListphotoIsRunning = NO;
    [galleryPhotoActivityIndicator stopAnimating];
    [galleryPhotoActivityIndicator setHidden:YES];
}





@end
