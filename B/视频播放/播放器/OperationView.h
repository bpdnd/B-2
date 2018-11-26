//
//  OperationView.h
//  B
//
//  Created by Admin on 2018/11/25.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface OperationView : UIView
@property(nonatomic,strong) UIButton *stopButton;
@property(nonatomic,strong) UIButton *changButton; //宽屏

@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UISlider *slider;
/**
 修改播放按钮图片

 @param isPlay yes:icon_playPause no：icon_playPlay
 */
-(void)changeStopImageWithBOOL:(BOOL) isPlay;

/**
 修改slider

 @param currentTime 当前时间
 @param duration 总时长
 */
-(void)changeSlider:(float)currentTime withDurationTime:(float)duration;

@end
