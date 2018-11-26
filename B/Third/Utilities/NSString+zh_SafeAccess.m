//
//  NSString+zh_SafeAccess.m
//  zhPopupController
//
//  Created by zhanghao on 2017/9/15.
//  Copyright © 2017年 snail-z. All rights reserved.
//

#import "NSString+zh_SafeAccess.h"

@implementation NSString (zh_SafeAccess)

- (NSString *)substringToIndexSafe:(NSUInteger)to {
    if (self == nil || [self isEqualToString:@""]) {
        return @"";
    }
    if (to > self.length - 1) {
        return @"";
    }
    return  [self substringToIndex:to];
}

- (NSString *)substringFromIndexSafe:(NSInteger)from {
    if (self == nil || [self isEqualToString:@""]) {
        return @"";
    }
    if (from > self.length - 1) {
        return @"";
    }
    return  [self substringFromIndex:from];
}

- (NSString *)deleteFirstCharacter {
    return [self substringFromIndexSafe:1];
}

- (NSString *)deleteLastCharacter {
    return [self substringToIndexSafe:self.length - 1];
}

/**
 视频时长

 @param videoUrl 视频url
 @param isLocal 是不是本地视频 yes 是
 @return 时长字符串
 */
+(NSString *)getVideoTime:(NSString *)videoUrl withisLocal:(BOOL) isLocal{
    //时长
    AVURLAsset * audioAsset;
    if (isLocal) {
        audioAsset=[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoUrl] options:nil];
    }else{
       audioAsset=[AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoUrl] options:nil];
    }
    CMTime audioDuration= audioAsset.duration;
    int audioDurationSeconds = (int)CMTimeGetSeconds(audioDuration);
    //时
    int hour   = (audioDurationSeconds - audioDurationSeconds%3600)/3600;
    //分
    int min =  (audioDurationSeconds- hour*3600 - (audioDurationSeconds - hour *3600)%60)/60;
    //秒
    int sed = audioDurationSeconds-hour*3600-min*60;
    if (hour == 0) {
        if (min == 0) {
            return [NSString stringWithFormat:@"00:%@",sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }else{
            return [NSString stringWithFormat:@"%@:%@",min<=9 ? [NSString stringWithFormat:@"0%d",min]:[NSString stringWithFormat:@"%d",min],sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }
    }else{
        if (min == 0) {
            return [NSString stringWithFormat:@"%d:00:%@",hour,sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }else{
            return [NSString stringWithFormat:@"%d:%@:%@",hour,min<=9 ? [NSString stringWithFormat:@"0%d",min]:[NSString stringWithFormat:@"%d",min],sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }
    }
    
}


/**
 <#Description#>

 @param audioDurationSeconds <#audioDurationSeconds description#>
 @return <#return value description#>
 */
+(NSString *)changeTimeInt:(int)audioDurationSeconds{
    //时
    int hour   = (audioDurationSeconds - audioDurationSeconds%3600)/3600;
    //分
    int min =  (audioDurationSeconds- hour*3600 - (audioDurationSeconds - hour *3600)%60)/60;
    //秒
    int sed = audioDurationSeconds-hour*3600-min*60;
    if (hour == 0) {
        if (min == 0) {
            return [NSString stringWithFormat:@"00:%@",sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }else{
            return [NSString stringWithFormat:@"%@:%@",min<=9 ? [NSString stringWithFormat:@"0%d",min]:[NSString stringWithFormat:@"%d",min],sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }
    }else{
        if (min == 0) {
            return [NSString stringWithFormat:@"%d:00:%@",hour,sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }else{
            return [NSString stringWithFormat:@"%d:%@:%@",hour,min<=9 ? [NSString stringWithFormat:@"0%d",min]:[NSString stringWithFormat:@"%d",min],sed<=9 ? [NSString stringWithFormat:@"0%d",sed]:[NSString stringWithFormat:@"%d",sed]];
        }
    }
    
}


@end
