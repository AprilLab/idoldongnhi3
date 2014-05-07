//
//  PlayingMusicView.m
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/23/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "PlayingMusicView.h"
#import "JingRoundView.h"
#import "ManageSize.h"



@interface PlayingMusicView()
{
    UIButton *playPauseButton;
    UIButton *nextButon;
    UIButton *prevButton;
    UIProgressView *progressView;
    UIImageView *albumArt;
    UILabel *labelSongTimer;
    UILabel *labelSongTitle;
    UILabel *labelSongAlbumName;
    UISlider *progressDuration;
    UIProgressView *progressDownload;

}
@end

@implementation PlayingMusicView

// noname function to DEFINE time loaded for avplayer
void *kdcTimeRangesLoaded         = &kdcTimeRangesLoaded;

static id sharePlaying;

+ (id)sharePlaying
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharePlaying = [[self alloc] init];
    });
    return sharePlaying;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
   
    
    UIFont *fontBold = [UIFont fontWithName:@"OpenSans-Bold" size:13];
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:12];
    UIFont *fontRegularSmall = [UIFont fontWithName:@"OpenSans" size:8.5];
    UIColor *myPinkColor = [UIColor colorWithRed:237.0/255 green:0 blue:140.0/255 alpha:1];
    
    
    // HINH CAI DISC QUAY QUAY
    // =======
    UIImageView *bgDiscImave = [[UIImageView alloc] initWithFrame:CGRectMake(24, 14, 35, 35)];
    [bgDiscImave setImage:[UIImage imageNamed:@"disc_35x35.png"]];
    [self.view addSubview:bgDiscImave];
    
    //JingRoundView *jround = [[JingRoundView alloc] initWithFrame:CGRectMake(28, 9, 35, 35)];
    //[jround setRoundImage:[UIImage imageNamed:@"disc_35x35.png"]];
    //[jround.layer setBorderWidth:0];
    //[jround.layer setShadowRadius:0];
    //[jround setRotationDuration:8.0];
    //[jround setIsPlay:YES];
    //[self.view addSubview:jround];
    
    
    
    // ALBUM ART COVER
    // ======
    albumArt = [[UIImageView alloc ] initWithFrame:CGRectMake(10, 12, 40, 40)];
    [albumArt setClipsToBounds:YES];
    [albumArt setImage:[UIImage imageNamed:@"moving-image.jpg"]];
    [albumArt setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:albumArt];
    
    
    // TIMER
    // =====
    labelSongTimer = [[UILabel alloc] initWithFrame:CGRectMake(65, 11, 150, 10)];
    //[labelSongTimer setBackgroundColor:[UIColor redColor]];
    [labelSongTimer setText:@"--:--"];
    [labelSongTimer setFont:fontRegularSmall];
    [labelSongTimer setTextColor:myPinkColor];
    [self.view addSubview:labelSongTimer];
    
    
    // SONG TITLE
    // =====
    labelSongTitle = [[UILabel alloc] initWithFrame:CGRectMake(65, 21, 160, 18)];
    [labelSongTitle setText:@""];
    //[labelSongTitle setBackgroundColor:[UIColor redColor]];
    [labelSongTitle setFont:fontBold];
    [labelSongTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:labelSongTitle];
    
    
    // ALBUM NAME
    // =====
    labelSongAlbumName = [[UILabel alloc] initWithFrame:CGRectMake(65, 39, 160, 14)];
    [labelSongAlbumName setText:@""];
    //[labelSongAlbumName setBackgroundColor:[UIColor redColor]];
    [labelSongAlbumName setFont:fontRegular];
    [labelSongAlbumName setTextColor:[UIColor whiteColor]];
    [self.view addSubview:labelSongAlbumName];
    
    
    
    //prev button
    prevButton = [[UIButton alloc] initWithFrame:CGRectMake(227, 20, 25, 25)];
    [prevButton setImage:[UIImage imageNamed:@"icon_prev_25x25"] forState:UIControlStateNormal];
    [prevButton addTarget:self action:@selector(prevSongAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:prevButton];
    
    
    // play button
    playPauseButton = [[UIButton alloc] initWithFrame:CGRectMake(255, 15, 34, 34)];
    [playPauseButton setImage:[UIImage imageNamed:@"icon_play_34x34"] forState:UIControlStateNormal];
    [playPauseButton addTarget:self action:@selector(togglePlayAndPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playPauseButton];
    
    // next Button
    
    nextButon = [[UIButton alloc] initWithFrame:CGRectMake(292, 20, 25, 25)];
    [nextButon setImage:[UIImage imageNamed:@"icon_next_25x25"] forState:UIControlStateNormal];
    [nextButon addTarget:self action:@selector(nextSongAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButon];
    
    
    
    // progress View download
    progressDownload = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [progressDownload setFrame:CGRectMake(0, 0, 320, 5)];
    [progressDownload setTintColor:[UIColor colorWithRed:113.0/255 green:68.0/255 blue:176.0/255 alpha:1]];
    [self.view addSubview:progressDownload];
    
    
    // slider duration
    progressDuration = [[UISlider alloc] initWithFrame:CGRectMake(-2, -4, 322, 10)];
    [progressDuration addTarget:self action:@selector(playingSliding:) forControlEvents:UIControlEventValueChanged];
    
    [progressDuration setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"min_track"]]];
    
    [progressDuration setThumbImage:[UIImage imageNamed:@"music_slider"] forState:UIControlStateNormal];
    
    [progressDuration setMinimumTrackImage:[UIImage imageNamed:@"min_track"] forState:UIControlStateNormal];
    [progressDuration setMaximumTrackTintColor:[UIColor clearColor]];
    
    [self.view addSubview:progressDuration];
    
    self.isHide = YES;
    
    
    // BACKGROUND MODE
    // ENABLE CATEGORY ACCESS TO MAKE SURE MULTITASKING IS RUNING
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];

    
    // set timer
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scheduledTimerUpdateTime:) userInfo:nil repeats:YES];
}

