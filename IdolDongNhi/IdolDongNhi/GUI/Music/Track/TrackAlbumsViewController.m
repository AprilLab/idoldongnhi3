//
//  TrackAlbumsViewController.m
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "TrackAlbumsViewController.h"
#import "AUIFreedomController.h"
#import "AUITabBar.h"
#import "PlayingMusicView.h"
#import "ManageSize.h"
#import "UIImageView+AWebCache.h"


@interface TrackAlbumsViewController ()
{
    UILabel *trackTitle;
    UIImageView *trackImageView;
    UILabel *trackLyrics;
    UIButton *playAndPause;
    UIButton *nextButton;
    UIButton *prevButton;
    UISlider *slidingMusic;
    UIProgressView *progressDownload;
    UILabel *preSliding;
    UILabel *endSliding;
    UILabel * totalLike;
    UILabel * totalComment;
    
    //
    UIActivityIndicatorView *preparingSongActivityIndicator;
    
    // variable dung cho background thread
    NSInteger preparingSongId;
}

@end

@implementation TrackAlbumsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // bat dau khoi tao giao dien
    [self.view setClipsToBounds:YES];
    
    
    // BACKGROUND
    // =====
    [self.view setBackgroundColor:[UIColor blackColor]];
    UIImage *bg_newsview = [UIImage imageNamed:@"bg_blur_2_not_include_navigation.png"];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bg_newsview];
    bgImageView.frame = CGRectMake(0, 0, bg_newsview.size.width, bg_newsview.size.height);
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    
    // LEFT NAVIGATION BUTTON
    // =====
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuButtonClick)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
    // TITLE
    // =====
    //self.navigationItem.title = @"ÂM NHẠC";
    //self.navigationItem.title = [self.trackInfo objectForKey:@"title"];
    
    
    // TABBAR
    // =====
    // boi vi trang am nhac thi khong co tab nao het
    // nen tabbar dua vao chi voi muc dich
    // show ra cai line (1px) mau hong, va cai shadow thoi
    
    AUITabBar *aTabbar = [[AUITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    UIColor *myPinkColor = [UIColor colorWithRed:(float)237/255 green:0 blue:(float)140/255 alpha:1];
    [aTabbar setBackgroundColor:myPinkColor];
    [aTabbar setBottomShadowImage:[UIImage imageNamed:@"tabbar_bottom_shadow.png"]];
    [self.view addSubview:aTabbar];
    
    
    
    
    // HINH CAI DISC QUAY QUAY
    // =====
    // hien hinh cai dia quay quay du du
    
    UIImageView *discView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 16, 211, 211)];
    [discView setImage:[UIImage imageNamed:@"disc"]];
    [self.view addSubview:discView];
    
    JingRoundView *jround = [[JingRoundView alloc] initWithFrame:CGRectMake(30, 30, 150, 150)];
    [jround setRoundImage:[ManageSize getImageFromServer:[self.albumInfo objectForKey:@"imageSource"]]];
    [jround setRotationDuration:8.0];
    [jround setIsPlay:YES];
    [discView addSubview:jround];
    
    UIImageView *discPlayView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 211, 211)];
    discPlayView.image = [UIImage imageNamed:@"disc_play"];
    [discView addSubview:discPlayView];
    

    
    // LYRIC
    // =====
