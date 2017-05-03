//
//  UnitCal.m
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnitCal.h"
@implementation UnitCal
@synthesize oprd1,oprd2,oprd3,op1,op2;
-(instancetype)init{
    self = [super init];
    if (self) {
        oprd1 = 0;
        oprd2 = 0;
        oprd3 = 0;
        op1 = '+';
        op2 = '+';
    }
    return self;
}
-(void)reduce{
    if (op1 == '*' || op1 == '/' || op2 == '+' || op2 == '-') {
        self.oprd1 = [self operateWithA:oprd1 andB:oprd2 andOp:op1];
        self.oprd2 = oprd3;
        self.oprd3 = 0;
        self.op1 = op2;
        self.op2 = '+';
    }
    else{
        self.oprd2 = [self operateWithA:oprd2 andB:oprd3 andOp:op2];
        self.oprd3 = 0;
        self.op2 = '+';
    }
}
-(double)operateWithA:(double)a andB:(double)b andOp:(char)op{
    double operationResult = 0;
    switch (op) {
        case '+':
            operationResult = a + b;
            break;
        case '-':
            operationResult = a - b;
            break;
        case '*':
            operationResult = a * b;
            break;
        case '/':
            operationResult = a / b;
            break;
    }
    return operationResult;
}
-(double)getResult{
    double lastResult = 0;
    [self reduce];
    lastResult = [self operateWithA:oprd1 andB:oprd2 andOp:op1];
    self.oprd1 = 0;
    self.oprd2 = 0;
    self.op1 = '+';
    return lastResult;
}
@end

