//
//  NewsDetailController.h
//  April
//
//  Created by admin on 4/20/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface NewsDetailController : UIViewController<UITabBarDelegate, UIWebViewDelegate>

-(void)setInfo:(NSDictionary *)info;

@end
