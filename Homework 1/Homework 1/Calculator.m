//
//  Calculator.m
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"
#import "UnitCal.h"
@interface Calculator()
@property(readwrite) NSString *answer;
@end
@implementation Calculator
{
    int n;
    NSMutableArray *Unit;
    NSMutableString *oprd;
    char op;
}
@synthesize polynomial,answer;
-(instancetype)init{
    self = [super init];
    if (self) {
        n = 0;
        Unit = [NSMutableArray arrayWithObject:[UnitCal new]];
        oprd = [NSMutableString stringWithCapacity:10];//suppose the maximum length of each number inputed is 10.
        answer = @"0";
    }
    return self;
}
-(NSString*)getResult{
    NSUInteger l = [self.polynomial length];
    for (int i=0;i < l;i++) {
        unichar character = [polynomial characterAtIndex:i];
        
        switch (character) {
            case 0x002E://.
            case 0x0030://0
            case 0x0031:
            case 0x0032:
            case 0x0033:
            case 0x0034:
            case 0x0035:
            case 0x0036:
            case 0x0037:
            case 0x0038:
            case 0x0039://9
                [oprd appendFormat:@"%C",character];
                break;
            case 0x002B://+
            case 0x002D://minus sign
            case 0x00D7:
            case 0x00F7://÷
                ((UnitCal*)Unit[n]).oprd3 = [oprd doubleValue];
                [Unit[n] reduce];
                [oprd setString:@""];
                switch (character) {
                    case 0x002B:
                        op = '+';
                        break;
                    case 0x002D:
                        op = '-';
                        break;
                    case 0x00D7:
                        op = '*';
                        break;
                    case 0x00F7:
                        op = '/';
                        break;
                }
                ((UnitCal*)Unit[n]).op2 = op;
                break;
            case 0x0028://(
                [Unit addObject:[UnitCal new]];
                n++;
                break;
            case 0x0029://)
                ((UnitCal*)Unit[n]).oprd3 = [oprd doubleValue];//is 0.0 if string oprd not begin with an invalid text.
                [oprd setString:[NSString stringWithFormat:@"%f",[(UnitCal*)Unit[n] getResult]]];
                [Unit removeLastObject];
                n--;
                if ([oprd doubleValue] == 0 && ((UnitCal*)Unit[n]).op2 == '/') {
                    return @"cannot divided by zero!";
                }

                break;
        }
    }
    ((UnitCal*)Unit[n]).oprd3 = [oprd doubleValue];
    double result = [(UnitCal*)Unit[n] getResult];
    Unit[n] = [UnitCal new];//back to initial state
    [oprd setString:@""];
    op = '+';
    answer = [NSString stringWithFormat:@"%f",result];
    return answer;    
}


@end
