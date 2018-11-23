//
//  NSArray+Swizzling.m
//  hehe
//
//  Created by 79car on 2018/6/3.
//  Copyright © 2018年 79car. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSArray (Swizzling)
+(void)load{
   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool{
        [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(gxlObjectAtIndex:)];
        }
    });
}
-(id)gxlObjectAtIndex:(NSInteger)index{
    if (index >= self.count||index < 0) {
        NSLog(@"不可变数组取值越界");
        return nil;
    }else{
        return  [self gxlObjectAtIndex:index];
    }
}


@end
