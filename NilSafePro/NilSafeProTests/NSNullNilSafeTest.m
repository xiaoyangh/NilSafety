//
//  NSNullNilSafeTest.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSNullNilSafeTest : XCTestCase

@end

@implementation NSNullNilSafeTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMethodSignatureForSelector {

#pragma mark Null
    
    id nullStr = [NSNull null];
    XCTAssertNoThrow([nullStr stringByAppendingString:@"123"]);

}

-(void)testNUllLenght
{
    id nullStr = [NSNull null];
    XCTAssertNoThrow([nullStr length]);
}



@end
