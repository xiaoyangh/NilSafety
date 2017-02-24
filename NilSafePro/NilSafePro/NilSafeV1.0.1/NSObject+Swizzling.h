//
//  NSObject+Swizzling.h
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)ns_swizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
