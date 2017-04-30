//
//  calculatorModel.h
//  calculator
//
//  Created by infinitsy on 2017/4/27.
//  Copyright © 2017年 infinitsy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, operationType) {
    plus = 0,
    minus,
    mutiply,
    devide,
    leftBracket,
    rightBracket,
    isEqualTo
};

@interface calculatorModel : NSObject
@property (nonatomic) BOOL error;
@property (nonatomic, strong) NSMutableArray *operandStack;
@property (nonatomic, strong) NSMutableArray *operationStack;
@property (nonatomic) double lastValueA;
@property (nonatomic) double lastValueB;
@property (nonatomic) double lastResult;
@property (nonatomic, strong) NSString *lastOperation;
-(void)pushOperand:(double)operand;
-(void)pushOperation:(NSString *)operation;
-(double)doMath:(NSString *)operation operandA:(double)a operandB:(double)b;
-(NSInteger)compareOperation:(NSString *)operation;
-(void)initStack;
-(void)performOperation:(NSString *)operation;
-(operationType)getTheTypeOfOperation:(NSString *)operation;
@end
