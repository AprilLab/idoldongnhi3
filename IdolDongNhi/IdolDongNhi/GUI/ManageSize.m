//
//  ManageSize.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "ManageSize.h"
#import "AUIFreedomController.h"
#import "PlayingMusicView.h"
#import "MainMenuViewController.h"
#import "HomeViewController.h"
#import "NSDictionary+JSONCategories.h"
#import "UIImage+JSONCategories.h"
#import <SDWebImage/SDImageCache.h>

@interface ManageSize()

@end

@implementation ManageSize




// METHOD XU LY GIAO DIEN
// ========

#pragma mark - method xu ly giao dien

+(void)toggleShowHideMusicBar
{
    // get ra music bar va show/hide
    PlayingMusicView *playingMusicBar = [[AUIFreedomController sharedFreedomController] getChildViewControllerWithName:@"playingMusicBar"];
    [playingMusicBar toggleShowHideWithDuration:0.2 delay:0];
    
    // sau do di fix size
    [ManageSize fixSize];
}
+(void)showMusicBar
{
    PlayingMusicView *playingMusicBar = [[AUIFreedomController sharedFreedomController] getChildViewControllerWithName:@"playingMusicBar"];
    [playingMusicBar showAnimatedWithDuration:0.2 delay:0];
    
    // sau do di fix size
    [ManageSize fixSize];
}
+(void)hideMusicBar
{
    PlayingMusicView *playingMusicBar = [[AUIFreedomController sharedFreedomController] getChildViewControllerWithName:@"playingMusicBar"];
    [playingMusicBar hideAnimatedWithDuration:0.2 delay:0];
    
    // sau do di fix size
    [ManageSize fixSize];
}
+(void)showMainMenu
{
    //[[AUIFreedomController sharedFreedomController] changeChildViewControllerFrame:CGRectNull withName:@"mainMenu" withDuration:0.2 delay:0];
    
    MainMenuViewController *mainMenu = [[AUIFreedomController sharedFreedomController] getChildViewControllerWithName:@"mainMenu"];
    [mainMenu.view setHidden:NO];
}
+(void)hideMainMenu
{
    //[[AUIFreedomController sharedFreedomController] changeChildViewControllerFrame:CGRectMake(0, 0, [[AUIFreedomController sharedFreedomController] getWidth], 0) withName:@"mainMenu" withDuration:0.2 delay:0];
    
    MainMenuViewController *mainMenu = [[AUIFreedomController sharedFreedomController] getChildViewControllerWithName:@"mainMenu"];
    [mainMenu.view setHidden:YES];
}

