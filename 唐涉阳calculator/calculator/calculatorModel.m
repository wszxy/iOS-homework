//
//  calculatorModel.m
//  calculator
//
//  Created by infinitsy on 2017/4/27.
//  Copyright © 2017年 infinitsy. All rights reserved.
//

#import "calculatorModel.h"

@interface calculatorModel()

@property (nonatomic, strong) NSMutableArray *priorityLevel;
@end

@implementation calculatorModel

- (NSMutableArray *)operationStack{
    if (_operationStack == nil) _operationStack = [[NSMutableArray alloc] initWithArray:@[@"="]];
    return _operationStack;
}

- (NSMutableArray *)operandStack{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (NSArray *)priorityLevel{
    if (_priorityLevel == nil)
        _priorityLevel = [[NSMutableArray alloc]
                          initWithArray:
                          @[@[@"1", @"1", @"-1",@"-1", @"-1", @"1", @"1"],
                            @[@"1", @"1", @"-1",@"-1", @"-1", @"1", @"1"],
                            @[@"1", @"1", @"1",@"1", @"-1", @"1", @"1"],
                            @[@"1", @"1", @"1",@"1", @"-1", @"1", @"1"],
                            @[@"-1", @"-1", @"-1",@"-1", @"-1", @"0", @"0"],
                            @[@"1",@"1",@"1",@"1",@"0",@"1",@"1",],
                            @[@"-1", @"-1", @"-1",@"-1", @"-1", @"0", @"0"]
                            ]];
    return _priorityLevel;
}

- (void)initStack{
    [self.operandStack removeAllObjects];
    [self.operationStack setArray:@[@"="]];
    self.error = NO;
}

- (void)pushOperand:(double)operand{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (void)pushOperation:(NSString *)operation{
    [self.operationStack addObject:operation];
}

- (double)popOperand{
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject) [self.operandStack removeLastObject];
    else self.error = YES;
    return [operandObject doubleValue];
}

- (NSString *)popOperation{
    NSString *operationObject = [self.operationStack lastObject];
    if(operationObject) [self.operationStack removeLastObject];
    else self.error = YES;
    return operationObject;
}

- (operationType)getTheTypeOfOperation:(NSString *)operation{
    if([operation isEqualToString:@"+"])
        return plus;
    else if([operation isEqualToString:@"-"])
        return minus;
    else if([operation isEqualToString:@"x"])
        return mutiply;
    else if([operation isEqualToString:@"÷"])
        return devide;
    else if([operation isEqualToString:@"("])
        return leftBracket;
    else if([operation isEqualToString:@")"])
        return rightBracket;
    else //if([operation isEqualToString:@"="])
        return isEqualTo;
}

- (NSInteger)compareOperation:(NSString *)operation{
    operationType operationAType,operationBType;
    operationAType = [self getTheTypeOfOperation:[self.operationStack lastObject]];
    operationBType = [self getTheTypeOfOperation:operation];
    return [self.priorityLevel[operationAType][operationBType] integerValue];
}

- (void)performOperation:(NSString *)operation{
    BOOL flag = NO;
    while(![operation isEqualToString:@"="]||![[self.operationStack lastObject] isEqualToString:@"="]){
        switch ([self compareOperation:operation]){
        case -1:{
            [self pushOperation:operation];
            flag = NO;
            break;
        }
        case 0:{
            [self popOperation];
            flag = NO;
            break;
        }
        case 1:{
            self.lastOperation = [self popOperation];
            self.lastValueB = [self popOperand];
            self.lastValueA = [self popOperand];
            if(self.lastValueB == 0 && [self.lastOperation isEqualToString:@"÷"] ) self.error = YES;
            else{
                [self pushOperand:[self doMath:self.lastOperation operandA:self.lastValueA operandB:self.lastValueB]];
            }
            flag = YES;
            break;
        }
        }
        if(!flag) break;
    }
}

- (double)doMath:(NSString *)operation operandA:(double)a operandB:(double)b {
    if ([operation isEqualToString:@"+"]){
        self.lastResult = a + b;
    } else if([operation isEqualToString:@"-"]){
        self.lastResult = a - b;
    } else if([operation isEqualToString:@"x"]){
        self.lastResult = a * b;
    } else if([operation isEqualToString:@"÷"]){
        self.lastResult = a / b;
    }
    return self.lastResult;
}

@end
