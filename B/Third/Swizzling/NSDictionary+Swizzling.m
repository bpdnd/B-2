//
//  NSDictionary+Swizzling.m
//  hehe
//
//  Created by 79car on 2018/6/3.
//  Copyright © 2018年 79car. All rights reserved.
//

#import "NSDictionary+Swizzling.h"

@implementation NSDictionary (Swizzling)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryI") swizzleMethod:@selector(objectForKey:) swizzledSelector:@selector(replace_objectForKey:)];
            [objc_getClass("__NSDictionaryI") swizzleMethod:@selector(length) swizzledSelector:@selector(replace_length)];
        }
    });
}

- (id)replace_objectForKey:(NSString *)key {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [self replace_objectForKey:key];
    }
    return nil;
}

- (NSUInteger)replace_length {
    return 0;
}
@end
