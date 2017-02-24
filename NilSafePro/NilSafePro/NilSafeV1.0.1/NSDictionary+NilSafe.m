//
//  NSDictionary+NilSafe.m
//  UCSBaseBank
//
//  Created by HuiYang on 16/12/27.
//  Copyright © 2016年 杨辉. All rights reserved.
//  Email：xiaoyangh@foxmail.com
//

#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"
#import "NSObject+Swizzling.h"



@implementation NSDictionary (NilSafe)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryI") ns_swizzleMethod:@selector(objectForKey:) swizzledSelector:@selector(ns_replace_objectForKey:)];
            [objc_getClass("__NSDictionaryI") ns_swizzleMethod:@selector(length) swizzledSelector:@selector(ns_replace_length)];
            
            [objc_getClass("__NSDictionaryI") ns_swizzleMethod:@selector(initWithObjects:forKeys:count:) swizzledSelector:@selector(gl_initWithObjects:forKeys:count:)];
            
            [objc_getClass("__NSDictionaryI") ns_swizzleMethod:@selector(dictionaryWithObjects:forKeys:count:) swizzledSelector:@selector(gl_dictionaryWithObjects:forKeys:count:)];

            
            [objc_getClass("__NSDictionaryM") ns_swizzleMethod:@selector(setObject:forKey:) swizzledSelector:@selector(gl_setObject:forKey:)];
            [objc_getClass("__NSDictionaryM") ns_swizzleMethod:@selector(setObject:forKeyedSubscript:) swizzledSelector:@selector(gl_setObject:forKeyedSubscript:)];
            [objc_getClass("__NSPlaceholderDictionary") ns_swizzleMethod:@selector(initWithObjects:forKeys:count:) swizzledSelector:@selector(gl_mutableInitWithObjects:forKeys:count:)];
            
         
        }
    });
}

- (id)ns_replace_objectForKey:(NSString *)key {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [self ns_replace_objectForKey:key];
    }
    return nil;
}

- (NSUInteger)ns_replace_length {
    return 0;
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_initWithObjects:safeObjects forKeys:safeKeys count:j];
}


- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    if (!anObject) {
        anObject = [NSNull null];
    }
    [self gl_setObject:anObject forKey:aKey];
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        return;
    }
    if (!obj) {
        obj = [NSNull null];
    }
    [self gl_setObject:obj forKeyedSubscript:key];
}

- (instancetype)gl_mutableInitWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt{

    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self gl_mutableInitWithObjects:safeObjects forKeys:safeKeys count:j];
}



@end



