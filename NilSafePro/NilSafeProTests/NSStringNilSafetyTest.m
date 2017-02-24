//
//  AttributedStringNilSafetyTest.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AttributedStringNilSafetyTest : XCTestCase

@end

@implementation AttributedStringNilSafetyTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAttributedStringReplaceCharactersInRange {
    NSMutableAttributedString *str =[[NSMutableAttributedString alloc]initWithString:@"123456"];
     XCTAssertNoThrow([str replaceCharactersInRange:NSMakeRange(9, 2) withString:@"hh"]);
    
}

- (void)testMutableStringReplaceCharactersInRange {
    NSMutableString *str =[[NSMutableString alloc]initWithString:@"123456"];
    XCTAssertNoThrow([str replaceCharactersInRange:NSMakeRange(9, 2) withString:@"hh"]);
    
}

- (void)testStringReplaceCharactersInRange {
    NSString *str =@"123456";
    XCTAssertNoThrow([str substringToIndex:9]);
    
}

- (void)testStringObjectForKeyedSubscript {
    id dic =@"222222";
   
    XCTAssertNoThrow( dic[@"99"]);
    
}

@end