/*
    trackLyrics = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 90)];
    trackLyrics.textAlignment= NSTextAlignmentCenter;
    trackLyrics.font= [UIFont fontWithName:@"Arial" size:10];
    [trackLyrics setNumberOfLines:0];
    [trackLyrics setText:@"Từng đêm ngày qua từ đâu chợt em nhận ra ánh mắt đắm say cứ mãi dõi theo bóng ai từng giây   \nKìa em là ai làm bao vệ tinh khờ dại cứ thế khiến cho bao anh ngất ngây mong em về đây   \nHey boy, I wanna be with you, I couldn't tell I'm away from the truth   \nHey boy, I wanna be with you, I couldn't tell I'm away from the truth   \nSao anh cứ mãi lạnh lùng , sao anh cứ mãi ngại ngùng để em từng đêm ngu ngơ mong anh   \n  Cho em theo bước bên anh cho nhau giây phút ngọt ngào để tay cầm tay đi trong yêu thương mãi về sau     \nI wanna be with you  \nI wanna be with you"];
    // [self.view addSubview:self.trackLyrics];
    // add long text to label
    // set line break mode to word wrap
    trackLyrics.lineBreakMode = NSLineBreakByWordWrapping;
    // set number of lines to zero
    trackLyrics.numberOfLines = 0;
    // resize label
    [trackLyrics sizeToFit];
    
    UIScrollView *viewScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 250, 300, 40)];
    viewScroll.scrollEnabled = YES;
    viewScroll.showsVerticalScrollIndicator = YES;
    
    [viewScroll setContentSize:CGSizeMake(trackLyrics.frame.size.width, trackLyrics.frame.size.height)];
    [viewScroll addSubview:trackLyrics];
    [self.view addSubview:viewScroll];
    
    [trackLyrics setTextColor:[UIColor whiteColor]];
 
*/
  
    
    
    
    // MUSIC CONTROL BUTTONS
    // ======
    // add cac button, thanh progress de dieu khien nhac
    
    // tao ra 1 cai view nho nho de add het may cai control vao
    UIView *musicControlsBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 78 /*height*/ - 22 /*stt*/ - 42 /*nav*/, 320, 78)];
    [self.view addSubview:musicControlsBar];
    
    // current duration
    preSliding = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    [preSliding setTextColor:[UIColor whiteColor]];
    [preSliding setFont:[UIFont systemFontOfSize:12]];
    [preSliding setTextAlignment:NSTextAlignmentRight];
    [musicControlsBar addSubview:preSliding];
    
    // end
    endSliding = [[UILabel alloc] initWithFrame:CGRectMake(280, 0, 40, 20)];
    [endSliding setTextColor:[UIColor whiteColor]];
    [endSliding setFont:[UIFont systemFontOfSize:12]];
    [musicControlsBar addSubview:endSliding];
    
    // progress bar
    progressDownload = [[UIProgressView alloc] initWithFrame:CGRectMake(47, 10, 226, 5)];
    [progressDownload setProgressViewStyle:UIProgressViewStyleDefault];
    [progressDownload setTintColor:[UIColor colorWithRed:113.0/255 green:68.0/255 blue:176.0/255 alpha:1]];
    [progressDownload setProgress:0];
    [musicControlsBar addSubview:progressDownload];
    
    // sliding duration
    slidingMusic = [[UISlider alloc] initWithFrame:CGRectMake(45, 4, 230, 13)];
    [slidingMusic setBackgroundColor:[UIColor clearColor]];
    [slidingMusic setMaximumTrackTintColor:[UIColor clearColor]];
    [slidingMusic addTarget:self action:@selector(actionPlayingSliding:) forControlEvents:UIControlEventValueChanged];
    [slidingMusic setTintColor:[UIColor colorWithRed:237.0/255.0 green:0 blue:140.0/255.0 alpha:1.0]];
    [slidingMusic setThumbImage:[UIImage imageNamed:@"music_slider"] forState:UIControlStateNormal];
    [musicControlsBar addSubview:slidingMusic];
    
    // settimer update control
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scheduledTimerUpdateTime:) userInfo:nil repeats:YES];
    
    //prev button
    prevButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 31, 25, 25)];
    [prevButton setImage:[UIImage imageNamed:@"icon_prev_25x25.png"] forState:UIControlStateNormal];
    [prevButton addTarget:self action:@selector(actionPrevSong:) forControlEvents:UIControlEventTouchUpInside];
    [musicControlsBar addSubview:prevButton];
    
    // next Button
    nextButton = [[UIButton alloc] initWithFrame:CGRectMake(203, 31, 25, 25)];
    [nextButton setImage:[UIImage imageNamed:@"icon_next_25x25.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(actionNextSong:) forControlEvents:UIControlEventTouchUpInside];
    [musicControlsBar addSubview:nextButton];
    
    // play/pause button
    playAndPause = [[UIButton alloc] initWithFrame:CGRectMake(142, 26, 34, 34)];
    [playAndPause setImage:[UIImage imageNamed:@"icon_play_34x34.png"] forState:UIControlStateNormal];
    [playAndPause addTarget:self action:@selector(actionTogglePlayAndPause:) forControlEvents:UIControlEventTouchUpInside];
    [musicControlsBar addSubview:playAndPause];
    
    
    // repeat
    UIButton *mRepeat = [[UIButton alloc] initWithFrame:CGRectMake(68, 31, 18, 18)];
    [mRepeat setImage:[UIImage imageNamed:@"icon_repeat_18x18.png"] forState:UIControlStateNormal];
    //[musicControlsBar addSubview:mRepeat];
    
    // suffure
    UIButton *mSuff = [[UIButton alloc] initWithFrame:CGRectMake(235, 31, 18, 18)];
    [mSuff setImage:[UIImage imageNamed:@"icon_random_18x18.png"] forState:UIControlStateNormal];
    //[musicControlsBar addSubview:mSuff];
    
    
 
    
    // LIKE, COMMENT
    // =====
/*
    // like
    UIView * likeView= [[UIView alloc] initWithFrame:CGRectMake(58, 310, 110, 40)];
    UIImageView *lImage= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    lImage.image= [UIImage imageNamed:@"like"];
    
    UILabel *lblText= [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 34, 15)];
    lblText.text= @"Like";
    lblText.textColor= [UIColor whiteColor];
    lblText.font= [UIFont fontWithName:@"Arial" size:11];
    
    UILabel *lblLike= [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 120, 20)];
    lblLike.text= @"155,987";
    lblLike.textColor= [UIColor whiteColor];
    lblLike.font= [UIFont fontWithName:@"Arial" size:16];
    
    [likeView addSubview:lImage];
    [likeView addSubview:lblText];
    [likeView addSubview:lblLike];
    
    [self.view addSubview:likeView];
    
    // comment
    UIView * commentView= [[UIView alloc] initWithFrame:CGRectMake(180, 310, 110, 40)];
    UIImageView *lImage= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    lImage.image= [UIImage imageNamed:@"mcomment"];
    
    UILabel *lblText= [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 120, 15)];
    lblText.text= @"Comment";
    lblText.textColor= [UIColor whiteColor];
    lblText.font= [UIFont fontWithName:@"Arial" size:11];
    
    UILabel *lblComment= [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 120, 20)];
    lblComment.text= @"3,251";
    lblComment.textColor= [UIColor whiteColor];
    lblComment.font= [UIFont fontWithName:@"Arial-Bold" size:16];
    
    [commentView addSubview:lImage];
    [commentView addSubview:lblText];
    [commentView addSubview:lblComment];
    
    [self.view addSubview:commentView];
*/
    
    
    
    
    
    // ============
    // bring tabbar to top
    [self.view bringSubviewToFront:aTabbar];
    
    // ============
    // set delegate cho share music playing
    [[PlayingMusicView sharePlaying] setDelegate:self];
    // vo day thi se khong can show thang music bar nay nua
    [ManageSize hideMusicBar];
    
    // ============
    // show thong tin cua track info ra view
    [self showPresentingTrackInfoToInterface];
}

-(void)showPresentingTrackInfoToInterface
{
    self.navigationItem.title = [self.trackInfo objectForKey:@"title"];
    
    // neu nhu dang play thi update lien giao dien
    if([[PlayingMusicView sharePlaying] getSongCurrentDuration] > 0)
    {
        [self scheduledTimerUpdateTime:nil];
    }
    
    // khong play thi moi update linh tinh
    else
    {
        [preSliding setText:@"--:--"];
        [endSliding setText:@"--:--"];
        
        [slidingMusic setValue:0];
        [progressDownload setProgress:0];
    }
}

#pragma mark - Button delegate

-(void) menuButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) actionPrevSong:(UIButton *) prevButton
{
    NSInteger playingSongId = [(NSString *)[self.trackInfo objectForKey:@"id"] integerValue];
    
    // xem coi current index cua cai song dang playing
    NSInteger playingSongIndex = [[PlayingMusicView sharePlaying] findSongIndexFromSongId:[[PlayingMusicView sharePlaying] listSongs] withId:playingSongId];
    
    // current list song
    NSMutableArray *playingListSong = (NSMutableArray *)[self.albumInfo objectForKey:@"tracks"];
    
    NSInteger prevSongIndex = playingSongIndex - 1;
    if(prevSongIndex < 0)
        prevSongIndex = [playingListSong count] - 1;
    
    [self startPreparePlayNewSongWithIndex:prevSongIndex];
}

