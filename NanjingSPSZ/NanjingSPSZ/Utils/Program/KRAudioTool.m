//
//  KRAudioTool.m
//  ZHSH-V1.0
//
//  Created by nansen on 16/4/29.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import "KRAudioTool.h"

@implementation KRAudioTool

/**
 *  存放所有的音频ID
 *  字典: filename作为key, soundID作为value
 */
static NSMutableDictionary *_soundIDDict;

/**
 *  存放所有的音乐播放器
 *  字典: filename作为key, audioPlayer作为value
 */
static NSMutableDictionary *_audioPlayerDict;

/**
 *  初始化
 */
+ (void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
    _audioPlayerDict = [NSMutableDictionary dictionary];
    
    // 设置音频会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];

    [session setActive:YES error:nil];
}

/**
 *  播放音效
 *
 *  @param filename 音效文件名
 */
+ (void)playSound:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    if (!soundID) { // 创建
        // 加载音效文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) return;
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        // 放入字典
        _soundIDDict[filename] = @(soundID);
    }
    
    // 2.播放
    AudioServicesPlaySystemSound(soundID);
}



/**
 *  播放音效
 */
+ (void)playSound
{
    [self playSound:@"message.wav"];
}

/**
 *  震动
 */
+ (void)playShake
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/**
 *  播放音效和震动
 */
+ (void)playSoundAndShake
{
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[@"message.wav"] unsignedIntValue];
    if (!soundID) { // 创建
        // 加载音效文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"message.wav" withExtension:nil];
        
        if (!url) return;
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        // 放入字典
        _soundIDDict[@"message.wav"] = @(soundID);
    }
    
    AudioServicesPlayAlertSound(soundID);
}

+ (void)playSoundLoop:(NSString *)fileName
{
    if (!fileName) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[fileName] unsignedIntValue];
    if (!soundID) { // 创建
        // 加载音效文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        if (!url) return;
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        // 放入字典
        _soundIDDict[fileName] = @(soundID);
    }
    
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundLoopCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID);
}

/**
 *  播放完成回调函数
 */
void soundLoopCompleteCallback(SystemSoundID soundID, void * clientData){
    AudioServicesPlaySystemSound(soundID);
}

+ (void)closeSoundLoop:(NSString *)fileName
{
    if (!fileName) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[fileName] unsignedIntValue];
    
    AudioServicesDisposeSystemSoundID(soundID);
    AudioServicesRemoveSystemSoundCompletion(soundID);
    
}



+ (void)playSoundAndShakeLoop:(NSString *)fileName
{
    if (!fileName) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[fileName] unsignedIntValue];
    if (!soundID) { // 创建
        // 加载音效文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        if (!url) return;
        
        // 创建音效ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        // 放入字典
        _soundIDDict[fileName] = @(soundID);
    }
    
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundAndShakeLoopCompleteCallback, NULL);
    AudioServicesPlayAlertSound(soundID);
}

void soundAndShakeLoopCompleteCallback(SystemSoundID soundID, void * clientData){
    AudioServicesPlayAlertSound(soundID);
}

+ (void)closeSoundAndShakeLoop:(NSString *)fileName
{
    if (!fileName) return;
    
    // 1.从字典中取出soundID
    SystemSoundID soundID = [_soundIDDict[fileName] unsignedIntValue];
    
    AudioServicesDisposeSystemSoundID(soundID);
    AudioServicesRemoveSystemSoundCompletion(soundID);
    
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}




+ (void)playShakeLoop
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setActive:YES error:nil];
    
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, shakeLoopCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/**
 *  播放完成回调函数
 */
void shakeLoopCompleteCallback(SystemSoundID soundID, void * clientData){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AudioServicesPlaySystemSound(soundID);  //震动
    });
}

+ (void)closeShakeLoop
{
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
}


/**
 *  销毁音效
 *
 *  @param filename 音效文件名
 */
+ (void)disposeSound:(NSString *)filename
{
    if (!filename) return;
    
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    if (soundID) {
        // 销毁音效ID
        AudioServicesDisposeSystemSoundID(soundID);
        
        // 从字典中移除
        [_soundIDDict removeObjectForKey:filename];
    }
}

/**
 *  播放音乐
 *
 *  @param filename 音乐文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename
{
    if (!filename) return nil;
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if (!audioPlayer) { // 创建
        // 加载音乐文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) return nil;
        
        // 创建audioPlayer
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 缓冲
        [audioPlayer prepareToPlay];
        
        // 放入字典
        _audioPlayerDict[filename] = audioPlayer;
    }
    
    // 2.播放
    if (!audioPlayer.isPlaying) {
        
        [audioPlayer play];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(audioPlayer.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        });
    }
    
    return audioPlayer;
}


/**
 *  重复播放音乐
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename withCounts:(long)counts;
{
    if (!filename) return nil;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setActive:YES error:nil];
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if (!audioPlayer) { // 创建
        // 加载音乐文件
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        
        if (!url) return nil;
        
        // 创建audioPlayer
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 缓冲
        [audioPlayer prepareToPlay];
        
        // 放入字典
        _audioPlayerDict[filename] = audioPlayer;
    }
    
    // 2.播放
    if (!audioPlayer.isPlaying) {
        [audioPlayer play];
        [audioPlayer setNumberOfLoops:counts];
    }
    
    return audioPlayer;
}

/**
 *  暂停音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)pauseMusic:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    // 2.暂停
    if (audioPlayer.isPlaying) {
        [audioPlayer pause];
    }
}

/**
 *  停止音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)stopMusic:(NSString *)filename
{
    if (!filename) return;
    
    // 1.从字典中取出audioPlayer
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    
    // 2.暂停
    if (audioPlayer.isPlaying) {
        [audioPlayer stop];
        
        // 直接销毁
        [_audioPlayerDict removeObjectForKey:filename];
    }
}

/**
 *  返回当前正在播放的音乐播放器
 */
+ (AVAudioPlayer *)currentPlayingAudioPlayer
{
    for (NSString *filename in _audioPlayerDict) {
        AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
        
        if (audioPlayer.isPlaying) {
            return audioPlayer;
        }
    }
    
    return nil;
}


@end