- (id) initAudioPlayerWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *)songInfo{
    self = [super init];
    if (self) {
        [self preparePlayWithUrl:url andSongInfo:songInfo];
    }
    return self;
}

- (void)playingSliding:(UISlider *)sender
{
    
    if([self isPlaying])
    {
        CMTime duration = self.avPlayer.currentItem.asset.duration;
        float seconds = CMTimeGetSeconds(duration);
        
        CMTime newTime = CMTimeMakeWithSeconds(sender.value * seconds, self.avPlayer.currentTime.timescale);
        [self.avPlayer seekToTime:newTime];
    }
}

- (float) getSongCurrentDuration
{
    CMTime duration = self.avPlayer.currentItem.asset.duration;
    float seconds = CMTimeGetSeconds(duration);
    return seconds;
}

- (void)scheduledTimerUpdateTime:(NSTimer *)timer
{
    // chage button state
    [playPauseButton setImage:[UIImage imageNamed:([self isPlaying]) ? @"icon_pause_34x34.png" : @"icon_play_34x34.png"] forState:UIControlStateNormal];
    
    
    if([self.avPlayer rate] != 0)
    {
        // change sliding
        CMTime currentTime = self.avPlayer.currentItem.currentTime;
        float seconds2 = CMTimeGetSeconds(currentTime);
        float seconds = [self getSongCurrentDuration];
        progressDuration.value = seconds2 / seconds;
        
        //int playedSecond = (int)seconds2 % 60;
        //int playedMinuted = (int) seconds2 / 60;
        
        int remainSecond = (int)(seconds - seconds2) % 60;
        int remainMinuted = (int)(seconds - seconds2) / 60;
        
        // change sliding timing value
        //preSliding.text = [NSString stringWithFormat:@"%d:%02d", playedMinuted, playedSecond];
        labelSongTimer.text = [NSString stringWithFormat:@"%d:%02d", remainMinuted, remainSecond];
        
        
        NSArray *loadedTimeRanges = [[self.avPlayer currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        CMTime duration = self.avPlayer.currentItem.asset.duration;
        seconds = CMTimeGetSeconds(duration);
        progressDownload.progress = durationSeconds / seconds;
    }
}

- (void) preparePlayWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *) songInfo
{
    [self.audioPlayer stop];
    NSError *error;
    AVAudioPlayer *__audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [_audioPlayer prepareToPlay];
    
    self.audioPlayer = __audioPlayer;
    progressDuration.value = 0.0f;
    [self loadNowPlayingInfo:songInfo];
}

// NEW

- (void) preparePlayWithExternalStringUrl:(NSString *)urlString andSongInfo:(NSMutableDictionary *)_songInfo
{
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    [self setupAVPlayerForURL:url];
    
    // TEST DATA SONG INFO
    NSDictionary *_albumInfo = [self findCurrentSongInfo];
    
    NSMutableDictionary *albumInfo = [[NSMutableDictionary alloc] init];
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[_albumInfo objectForKey:@"image"]];
    
    [albumInfo setObject:[_albumInfo objectForKey:@"title"] forKey:MPMediaItemPropertyTitle];
    [albumInfo setObject:@"Đông Nhi" forKey:MPMediaItemPropertyArtist];
    [albumInfo setObject:[_albumInfo objectForKey:@"albumName"] forKey:MPMediaItemPropertyAlbumTitle];
    [albumInfo setObject:artWork forKey:MPMediaItemPropertyArtwork];
    [albumInfo setObject:[NSNumber numberWithFloat:[self getSongCurrentDuration]]  forKey:MPMediaItemPropertyPlaybackDuration];
    [albumInfo setObject:[NSNumber numberWithInt:1.0] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    self.songInfo = albumInfo;
    // END TEST DATA SONG INFO
    
    [self loadNowPlayingInfo:self.songInfo];
}

-(void) setupAVPlayerForURL: (NSURL*) url
{
    [playPauseButton setEnabled:NO];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVPlayerItem *anItem = [AVPlayerItem playerItemWithAsset:asset];
    
    [self.avPlayer pause];
    
    [self.avPlayer removeObserver:self forKeyPath:@"status"];
    [self.avPlayer removeObserver:self forKeyPath:@"currentItem.loadedTimeRanges"];

    self.avPlayer = nil;
    
    self.avPlayer = [AVPlayer playerWithPlayerItem:anItem];
    
    // add observer to check status of avplayer
    [self.avPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    
    // add observer to check play ended
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:anItem];
    
    [self.avPlayer addObserver:self
                    forKeyPath:@"currentItem.loadedTimeRanges"
                       options:NSKeyValueObservingOptionNew
                       context:kdcTimeRangesLoaded];
    
    
    
    // update playing bar
    NSDictionary *albumInfo = [self findCurrentSongInfo];
    
    // update
    albumArt.image = [albumInfo objectForKey:@"image"];
    labelSongTitle.text = [albumInfo objectForKey:@"title"];
    labelSongAlbumName.text = [albumInfo objectForKey:@"albumName"];
    
    progressDuration.value = 0.0f;
    progressDownload.progress = 0.0;
    
    [playPauseButton setEnabled:YES];
}


-(void)itemDidFinishPlaying:(NSNotification *) notification
{
    [playPauseButton setImage:[UIImage imageNamed:@"icon_play_34x34.png"] forState:UIControlStateNormal];
    progressDuration.value = 0.0f;
    
    CMTime newTime = CMTimeMakeWithSeconds(0.0, self.avPlayer.currentTime.timescale);
    [self.avPlayer seekToTime:newTime];
    [self.avPlayer pause];
    
    if(self.delegate != NULL)
    {
        if([self.delegate respondsToSelector:@selector(didPlayingFinish)])
        {
            [self.delegate didPlayingFinish];
        }
    }
    
    
    // if finish play current song => change to play next song
    [self nextSong];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.avPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.avPlayer.status == AVPlayerStatusFailed) {
            //NSLog(@"AVPlayer Failed");
        } else if (self.avPlayer.status == AVPlayerStatusReadyToPlay) {
            //NSLog(@"AVPlayer Ready to Play");
        } else if (self.avPlayer.status == AVPlayerItemStatusUnknown) {
            //NSLog(@"AVPlayer Unknown");
        } else if (self.avPlayer.status == AVPlayerActionAtItemEndPause){
            
        }
    }
    
    // check rate loaded then calculation time loaded duration
    if (kdcTimeRangesLoaded == context) {
        NSArray *loadedTimeRanges = [[self.avPlayer currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        CMTime duration = self.avPlayer.currentItem.asset.duration;
        float seconds = CMTimeGetSeconds(duration);
        progressDownload.progress = durationSeconds / seconds;
    }
}

// END NEW

- (IBAction) nextSongAction:(UIButton *)sender{
    [self nextSong];
}

- (IBAction) prevSongAction:(UIButton *)sender{
    [self prevSong];
}

- (IBAction) togglePlayAndPause:(id)sender{
    [self togglePlayPause];
}

- (void) loadNowPlayingInfo:(NSMutableDictionary *)songInfo
{
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
}


- (void)viewDidAppear:(BOOL)animated
{
    //Once the view has loaded then we can register to begin recieving controls and we can become the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //End recieving events
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)playAudio
{
    //Play the audio and set the button to represent the audio is playing
    if(self.audioPlayer){
        [self.audioPlayer play];
    }
    else if(self.avPlayer){
        [self.avPlayer play];
    }

    [playPauseButton setImage:[UIImage imageNamed:@"icon_pause_34x34"] forState:UIControlStateNormal];
}

- (void)pauseAudio
{
    //Pause the audio and set the button to represent the audio is paused
    if(self.audioPlayer){
        [self.audioPlayer pause];
    }
    else if(self.avPlayer){
        [self.avPlayer pause];
    }
    
    [playPauseButton setImage:[UIImage imageNamed:@"icon_play_34x34"] forState:UIControlStateNormal];
}


- (void)togglePlayPause {
    //Toggle if the music is playing or paused
    if (!self.audioPlayer.playing && [self.avPlayer rate] == 0.0) {
        [self playAudio];
        
    } else if (self.audioPlayer.playing || [self.avPlayer rate] != 0.0) {
        [self pauseAudio];
    }
}

// check state of playing
// be sure 2 case for avaudioplayer (play local) and avplayer (player via external)
// avaudio player using default method, avplayer use rate to check (NOT SURE) currently is RIGHT
- (BOOL) isPlaying{
    if (self.audioPlayer.playing || [self.avPlayer rate] != 0.0) {
        return YES;
    }
    return NO;
}
//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    return YES;
}

