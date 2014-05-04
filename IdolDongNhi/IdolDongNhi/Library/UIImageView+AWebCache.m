//
//  UIImageView+AWebCache.h
//  workwithjson
//
//  Created by Huy Phan on 2/27/14.
//  Copyright (c) 2014 Huy Phan. All rights reserved.
//


#import "UIImageView+AWebCache.h"
#import <SDWebImage/SDImageCache.h>


// Helper class

@interface UIImageViewAWebCacheHelper : UIView
{
    UIImage *downloadImage;
    NSString *downloadUrlString;
    UIImageView *bootImageView;
}

- (void)loadImage:(UIImageView *)imageView withURLString:(NSString *)urlString;

@end

@implementation UIImageViewAWebCacheHelper

-(void)loadImage:(UIImageView *)imageView withURLString:(NSString *)urlString
{
    if(imageView == nil)return;
    bootImageView = imageView;
    
    if(urlString == nil)return;
    
    // kiem tra xem coi url string co "http:" chua
    // neu nhu chua co thi se tu dong them vao
    NSRange searchResult = [urlString rangeOfString:@"http://"];
    if(searchResult.location == NSNotFound)
        urlString = [NSString stringWithFormat:@"http:%@", urlString];
    
    downloadUrlString = urlString;
    
    // bay gio se check xem coi co cache cai image nay truoc do hay chua
    downloadImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:downloadUrlString];
    if(downloadImage == nil){
        // bat dau download image thoi
        [self performSelectorInBackground:@selector(bgthreadStartDownloadImage) withObject:nil];
        
        return;
    }
    
    [self mainthreadDoneDownloadImage];
}

-(void)bgthreadStartDownloadImage
{
    // bat dau download
    downloadImage = [self getImageFromServer:downloadUrlString];
    
    // download xong thi cache lai
    if(downloadImage != nil)
        [[SDImageCache sharedImageCache] storeImage:downloadImage forKey:downloadUrlString];
    
    // sau do se quay ve main thread chay
    [self performSelectorOnMainThread:@selector(mainthreadDoneDownloadImage) withObject:nil waitUntilDone:NO];
}

-(void)mainthreadDoneDownloadImage
{
    // kiem tra coi cai image download ve co ok khong
    if(downloadImage == nil)return;
    
    // neu ok thi set thoi
    [bootImageView setImage:downloadImage];
}


-(UIImage *)getImageFromServer:(NSString *)urlString
{
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
    return image;
}

@end




@implementation UIImageView (AWebCache)

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The downloand is asynchronous and cached.
 *
 * @param url The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see setImageWithURL:placeholderImage:options:
 */
- (void)loadImageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder
{
    // neu nhu co placeholder thi cu set truoc roi tinh sau
    if(placeholder != nil)
        [self setImage:placeholder];
    
    UIImageViewAWebCacheHelper *imageViewAWebCacheHelper = [[UIImageViewAWebCacheHelper alloc] init];
    [imageViewAWebCacheHelper loadImage:self withURLString:urlString];
}

@end


