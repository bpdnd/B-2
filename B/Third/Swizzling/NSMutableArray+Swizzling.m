//
//  NSMutableArray+Swizzling.m
//  hehe
//
//  Created by 79car on 2018/6/3.
//  Copyright © 2018年 79car. All rights reserved.
//

#import "NSMutableArray+Swizzling.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Swizzling)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool{
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(gxlObjectAtIndex:)];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(gxlInsertObject:atIndex:)];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(gxlObjectAtIndexedSubscript:)];
        }
    });
    
}
//取值
-(id)gxlObjectAtIndex:(NSInteger)index{
    if (index>=self.count ||index<0) {
        NSLog(@"可变数组 objectAtIndex取值越界");
        return nil;
    }else{
       
        return [self gxlObjectAtIndex:index];
    }
}
-(id)gxlObjectAtIndexedSubscript:(NSInteger)index{
    if (index>=self.count ||index<0) {
        NSLog(@"可变数组[]取值越界");
        return nil;
    }else{
        
        return [self gxlObjectAtIndexedSubscript:index];
    }
    
}



//
-(void)gxlAddObject:(id)object{
    if (object) {
        return  [self gxlAddObject:object];
    }else{
        NSLog(@"添加的是nil");
    }
}
-(void)gxlInsertObject:(id)object atIndex:(NSInteger)index{
    if (object) {
        return [self gxlInsertObject:object atIndex:index];
    }else{
        NSLog(@"####");
    }
}
@end