// Recieve event from remote control from out of apps (ACTION CONTROL CENTER)

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [self playAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self pauseAudio];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }else if(event.subtype == UIEventSubtypeRemoteControlNextTrack){
            [self nextSong];
        }else if(event.subtype == UIEventSubtypeRemoteControlPreviousTrack){
            [self prevSong];
        }
    }
}


- (void) hide
{
    // neu nhu ma dang hide roi thi thoi
    if(self.isHide)
        return;
    
    self.isHide = YES;
    
    // tinh toan lai frame
    int tempX = self.view.frame.origin.x;
    int tempY = self.view.frame.origin.y + playingMusicViewHeight + 10;
    int tempW = self.view.frame.size.width;
    int tempH = self.view.frame.size.height;
    
    self.view.frame = CGRectMake(tempX, tempY, tempW, tempH);
}
- (void) hideAnimatedWithDuration:(float)duration delay:(float)delay
{
    [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{[self hide];}
                              completion:nil];
}

- (void) show
{
    // neu nhu ma dang show roi thi thoi
    if(!self.isHide)
        return;
    
    self.isHide = NO;
    
    // tinh toan lai frame
    int tempX = self.view.frame.origin.x;
    int tempY = self.view.frame.origin.y - playingMusicViewHeight - 10;
    int tempW = self.view.frame.size.width;
    int tempH = self.view.frame.size.height;
    
    self.view.frame = CGRectMake(tempX, tempY, tempW, tempH);
}
- (void) showAnimatedWithDuration:(float)duration delay:(float)delay
{
    [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{[self show];}
                              completion:nil];
}

