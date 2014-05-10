//
//  ZMVC.h
//  work with server built on zmvc
//
//  Created by Huy Phan on 2/27/14.
//  Copyright (c) 2014 Huy Phan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMVC : NSObject

+(NSDictionary *)getDictionaryJSONFromServer:(NSString *)urlString;

@end
