//
//  NSDictionary+JSONCategories.m
//  workwithjson
//
//  Created by Huy Phan on 2/27/14.
//  Copyright (c) 2014 Huy Phan. All rights reserved.
//

#import "NSDictionary+JSONCategories.h"

@implementation NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfURLString:(NSString*)urlAddress
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
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (error != nil)return nil;

    return result;
    
    
    // OLD
    // ---
    //NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlAddress]];
    //if(data == nil)return nil;
    //__autoreleasing NSError* error = nil;
    //id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //if (error != nil)return nil;
    //return result;
}

-(NSData*)toJSON
{
    if(self == nil)return nil;
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

-(NSString*)toJSONString
{
    NSData *json = [self toJSON];
    if(json == nil)return nil;
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

@end
