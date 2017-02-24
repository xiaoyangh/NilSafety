//
//  NSNull+NilSafety.m
//  UCSBaseBank
//
//  Created by HuiYang on 16/12/27.
//  Copyright © 2016年 杨辉. All rights reserved.
//  Email：xiaoyangh@foxmail.com
//

#import "NSNull+NilSafety.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>


@implementation NSNull (NilSafety)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ns_swizzleMethod:@selector(methodSignatureForSelector:)
                    swizzledSelector:@selector(ns_methodSignatureForSelector:)];
        [self ns_swizzleMethod:@selector(forwardInvocation:)
                    swizzledSelector:@selector(ns_forwardInvocation:)];
         [objc_getClass("NSNull") ns_swizzleMethod:@selector(length) swizzledSelector:@selector(ns_replace_length)];
    });
}

- (NSMethodSignature *)ns_methodSignatureForSelector:(SEL)aSelector {
    
        NSMethodSignature * sig = [self ns_methodSignatureForSelector:aSelector];
        if (sig) {
            return sig;
        }
        return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
    
}

- (void)ns_forwardInvocation:(NSInvocation *)anInvocation {
    
        NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
        if (!returnLength) {
            // nothing to do
            return;
        }
        
        // set return value to all zero bits
        char buffer[returnLength];
        memset(buffer, 0, returnLength);
        
        [anInvocation setReturnValue:buffer];

}

- (NSInteger)ns_replace_length {
    return 0;
}





@end