- (void) actionNextSong:(UIButton *) nextButton
{
    NSInteger playingSongId = [(NSString *)[self.trackInfo objectForKey:@"id"] integerValue];
    
    // xem coi current index cua cai song dang playing
    NSInteger playingSongIndex = [[PlayingMusicView sharePlaying] findSongIndexFromSongId:[[PlayingMusicView sharePlaying] listSongs] withId:playingSongId];
    
    // current list song
    NSMutableArray *playingListSong = (NSMutableArray *)[self.albumInfo objectForKey:@"tracks"];
    
    NSInteger nextSongIndex = playingSongIndex + 1;
    if(nextSongIndex >= [playingListSong count])
        nextSongIndex = 0;
    
    [self startPreparePlayNewSongWithIndex:nextSongIndex];
}

- (void) actionTogglePlayAndPause: (UIButton *) sender
{
    PlayingMusicView *playingView = [PlayingMusicView sharePlaying];
    
    if([playingView isPlaying])
        [playingView pauseAudio];
    else
        [playingView playAudio];
    
    // update stage
    [self scheduledTimerUpdateTime:nil];
}

- (void) actionPlayingSliding:(UISlider *) sender
{
    PlayingMusicView *playingView = [PlayingMusicView sharePlaying];
    
    if([playingView isPlaying])
    {
        //playingView.audioPlayer.currentTime = sender.value;
        
        CMTime duration = playingView.avPlayer.currentItem.asset.duration;
        float seconds = CMTimeGetSeconds(duration);
        
        CMTime newTime = CMTimeMakeWithSeconds(sender.value * seconds, playingView.avPlayer.currentTime.timescale);
        [playingView.avPlayer seekToTime:newTime];
    }
    
}



