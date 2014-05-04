//
//  VideoDetailController.h
//  April
//
//  Created by admin on 4/20/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoDetailController : UIViewController<UITabBarDelegate, UIWebViewDelegate>{
    MPMoviePlayerController *moviePlayer;
    NSDictionary *videoInfo;
    UIActivityIndicatorView *activityIndicator;
}

-(void)setItemInfo:(NSDictionary *)info;

@end
