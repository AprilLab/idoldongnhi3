//
//  UIImage+JSONCategories.h
//  workwithjson
//
//  Created by Huy Phan on 2/27/14.
//  Copyright (c) 2014 Huy Phan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(JSONCategories)

+(UIImage*)imageWithContentsOfURLString:(NSString*)urlAddress;

-(void)loadImageWithURL:(NSURL *)imageUrl;

@end