#pragma mark - View life cercle

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    // presenting song id
    NSInteger presentingSongId = [(NSString *)[self.trackInfo objectForKey:@"id"] integerValue];
    NSLog(@"viewDidAppear: presentingSongId: %i", presentingSongId);
    
    // current playing song
    NSInteger currentPlayingSongId = [[PlayingMusicView sharePlaying] currentSongId];
    NSLog(@"viewDidAppear: currentPlayingSongId: %i", currentPlayingSongId);
    
    // neu nhu bai hat trong view nay
    // va bai hat he thong dang play khac nhau
    // thi se chuan bi de play bai hat trong view nay
    if(presentingSongId != currentPlayingSongId)
    {
        // bay gio se chuan bi de load cai bai hat nay
        [self startPreparePlayNewSongWithId:presentingSongId];
    }
    
    // neu nhu ma dang play bai hat nay luon
    // thi se update thong tin cho khop
    else
    {
        // update stage
        [self scheduledTimerUpdateTime:nil];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"here viewDidDisappear");
    
    // tat delegate
    [[PlayingMusicView sharePlaying] setDelegate:nil];
    
    // kiem tra xem coi co dang play nhac khong
    // neu nhu co thi se show len thanh music bar
    if([[PlayingMusicView sharePlaying] isPlaying] || [[PlayingMusicView sharePlaying] getSongCurrentDuration] > 0)
    {
        NSLog(@"here is playing");
        [ManageSize showMusicBar];
    }
}




#pragma mark - music playing delegate

- (void) didPlayingFinish
{
    // nhay qua bai tiep theo play thoi
    [[PlayingMusicView sharePlaying] pauseAudio];
    [self actionNextSong:nil];
}




#pragma mark - cac method giup cho qua trinh prepare play


-(void)startPreparePlayNewSongWithIndex:(NSInteger)songIndex
{
    // current list song
    NSMutableArray *playingListSong = (NSMutableArray *)[self.albumInfo objectForKey:@"tracks"];
    
    // tim ra song id dua vao song index
    NSInteger songId = [(NSString *)[(NSDictionary *)[playingListSong objectAtIndex:songIndex] objectForKey:@"id"] integerValue];
    
    // bat dau prepare
    [self startPreparePlayNewSongWithId:songId];
}

