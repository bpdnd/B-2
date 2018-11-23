//
//  LemonBubbleView.h
//  LemonKit
//
//  Created by 1em0nsOft on 16/8/30.
//  Copyright © 2016年 1em0nsOft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LemonBubbleInfo.h"

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 14:08:50
 *
 *  @brief LK提示系列 - LK泡泡控件
 */
@interface LemonBubbleView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL *isShowing;// 是否正在显示中
@property (nonatomic, strong) NSMutableDictionary<NSString*, LemonBubbleInfo*> *infoDic;
/// @brief 当前正在显示的泡泡信息对象
@property (nonatomic, strong) LemonBubbleInfo *currentInfo;
/// @brief 当前自定义动画绘图的图层
@property (nonatomic, strong) CAShapeLayer *currentDrawLayer;
/// @brief 当前使用的图片帧动画计时器
@property (nonatomic, strong) NSTimer *currentTimer;
/// @brief 蒙版view
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, assign) CGFloat closeKey;// 关闭验证key，用来做关闭时候的延迟验证，当设置自动关闭之后，若在关闭之前出发了显示其他info的bubble，通过修改这个值保证不关闭其他样式的infoBubble
@property (nonatomic, assign) NSInteger frameAnimationPlayIndex;// 帧动画播放的下标索引





/// @brief 进度属性
@property (nonatomic) CGFloat progress;

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:41
 *
 *  @brief 默认的LK泡泡控件 - 单例方法
 *
 *  @return 默认的LK泡泡控件对象
 */
+ (LemonBubbleView *)defaultBubbleView;


/**
 注册泡泡信息对象

 @param info 泡泡信息对象
 @param key  泡泡信息对象对应的键
 */
- (void)registerInfo: (LemonBubbleInfo *)info forKey: (NSString *)key;

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 显示指定的信息模型对应的泡泡控件
 */
- (void)showWithInfo: (LemonBubbleInfo *)info;

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 通过传入键来显示已经注册的指定样式泡泡控件
 */
- (void)showWithInfoKey: (NSString *)infoKey;

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 显示指定的信息模型对应的泡泡控件，并指定的时间后隐藏
 *
 *  @param info          样式信息模型
 *  @param time 指定时间后隐藏泡泡控件的秒数
 */
- (void)showWithInfo: (LemonBubbleInfo *)info autoCloseTime: (CGFloat)time;

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:53
 *
 *  @brief 显示指定的信息模型对应的泡泡控件，并指定的时间后隐藏
 *
 *  @param infoKey          已注册的样式信息模型的键
 *  @param time 指定时间后隐藏泡泡控件的秒数
 */
- (void)showWithInfoKey: (NSString *)infoKey autoCloseTime: (CGFloat)time;

/**
 *  @author 1em0nsOft LiuRi
 *  @date 2016-08-30 16:08:40
 *
 *  @brief 隐藏当前泡泡控件
 */
- (void)hide;

/**
 *  @author chenjunsheng
 *  @date 2016-12-18 16:08:40
 *
 *  @brief 定时隐藏当前泡泡控件
 */
- (void)hideWithCloseTime: (CGFloat)time;

@end
