//
//  PlayListModel.h
//  B
//
//  Created by Admin on 2018/11/24.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayListModel : NSObject

/**
 是否是轮播图
 */
@property(nonatomic,assign) BOOL isScroll;
/**
 播放次数
 */
@property(nonatomic,copy) NSString *playCount;
/**
 评论次数
 */
@property(nonatomic,copy) NSString *commentCount;
/**
 视频url
 */
@property(nonatomic,copy) NSString *videoUrl;
/**
 本地视频 网络视频  yes 本地
 */
@property(nonatomic,assign) BOOL isLocal;
/**
 封面图片url
 */
@property(nonatomic,copy) NSString *imageUrl;
/**
 当封面图片url不存在时，取视频的  秒作为封面图，默认为1
 */
@property(nonatomic,copy) NSString *videoSecondForImage;
/**
 视频 总时长 单位：秒
 */
@property(nonatomic,assign) float duration;

@end
