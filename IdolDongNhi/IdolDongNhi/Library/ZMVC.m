//
//  ZMVC.m
//  work with server built on zmvc
//
//  Created by Huy Phan on 2/27/14.
//  Copyright (c) 2014 Huy Phan. All rights reserved.
//

#import "ZMVC.h"

@implementation ZMVC

+(NSDictionary *)getDictionaryJSONFromServer:(NSString *)urlString
{
    NSString *userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.117 Safari/537.36";
    //NSString *zmvcsessid = @"ha719hsuw82jdg92h8cb33n823hi91";
    
    //NSLog(@"urlString: %@", urlString);
    
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    //[request setValue:zmvcsessid forHTTPHeaderField:@"ZMVC-Sessid"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error != nil)return nil;
    
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
    
    NSArray *allCookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[urlResponse allHeaderFields] forURL:[response URL]];
    //NSLog(@"allCookies: %@", allCookies);
    
    
    if ([allCookies count]) {
        
        // save lai cai cookie nay thoi
        //[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:allCookies forURL:[response URL] mainDocumentURL:nil];
    }
    
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (error != nil)return nil;
    
    return result;
}

@end
