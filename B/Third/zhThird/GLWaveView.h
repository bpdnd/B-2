//
//  GLWaveView.h
//  GLWaveView
//
//  Created by GrayLand on 17/3/7.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "GLWave.h"
@protocol GLWaveViewDelegate <NSObject>
-(void)GLWaveViewDidSelect;
@end


@class GLWaveView;
typedef void(^GLWaveViewWillUpdateBlock)(GLWaveView *view);

@interface GLWaveView : UIView

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,weak) id<GLWaveViewDelegate> delegate;

@property (nonatomic, strong, readonly) NSMutableArray <CAShapeLayer *> *waves;///<波形

@property (nonatomic, copy) GLWaveViewWillUpdateBlock willUpdateBlock;///<每帧刷新前调用, 用于自定义额外的波浪动画

/**
 *  添加波形
 *
 */
- (void)addWave:(GLWave *)wave;

/**
 *  移除所有波形
 */
- (void)removeAllWaves;

/**
 *  开始动画
 */
- (void)startWaveAnimate;

/**
 *  停止动画
 */
- (void)stopWaveAnimate;

@end
