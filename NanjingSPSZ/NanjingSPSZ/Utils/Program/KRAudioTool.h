//
//  KRAudioTool.h
//  ZHSH-V1.0
//
//  Created by nansen on 16/4/29.
//  Copyright © 2016年 NansenLu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface KRAudioTool : NSObject
/**
 *  播放音效
 *
 *  @param filename 音效文件名
 */
+ (void)playSound:(NSString *)filename;

/**
 *  播放音效
 */
+ (void)playSound;
/**
 *  震动
 */
+ (void)playShake;
/**
 *  播放音效和震动
 */
+ (void)playSoundAndShake;


+ (void)playSoundLoop:(NSString *)fileName;
+ (void)closeSoundLoop:(NSString *)fileName;

+ (void)playSoundAndShakeLoop:(NSString *)fileName;
+ (void)closeSoundAndShakeLoop:(NSString *)fileName;

+ (void)playShakeLoop;
+ (void)closeShakeLoop;

/**
 *  销毁音效
 *
 *  @param filename 音效文件名
 */
+ (void)disposeSound:(NSString *)filename;

/**
 *  播放音乐
 *
 *  @param filename 音乐文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename;

/**
 *  重复播放音乐
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename withCounts:(long)counts;

/**
 *  暂停音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)pauseMusic:(NSString *)filename;

/**
 *  停止音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)stopMusic:(NSString *)filename;

/**
 *  返回当前正在播放的音乐播放器
 */
+ (AVAudioPlayer *)currentPlayingAudioPlayer;


@end
