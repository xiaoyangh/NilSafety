//
//  NSArray+NilSafety.m
//  UCSBaseBank
//
//  Created by HuiYang on 16/12/27.
//  Copyright © 2016年 杨辉. All rights reserved.
//  Email：xiaoyangh@foxmail.com
//

#import "NSArray+NilSafety.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>


@implementation NSArray (NilSafety)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArray0") ns_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(ns_emptyObjectIndex:)];
            [objc_getClass("__NSArrayI") ns_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(ns_objectAtIndex:)];
            
            [objc_getClass("__NSPlaceholderArray") ns_swizzleMethod:@selector(initWithObjects:count:) swizzledSelector:@selector(ns_initWithObjects:count:)];
            [objc_getClass("__NSPlaceholderArray") ns_swizzleMethod:@selector(arrayWithObjects:count:) swizzledSelector:@selector(ns_arrayWithObjects:count:)];
            
            [objc_getClass("__NSArrayM") ns_swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(ns_mutableObjectIndex:)];
            [objc_getClass("__NSArrayM") ns_swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(ns_insertObject:atIndex:)];
            [objc_getClass("__NSArrayM") ns_swizzleMethod:@selector(removeObjectAtIndex:) swizzledSelector:@selector(ns_removeObjectAtIndex:)];
            
             [objc_getClass("__NSArrayM") ns_swizzleMethod:@selector(setObject:atIndexedSubscript:) swizzledSelector:@selector(ns_setObject:atIndexedSubscript:)];
             [objc_getClass("__NSArrayM") ns_swizzleMethod:@selector(replaceObjectAtIndex:withObject:) swizzledSelector:@selector(ns_replaceObjectAtIndex:withObject:)];
            
            [objc_getClass("__NSArrayM") ns_swizzleMethod:@selector(integerValue) swizzledSelector:@selector(ns_replace_integerValue)];
            
            
        }
    });
}

+ (instancetype)ns_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{
        id safeObjects[cnt];
        int safeCnt = 0;
        for (int i = 0; i < cnt; i ++) {
            id obj = objects[i];
            if (obj) {
                safeObjects[safeCnt] = obj;
                safeCnt ++;
            }
        }
        return [self ns_arrayWithObjects:safeObjects count:safeCnt];
  
}

- (id)ns_emptyObjectIndex:(NSInteger)index{
    return nil;
}

- (id)ns_objectAtIndex:(NSUInteger)index {

        if (index >= self.count) {
            // nothing to do
            return nil;
        }
  
    return [self ns_objectAtIndex:index];
}

- (id)ns_mutableObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self ns_mutableObjectIndex:index];
}

- (instancetype)ns_initWithObjects:(const id [])objects count:(NSUInteger)cnt {
        id safeObjects[cnt];
        int safeCnt = 0;
        for (int i = 0; i < cnt; i ++) {
            id obj = objects[i];
            if (obj) {
                safeObjects[safeCnt] = obj;
                safeCnt ++;
            }
        }
        return [self ns_initWithObjects:safeObjects count:safeCnt];
  
}

- (void)ns_insertObject:(id)anObject atIndex:(NSUInteger)index {

        if (!anObject || index > self.count) {
            // nothing to do
            return;
        }

    [self ns_insertObject:anObject atIndex:index];
}

- (void)ns_setObject:(id)anObject atIndexedSubscript:(NSUInteger)index {

        if (!anObject || (index >= self.count)) {
            // nothing to do
            return;
        }

    [self ns_setObject:anObject atIndexedSubscript:index];
}

- (void)ns_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {

        if (!anObject || (index >= self.count)) {
            // nothing to do
            return;
        }

    [self ns_replaceObjectAtIndex:index withObject:anObject];
}

- (void)ns_removeObjectAtIndex:(NSUInteger)index {

        if (index >= self.count) {
            // nothing to do
            return;
        }
    [self ns_removeObjectAtIndex:index];
}

- (NSInteger)ns_replace_integerValue {
    return 0;
}

@end
