//
//  PlayingMusicView.h
//  DongNhi
//
//  Created by Vu Duy Khanh on 4/23/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>


#define playingMusicViewHeight 60


@class PlayingMusicView;

@protocol PlayingMusicViewDelegate;

@interface PlayingMusicView : UIViewController
{
    NSString *preparingExternalStringUrl;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) AVPlayer *avPlayer;

@property (nonatomic, strong) NSMutableArray *listSongs;

@property int currentSongId;
@property (nonatomic, strong) UIImage *currentAlbumImage;
@property (nonatomic, strong) NSString *currentAlbumTitle;
@property int nextOrPrevSongId;

@property (nonatomic, strong) NSMutableDictionary *songInfo;

@property BOOL isHide;

- (id) initAudioPlayerWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *)songInfo;
- (void) preparePlayWithUrl:(NSURL *)url andSongInfo:(NSMutableDictionary *) songInfo;
- (IBAction) togglePlayAndPause:(id)sender;
- (IBAction) nextSongAction:(id)sender;
- (IBAction) prevSongAction:(id)sender;
- (void) loadNowPlayingInfo:(NSMutableDictionary *) songInfo;
+ (id)sharePlaying;
- (void) playAudio;
- (void) pauseAudio;
- (BOOL) isPlaying;
- (float) getSongCurrentDuration;
- (void) hide;
- (void) hideAnimatedWithDuration:(float)duration delay:(float)delay;
- (void) show;
- (void) showAnimatedWithDuration:(float)duration delay:(float)delay;
- (void) toggleShowHide;
- (void) toggleShowHideWithDuration:(float)duration delay:(float)delay;
- (void) preparePlayWithExternalStringUrl:(NSString *)url andSongInfo:(NSMutableDictionary *)songInfo;
- (NSInteger) findSongIndexFromSongId:(NSMutableArray *)data withId:(int) songId;
- (NSString *) findSongUrlExternalFromSongId:(NSMutableArray *)data withId:(int) songId;
- (NSString *) findNextSongUrlExternalFromSongId:(NSMutableArray *)data withId:(int) songId;
- (NSString *) findPrevSongUrlExternalFromSongId:(NSMutableArray *)data withId:(int) songId;
- (NSDictionary *) findCurrentSongInfo;
- (void) nextSong;
- (void) prevSong;

-(void)prepareInBackgroundToPlayNewSongWithExternalStringUrl:(NSString *)stringUrl;

@property (strong, nonatomic) id <PlayingMusicViewDelegate> delegate;
@end

@protocol PlayingMusicViewDelegate <NSObject>

@optional
- (void) didChangeSongInfoWithAction:(NSString *) action;
- (void) didPlayingFinish;
- (void) willStartPlayNewSong;
@end