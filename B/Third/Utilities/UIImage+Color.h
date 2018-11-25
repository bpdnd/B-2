//
//  UIImage+Color.h
//  categoryKitDemo
//
//  Created by zhanghao on 2016/7/23.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage*)imageCompressWithSimple:(UIImage*)image;
/**
 获取视频 秒 图片
 
 @param videoUrl 视频地址
 @param second 秒
 @return 图片
 */
+ (UIImage *)getVideoPreViewImage:(NSString *)videoUrl withSecond:(NSString *)second withisLocal:(BOOL) isLocal;

@end
