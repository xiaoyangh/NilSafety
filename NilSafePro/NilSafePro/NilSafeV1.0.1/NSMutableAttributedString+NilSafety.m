//
//  NSMutableAttributedString+NilSafe.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import "NSMutableAttributedString+NilSafety.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSMutableAttributedString (NilSafety)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSConcreteMutableAttributedString") ns_swizzleMethod:@selector(replaceCharactersInRange:withString:) swizzledSelector:@selector(ns_alert_replaceCharactersInRange:withString:)];
        }
    });
}

- (void)ns_alert_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if ((range.location + range.length) > self.length) {
        NSLog(@"error: Range or index out of bounds");
    }else {
        [self ns_alert_replaceCharactersInRange:range withString:aString];
    }
}

@end
