//
//  NSString+NilSafety.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import "NSString+NilSafety.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSString (NilSafety)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSCFConstantString") ns_swizzleMethod:@selector(substringToIndex:) swizzledSelector:@selector(ns_replace_substringToIndex:)];
            [objc_getClass("__NSCFConstantString") ns_swizzleMethod:@selector(objectForKeyedSubscript:) swizzledSelector:@selector(ns_replace_objectForKeyedSubscript:)];
        }
    });
}

- (NSString *)ns_replace_substringToIndex:(NSUInteger)to {
    if (to > self.length) {
        return nil;
    }
    
    return [self ns_replace_substringToIndex:to];
}

- (id)ns_replace_objectForKeyedSubscript:(NSString *)key {
    
    
    return nil;
}

@end
