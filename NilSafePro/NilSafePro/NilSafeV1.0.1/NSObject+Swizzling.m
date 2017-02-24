//
//  NSObject+Swizzling.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)ns_swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
  
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
   
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
  
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