- (void) toggleShowHide
{
    // neu nhu dang hide thi show, ma dang show thi hide
    if(self.isHide)[self show];
    else [self hide];
}
- (void) toggleShowHideWithDuration:(float)duration delay:(float)delay
{
    [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{[self toggleShowHide];}
                              completion:nil];
}

- (NSInteger) findSongIndexFromSongId:(NSMutableArray *)data withId:(int) songId
{
    NSInteger index = 0;
    for(NSDictionary *songItem in data)
    {
        if([[songItem objectForKey:@"id"] integerValue] == songId)
            return index;
        
        index++;
    }
    
    return -1;
}
- (NSString *) findSongUrlExternalFromSongId:(NSMutableArray *)data withId:(int) songId
{
    for(NSDictionary *songItem in data){
        if([[songItem objectForKey:@"id"] integerValue] == songId){
            return [[songItem objectForKey:@"file"] objectForKey:@"source"];
        }
    }
    return @"";
}
- (NSString *) findNextSongUrlExternalFromSongId:(NSMutableArray *)data withId:(int) songId
{
    BOOL findToCurrent = NO;
    for(NSDictionary *songItem in data){
        if([[songItem objectForKey:@"id"] integerValue] == songId){
            findToCurrent = YES;
            continue;
        }
        if(findToCurrent){
            self.currentSongId = (int)[[songItem objectForKey:@"id"] integerValue];
            return [[songItem objectForKey:@"file"] objectForKey:@"source"];
        }
    }
    return @"";
}

