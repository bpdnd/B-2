//
//  NSMutableDictionary+Swizzling.m
//  hehe
//
//  Created by 79car on 2018/6/3.
//  Copyright © 2018年 79car. All rights reserved.
//

#import "NSMutableDictionary+Swizzling.h"

@implementation NSMutableDictionary (Swizzling)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryM") swizzleMethod:@selector(setObject:forKey:) swizzledSelector:@selector(replace_setObject:forKey:)];
            [objc_getClass("__NSDictionaryM") swizzleMethod:@selector(objectForKey:) swizzledSelector:@selector(replace_objectForKey:)];
        }
    });
}
-(void)replace_setObject:(id)object forKey:(NSString *)key{
    if (object&&key) {
        return [self replace_setObject:object forKey:key];
    }else{
        NSLog(@"字典添加null");
    }
}
-(id)replace_objectForKey:(NSString *)key{
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [self replace_objectForKey:key];
    }
    return nil;
}
@end