-(void)startPreparePlayNewSongWithId:(NSInteger)songId
{
    preparingSongId = songId;
    
    // current list song
    NSMutableArray *playingListSong = (NSMutableArray *)[self.albumInfo objectForKey:@"tracks"];
    
    // tim ra index tuong ung voi cai song id
    NSInteger newSongIndex = [[PlayingMusicView sharePlaying] findSongIndexFromSongId:playingListSong withId:songId];
    
    // neu nhu khong tim ra thi thoi
    if(newSongIndex < 0)
        return;
    
    // update lai trackinfo
    self.trackInfo = [(NSArray *)[self.albumInfo objectForKey:@"tracks"] objectAtIndex:newSongIndex];
    
    // update lai giao dien cho tuong ung voi trackinfo
    [self showPresentingTrackInfoToInterface];
    
    
    // tao ra 1 cai activity indicator
    // va che het toan bo view luon, de cho user khong the co active gi het
    //preparingSongActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //[preparingSongActivityIndicator setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //[preparingSongActivityIndicator setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    //[preparingSongActivityIndicator startAnimating];
    //[self.view addSubview:preparingSongActivityIndicator];
    
    
    //
    
    
    // ...
    
    // bay gio se cho cac task nang nhoc xuong background thread
    [self performSelectorInBackground:@selector(bgthreadPreparePlayNewSong) withObject:nil];
    
    
}

-(void)bgthreadPreparePlayNewSong
{
    PlayingMusicView *sharePlaying = [PlayingMusicView sharePlaying];
    
    // stop play truoc tien
    [sharePlaying pauseAudio];
    NSLog(@"sharePlaying pauseAudio");
    
    // update 1 so thu
    
    // dau tien la update listsong cua thang shareplaying
    // list song cua thang share playing cung se chinh la listtracks cua album hien tai
    sharePlaying.listSongs = (NSMutableArray *)[self.albumInfo objectForKey:@"tracks"];
    
    // update current song id
    sharePlaying.currentSongId = preparingSongId;
    
    // update current album
    sharePlaying.currentAlbumTitle = [self.albumInfo objectForKey:@"name"];
    sharePlaying.currentAlbumImage = [ManageSize getImageFromServer:[self.albumInfo objectForKey:@"imageSource"]];
    
    // tim ra link cua bai hat
    NSString *presentingSongUrl = [sharePlaying findSongUrlExternalFromSongId:sharePlaying.listSongs withId:preparingSongId];
    
    // chua bi de play thoi
    //[sharePlaying preparePlayWithExternalStringUrl:[ManageSize addHTTP:presentingSongUrl] andSongInfo:nil];
    
    // play
    //[sharePlaying playAudio];
    
    // chuan bi de play thoi
    [sharePlaying prepareInBackgroundToPlayNewSongWithExternalStringUrl:[ManageSize addHTTP:presentingSongUrl]];
    
    
    // sau do la quay lai main thread de goi call back thoi
    [self performSelectorOnMainThread:@selector(donePreparePlayNewSong) withObject:nil waitUntilDone:NO];
}

-(void)donePreparePlayNewSong
{
    // bay gio moi remove di cai indicator
    //[preparingSongActivityIndicator stopAnimating];
    //[preparingSongActivityIndicator removeFromSuperview];
}




#pragma mark - scheduled timer

- (void)scheduledTimerUpdateTime:(NSTimer *)timer
{
    PlayingMusicView *playingView = [PlayingMusicView sharePlaying];
    
    // chage button state
    [playAndPause setImage:[UIImage imageNamed:([playingView isPlaying]) ? @"icon_pause_34x34.png" : @"icon_play_34x34.png"] forState:UIControlStateNormal];
    
    
    if([playingView.avPlayer rate] != 0)
    {
        // change sliding
        CMTime currentTime = playingView.avPlayer.currentItem.currentTime;
        float seconds2 = CMTimeGetSeconds(currentTime);
        float seconds = [playingView getSongCurrentDuration];
        slidingMusic.value = seconds2 / seconds;
        
        int playedSecond = (int)seconds2 % 60;
        int playedMinuted = (int) seconds2 / 60;
        
        int remainSecond = (int)(seconds - seconds2) % 60;
        int remainMinuted = (int)(seconds - seconds2) / 60;
        
        // change sliding timing value
        preSliding.text = [NSString stringWithFormat:@"%d:%02d", playedMinuted, playedSecond];
        endSliding.text = [NSString stringWithFormat:@"%d:%02d", remainMinuted, remainSecond];
        
        
        NSArray *loadedTimeRanges = [[playingView.avPlayer currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        CMTime duration = playingView.avPlayer.currentItem.asset.duration;
        seconds = CMTimeGetSeconds(duration);
        progressDownload.progress = durationSeconds / seconds;
    }
}


@end