- (NSString *) findPrevSongUrlExternalFromSongId:(NSMutableArray *)data withId:(int) songId{
    for(int i = 0; i< [data count]; i++){
        if(i > 0){
            if([[data[i] objectForKey:@"id"] integerValue]  == songId){
                self.currentSongId = (int)[[data[i-1] objectForKey:@"id"] integerValue];
                return [[data[i-1] objectForKey:@"file"] objectForKey:@"source"];
                break;
            }
        }
    }
    return @"";
}
- (NSDictionary *) findCurrentSongInfo
{
    for(NSDictionary *songItem in self.listSongs){
        if([[songItem objectForKey:@"id"] integerValue] == self.currentSongId){
            NSString *currentSongTitle = [songItem objectForKey:@"title"];
            NSDictionary *currentSongInfo = @{@"title": currentSongTitle, @"image" : self.currentAlbumImage, @"albumName": self.currentAlbumTitle};
            return currentSongInfo;
        }
    }
    return [NSDictionary new];
}

- (void) nextSong
{
    NSString *nextSongUrl = [sharePlaying findNextSongUrlExternalFromSongId:self.listSongs withId:self.currentSongId];
    
    
    
    if(![nextSongUrl isEqualToString:@""])
        [self prepareInBackgroundToPlayNewSongWithExternalStringUrl:[ManageSize addHTTP:nextSongUrl]];
}

- (void) prevSong
{
    NSString *prevSongUrl = [sharePlaying findPrevSongUrlExternalFromSongId:self.listSongs withId:self.currentSongId];
    if(![prevSongUrl isEqualToString:@""])
        [self prepareInBackgroundToPlayNewSongWithExternalStringUrl:[ManageSize addHTTP:prevSongUrl]];
}


-(void)prepareInBackgroundToPlayNewSongWithExternalStringUrl:(NSString *)stringUrl
{
    // UPDATE THONG TIN
    // update playing bar
    NSDictionary *albumInfo = [self findCurrentSongInfo];
    
    // update
    albumArt.image = [albumInfo objectForKey:@"image"];
    labelSongTitle.text = [albumInfo objectForKey:@"title"];
    labelSongAlbumName.text = [albumInfo objectForKey:@"albumName"];
    
    progressDuration.value = 0.0f;
    progressDownload.progress = 0.0;
    
    
    // BAY GIO MOI PREPARING
    
    preparingExternalStringUrl = stringUrl;
    
    //NSLog(@"[MUSIC] prepare song: %@ ...", preparingExternalStringUrl);
    
    // bay gio la se chuan bi play, nen se goi callback
    if(self.delegate != NULL)
    {
        if([self.delegate respondsToSelector:@selector(willStartPlayNewSong)])
        {
            [self.delegate willStartPlayNewSong];
        }
    }
    
    // run in background
    [self performSelectorInBackground:@selector(bgthreadPrepareToPlayNewSong) withObject:nil];
}

-(void)bgthreadPrepareToPlayNewSong
{
    [sharePlaying preparePlayWithExternalStringUrl:preparingExternalStringUrl andSongInfo:nil];
    [sharePlaying playAudio];
    
    // quay lai main thread de goi call back
    [self performSelectorOnMainThread:@selector(mainthreadDonePrepareToPlayNewSong) withObject:nil waitUntilDone:NO];
}
-(void)mainthreadDonePrepareToPlayNewSong
{
    //NSLog(@"[MUSIC] prepare song: %@ done!", preparingExternalStringUrl);
    
    preparingExternalStringUrl = nil;
}


@end
