//
//  Homework_1Tests.m
//  Homework 1Tests
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UnitCal.h"
@interface Homework_1Tests : XCTestCase

@end

@implementation Homework_1Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    UnitCal *aCal = [UnitCal new];
    aCal.oprd3 = 3.9;
    aCal.op2 = '*';
    NSLog(@"the result is %f",[aCal getResult]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
