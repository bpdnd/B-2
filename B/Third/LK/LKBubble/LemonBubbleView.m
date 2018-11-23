//
//  LemonBubbleView.m
//  LemonKit
//
//  Created by 1em0nsOft on 16/8/30.
//  Copyright © 2016年 1em0nsOft. All rights reserved.
//

#import "LemonBubbleView.h"

#define bubble_width 180 // 泡泡控件的宽度
#define bubble_height 120// 泡泡控件的高度
#define bubble_icon_width 60 // 泡泡控件中的图标边长
#define bubble_padding 17 // 泡泡控件的顶部内边距，即图标距离顶部的长度
#define bubble_icon_title_space 0 // 泡泡控件中图标和标题的空隙

@interface LemonBubbleView()



@end

@implementation LemonBubbleView
	
+ (LemonBubbleView *)defaultBubbleView {
	static LemonBubbleView *defaultBubbleView = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		if (defaultBubbleView == nil) {
			defaultBubbleView = [[LemonBubbleView alloc] init];
		}
	});
	return defaultBubbleView;
}

- (instancetype)init{
    if (self = [super init]) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        self.frame = CGRectMake(keyWindow.center.x, keyWindow.center.y, 0, 0);
        self.infoDic = [[NSMutableDictionary alloc] init];
        
        self.clipsToBounds = YES;
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.clipsToBounds = YES;
        self.titleLabel = [[UILabel alloc] init];
		self.titleLabel.adjustsFontSizeToFitWidth = YES;
		self.titleLabel.minimumScaleFactor = 0.5;
		self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setNumberOfLines: 0];
        // 初始化蒙版控件
        self.maskView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        self.maskView.hidden = YES;
        
        [self addSubview: self.iconImageView];
        [self addSubview: self.titleLabel];
    }
    return self;
}

- (void)registerInfo: (LemonBubbleInfo *)info forKey: (NSString *)key{
    self.infoDic[key] = info;
}

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 显示指定的信息模型对应的泡泡控件
 */