+(void)fixSize
{
    // nhiem vu cua ham fix size
    // la se di vao tat ca moi thang de goi ham fix size cua thang do
    
    PlayingMusicView *playingMusicBar = [PlayingMusicView sharePlaying];
    int screenWidth = [[AUIFreedomController sharedFreedomController] getWidth];
    int screenHeight = [[AUIFreedomController sharedFreedomController] getHeight];
    
    
    // HOME VIEW
    // GALLERY VIEW
    // =======
    int tempX = 0;
    int tempY = 0;
    int tempW = screenWidth;
    int tempH = screenHeight - (playingMusicBar.isHide ? 0 : playingMusicViewHeight);
    
    [[AUIFreedomController sharedFreedomController] changeChildViewControllerFrame:CGRectMake(tempX, tempY, tempW, tempH) withName:@"mainWrapper" withDuration:0.2 delay:0];
    //[[AUIFreedomController sharedFreedomController] changeChildViewControllerFrame:CGRectMake(tempX, tempY, tempW, tempH) withName:@"galleryView" withDuration:0.2 delay:0];
    
    
    
    
    // TAB POST - COLLECTION VIEW
    // TAB - MV DONG NHI - COLLECTION VIEW
    // TAB - VIDEO KHAC - COLLECTION VIEW
    // =======
    UICollectionView *tabPostCollectionView = (UICollectionView *)[ManageSize objectForKey:@"tabPostCollectionView"];
    UICollectionView *tabNewsCollectionView = (UICollectionView *)[ManageSize objectForKey:@"tabNewsCollectionView"];
    UICollectionView *tabMVCollectionView = (UICollectionView *)[ManageSize objectForKey:@"MVCollectionView"];
    UICollectionView *tabOtherCollectionView = (UICollectionView *)[ManageSize objectForKey:@"OtherCollectionView"];
    UICollectionView *galleryAlbumCollectionView = (UICollectionView *)[ManageSize objectForKey:@"galleryAlbumCollectionView"];
    UICollectionView *albumCollectionView = (UICollectionView *)[ManageSize objectForKey:@"albumCollectionView"];
    UICollectionView *listTrackCollectionView = (UICollectionView *)[ManageSize objectForKey:@"listTrackCollectionView"];
    
    // co tabbar {
    tempW = screenWidth;
    tempH = screenHeight - 22 /*stt*/ - 42 /*nav*/ - 32 /*tab*/ - (playingMusicBar.isHide ? 0 : playingMusicViewHeight);
    
    if(tabPostCollectionView != NULL)
        [tabPostCollectionView setFrame:CGRectMake(tabPostCollectionView.frame.origin.x, tabPostCollectionView.frame.origin.y, tempW, tempH)];
    
    if(tabNewsCollectionView != NULL)
        [tabNewsCollectionView setFrame:CGRectMake(tabNewsCollectionView.frame.origin.x, tabNewsCollectionView.frame.origin.y, tempW, tempH)];
    
    if(tabMVCollectionView != NULL)
        [tabMVCollectionView setFrame:CGRectMake(tabMVCollectionView.frame.origin.x, tabMVCollectionView.frame.origin.y, tempW, tempH)];
    
    if(tabOtherCollectionView != NULL)
        [tabOtherCollectionView setFrame:CGRectMake(tabOtherCollectionView.frame.origin.x, tabOtherCollectionView.frame.origin.y, tempW, tempH)];
    // }
    
    // khong co tabbar {
    tempH = screenHeight - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - (playingMusicBar.isHide ? 0 : playingMusicViewHeight);
    
    if(galleryAlbumCollectionView != NULL)
        [galleryAlbumCollectionView setFrame:CGRectMake(galleryAlbumCollectionView.frame.origin.x, galleryAlbumCollectionView.frame.origin.y, tempW, tempH)];
    
    if(albumCollectionView != NULL)
        [albumCollectionView setFrame:CGRectMake(albumCollectionView.frame.origin.x, albumCollectionView.frame.origin.y, tempW, tempH)];
    // }
    
    // trang musc {
    tempH = screenHeight - 22 /*stt*/ - 42 /*nav*/ - 1 /*tab*/ - 215 /*top*/ - ([[PlayingMusicView sharePlaying] isHide] ? 0 : playingMusicViewHeight);
    if(listTrackCollectionView != NULL)
        [listTrackCollectionView setFrame:CGRectMake(0, 216, tempW, tempH)];
    // }
}




// METHOD CHO VIEC LUU TRU
// =====

#pragma mark - method cho viec luu tru

+(void)setObject:(NSObject *)object forKey:(NSString *)key
{
    // dau tien la lay ra cai dic than thanh
    NSMutableDictionary *staticDic = [ManageSize dic];
    
    // set noi dung vo
    [staticDic setObject:object forKey:key];
}

+(id)objectForKey:(NSString *)key
{
    // dau tien la lay ra cai dic than thanh
    NSMutableDictionary *staticDic = [ManageSize dic];

    // get noi dung
    return [staticDic objectForKey:key];
}

+(NSMutableDictionary *)dic
{
    static NSMutableDictionary *staticDic = Nil;
    if(staticDic == Nil)
    {
        staticDic = [[NSMutableDictionary alloc] init];
    }
    
    return staticDic;
}



// METHOD HELPER CHOI CHOI
// =====

+(BOOL) isEmpty:(id)thing
{
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}



// METHOD CHO VIEC GET DATA FROM SERVER
// =====

#pragma mark - method cho viec get data from server

+(NSString *)addHTTP:(NSString *)string
{
    // kiem tra xem coi url string co "http:" chua
    // neu nhu chua co thi se tu dong them vao
    NSRange searchResult = [string rangeOfString:@"http://"];
    if(searchResult.location == NSNotFound)
        string = [NSString stringWithFormat:@"http:%@", string];
    
    return string;
}

+(NSDictionary *)getDictionaryJSONFromServerWithAPIPath:(NSString *)APIPath
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", APIURL, APIPath];
    return [ManageSize getDictionaryJSONFromServer:urlString];
}

+(NSDictionary *)getDictionaryJSONFromServer:(NSString *)urlString
{
    urlString = [ManageSize addHTTP:urlString];
    
    //NSString *userAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Mobile/11D167";
    NSString *userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36";
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error != nil)return nil;
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (error != nil)return nil;
    
    return result;
}

+(UIImage *)getImageFromServer:(NSString *)urlString
{
    urlString = [ManageSize addHTTP:urlString];
    
    // kiem tra trong cache truoc cho chac
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
    if(cacheImage != nil)
        return cacheImage;
                           
    // bat dau tao user agent de co the load tu server
    NSString *userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36";
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    //[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error != nil)return nil;
    
    UIImage *image = [UIImage imageWithData:responseData];
    
    // save vao cache 1 phat truoc khi return
    [[SDImageCache sharedImageCache] storeImage:image forKey:urlString];
    
    return image;
}

@end

