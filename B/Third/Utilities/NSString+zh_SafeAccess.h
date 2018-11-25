//
//  NSString+zh_SafeAccess.h
//  zhPopupController
//
//  Created by zhanghao on 2017/9/15.
//  Copyright © 2017年 snail-z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface NSString (zh_SafeAccess)

/// 从字符串的起始处提取到某个位置结束
- (NSString *)substringToIndexSafe:(NSUInteger)to;

/// 从字符串的某个位置开始提取直到字符串的末尾
- (NSString *)substringFromIndexSafe:(NSInteger)from;

/// 删除字符串中的首字符
- (NSString *)deleteFirstCharacter;

/// 删除字符串中的末尾字符
- (NSString *)deleteLastCharacter;
/**
 视频时长
 */
+(NSString *)getVideoTime:(NSString *)videoUrl withisLocal:(BOOL) isLocal;

@end
