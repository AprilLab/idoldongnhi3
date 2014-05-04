//
//  ManageSize.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/18/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#define APIURL @"//idol.april.com.vn/api/q/dongnhi/jsd2au1782ja7a980v1a39m01ospa02sm2diu281jkaagf627aumlspi72iuwpjcvws5d8jwinix8wushuw67/"
#define NEWSDETAILURL @"//idol.april.com.vn/news/detail/dongnhi/%d"

@interface ManageSize : NSObject

// method xu ly giao dien
+(void)toggleShowHideMusicBar;
+(void)showMusicBar;
+(void)hideMusicBar;
+(void)showMainMenu;
+(void)hideMainMenu;
+(void)fixSize;

// method cho viec luu tru
+(void)setObject:(NSObject *)object forKey:(NSString *)key;
+(id)objectForKey:(NSString *)key;

// method helper choi choi
+(BOOL) isEmpty:(id)thing;

// method cho viec get data from server
+(NSString *)addHTTP:(NSString *)string;
+(NSDictionary *)getDictionaryJSONFromServerWithAPIPath:(NSString *)APIPath;
+(NSDictionary *)getDictionaryJSONFromServer:(NSString *)url;
+(UIImage *)getImageFromServer:(NSString *)url;


@end
