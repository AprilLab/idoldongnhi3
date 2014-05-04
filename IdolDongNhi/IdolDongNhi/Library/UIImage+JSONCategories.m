//
//  UIImage+JSONCategories.m
//  workwithjson
//
//  Created by Huy Phan on 2/27/14.
//  Copyright (c) 2014 Huy Phan. All rights reserved.
//

#import "UIImage+JSONCategories.h"

@implementation UIImage(JSONCategories)
+(UIImage*)imageWithContentsOfURLString:(NSString*)urlAddress
{
    
    NSString *userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36";
    NSURL *url = [NSURL URLWithString: urlAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error != nil)return nil;
    
    UIImage *image = [UIImage imageWithData:responseData];
    return image;
}

-(void)loadImageWithURL:(NSURL *)imageUrl
{
    
}

@end