- (void)showWithInfo: (LemonBubbleInfo *)info{
    __weak typeof(self) weakSelf = self;
    self.currentInfo = info;
    self.closeKey = self.currentInfo.key;// 保存当前要关闭的key，防止关闭不需要关闭的bubble
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];// 防止使用Storyboard的时候keywindow为nil
    if (info.isShowMaskView)
        [mWindow addSubview: self.maskView];
    [mWindow addSubview: self];
    
    // 弹簧动画改变外观
    [UIView animateWithDuration: 0.45
                          delay:0
         usingSpringWithDamping: 0.8
          initialSpringVelocity:0.9
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(1, 1);
        if (weakSelf.currentDrawLayer) {
            [weakSelf.currentDrawLayer removeFromSuperlayer];
        }
        weakSelf.frame = [info calBubbleViewFrame];
        weakSelf.titleLabel.text = info.title;
        weakSelf.titleLabel.font = [UIFont systemFontOfSize: info.titleFontSize];
		[info calIconView: weakSelf.iconImageView andTitleView: weakSelf.titleLabel];
        weakSelf.layer.cornerRadius = info.cornerRadius;
        
        if (info.iconArray == nil || info.iconArray.count == 0) {
            // 显示自定义动画
			if (info.iconAnimation) {
			    weakSelf.iconImageView.image = [[UIImage alloc] init];
				weakSelf.currentDrawLayer = [CAShapeLayer layer];
				weakSelf.currentDrawLayer.fillColor = [UIColor clearColor].CGColor;
				weakSelf.currentDrawLayer.frame = weakSelf.iconImageView.bounds;
				[weakSelf.iconImageView.layer addSublayer: weakSelf.currentDrawLayer];
				[weakSelf.currentTimer invalidate];
				dispatch_async(dispatch_get_main_queue(), ^{
					info.iconAnimation(weakSelf.currentDrawLayer);
				});
			}
        }
        else if (info.iconArray.count == 1){// 显示单张图片
            [weakSelf.currentTimer invalidate];
            weakSelf.iconImageView.image = info.iconArray[0];
        }
        else{// 逐帧连环动画
            weakSelf.frameAnimationPlayIndex = 0;// 帧动画播放索引归零
            weakSelf.iconImageView.image = weakSelf.currentInfo.iconArray[0];
            weakSelf.currentTimer =
            [NSTimer scheduledTimerWithTimeInterval: info.frameAnimationTime
                                             target: weakSelf
                                           selector: @selector(frameAnimationPlayer)
                                           userInfo: nil
                                            repeats: YES];
        }
        // maskView
        if (weakSelf.currentInfo.isShowMaskView && weakSelf.maskView.hidden) {
            // 本次需要显示，但是之前已经隐藏
            weakSelf.maskView.alpha = 0;
            weakSelf.maskView.hidden = NO;
        }
        weakSelf.maskView.alpha = weakSelf.currentInfo.isShowMaskView ? 1 : 0;
    } completion:^(BOOL finished) {
        if(!weakSelf.currentInfo.isShowMaskView){
            weakSelf.maskView.hidden = YES;
            [weakSelf.maskView removeFromSuperview];
        }
    }];
    
    [UIView animateWithDuration: 0.45
                          delay:0
                        options:UIViewAnimationOptionTransitionCurlUp
                     animations:^{
        weakSelf.titleLabel.textColor = info.titleColor;
        [weakSelf setBackgroundColor: info.backgroundColor];
        weakSelf.currentDrawLayer.strokeColor = info.iconColor.CGColor;
        weakSelf.maskView.backgroundColor = weakSelf.currentInfo.maskColor;
        weakSelf.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


/**
 帧动画播放器 - NSTimer调用
 */
- (void)frameAnimationPlayer{
    self.iconImageView.image = self.currentInfo.iconArray[self.frameAnimationPlayIndex];
    self.frameAnimationPlayIndex = (self.frameAnimationPlayIndex + 1) % self.currentInfo.iconArray.count;
}

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 通过传入键来显示已经注册的指定样式泡泡控件
 */
- (void)showWithInfoKey: (NSString *)infoKey{
    if ([self.infoDic.allKeys containsObject: infoKey]){
        [self showWithInfo: self.infoDic[infoKey]];
    }
}

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 显示指定的信息模型对应的泡泡控件，并指定的时间后隐藏
 *
 *  @param info          样式信息模型
 *  @param time 指定时间后隐藏泡泡控件的秒数
 */
- (void)showWithInfo: (LemonBubbleInfo *)info autoCloseTime: (CGFloat)time{
    [self showWithInfo: info];
    [self performSelector: @selector(hide)
               withObject: self
               afterDelay: time + 0.2];
}

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 显示指定的信息模型对应的泡泡控件，并指定的时间后隐藏
 *
 *  @param infoKey          已注册的样式信息模型的键
 *  @param time 指定时间后隐藏泡泡控件的秒数
 */
- (void)showWithInfoKey: (NSString *)infoKey autoCloseTime: (CGFloat)time{
    if ([self.infoDic.allKeys containsObject: infoKey]){
        [self showWithInfo: self.infoDic[infoKey]
             autoCloseTime: time];
    }
}

/**
 *  @author chenjunsheng
 *  @date 2016-12-18 16:08:40
 *
 *  @brief 隐藏当前泡泡控件
 */
- (void)hideWithCloseTime: (CGFloat)time {
	[self performSelector: @selector(hide)
               withObject: self
               afterDelay: time];
}

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:40
 *
 *  @brief 隐藏当前泡泡控件
 */
- (void)hide{
    __weak typeof(self) weakSelf = self;
    if (self.closeKey == self.currentInfo.key){// 要关闭的key没有变化，可以关闭
        // 动画缩放，更改透明度使其动画隐藏
        [UIView animateWithDuration: 0.2
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
            weakSelf.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
                             weakSelf.maskView.alpha = 0;
            weakSelf.alpha = 0;
			// 记得把定时器停了
			[weakSelf.currentTimer invalidate];
        } completion:^(BOOL finished) {
            // 从父层控件中移除
            [weakSelf removeFromSuperview];
            [weakSelf.maskView removeFromSuperview];
        }];
    }
}

- (void)setProgress:(CGFloat)progress{
    self.progress = progress;
    __weak typeof(self) weakSelf = self;
    if (self.currentInfo.onProgressChanged != nil){
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.currentInfo.onProgressChanged(weakSelf.currentDrawLayer, progress);
        });
    }
}

@end
