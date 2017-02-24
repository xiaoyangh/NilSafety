//
//  NSDictionaryNilSafeTest.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSDictionaryNilSafeTest : XCTestCase

@end

@implementation NSDictionaryNilSafeTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSetNilObject
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    id nilVal = nil;
    id nilKey = nil;
     XCTAssertNoThrow( [dic setObject:nilVal forKey:nilKey]);
}

-(void)testSetObjectforKeyedSubscript
{
    id objArr[3];
    NSString *keyArr[4];
    objArr[0] = @"1";
    objArr[1] = @"2";
    objArr[2] = @"3";
    
    keyArr[0] = @"key1";
    keyArr[1] = @"key2";
    keyArr[2] = @"key3";
    keyArr[3] = @"key4";
    NSMutableDictionary *mTestDict1 = [NSMutableDictionary dictionaryWithObjects:objArr forKeys:keyArr count:3];
    
    XCTAssertNoThrow( [mTestDict1 setObject:@"123" forKeyedSubscript:@"key1"]);
    
}

-(void)testDictionaryWithObjects
{
    id objArr[3];
    NSString *keyArr[4];
    objArr[0] = @"1";
    objArr[1] = @"2";
    objArr[2] = @"3";
    
    keyArr[0] = @"key1";
    keyArr[1] = @"key2";
    keyArr[2] = @"key3";
    
    XCTAssertNoThrow(  [NSDictionary dictionaryWithObjects:objArr forKeys:keyArr count:3]);
}

-(void)testUnarchiveObjectWithNilData
{
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";

    NSDictionary *dict2 = @{nonNilKey: nilVal,nilKey: nonNilVal};
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict2];
    XCTAssertNoThrow( [NSKeyedUnarchiver unarchiveObjectWithData:data]);
   
}

@end
