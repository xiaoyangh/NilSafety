//
//  NSArrayNilSafeTest.m
//  NilSafePro
//
//  Created by HuiYang on 17/2/24.
//  Copyright © 2017年 HuiYang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSArrayNilSafeTest : XCTestCase

@end

@implementation NSArrayNilSafeTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testNSArrayOutOfcount
{
    NSArray *testArr1 = @[@"1",@"2",@"3",@"4",@"5"];
    XCTAssertNoThrow([testArr1 objectAtIndex:10]);
}

-(void)testNSArrayInitOutOfcount
{
    NSString *strArr[3];
    strArr[0] = @"1";
    strArr[1] = @"2";
    strArr[2] = @"3";
    
     XCTAssertNoThrow([[NSArray alloc]initWithObjects:strArr count:4]);
    
}


-(void)testRemoveObjectAtIndex
{
    NSMutableArray *mTestArr1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];

    XCTAssertNoThrow( [mTestArr1 removeObjectAtIndex:10]);
}

-(void)testInsertObject
{
    NSMutableArray *mTestArr1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];

    XCTAssertNoThrow( [mTestArr1 insertObject:@"insert" atIndex:10]);
}

-(void)testSetObject
{
    NSMutableArray *mTestArr1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    
    XCTAssertNoThrow([mTestArr1 setObject:@"setobj" atIndexedSubscript:20]);
}

-(void)testReplaceObjectAtIndexNil
{
    NSMutableArray *mTestArr1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    id nilVal = nil;
    XCTAssertNoThrow([mTestArr1 replaceObjectAtIndex:2 withObject:nilVal]);
}

-(void)testReplaceObjectOutOfIndex
{
    NSMutableArray *mTestArr1 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    
    XCTAssertNoThrow( [mTestArr1 replaceObjectAtIndex:10 withObject:@"123"]);
}



@end
