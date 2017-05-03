//
//  ViewController.m
//  calculator
//
//  Created by infinitsy on 2017/4/27.
//  Copyright © 2017年 infinitsy. All rights reserved.
//

#import "ViewController.h"
#import "calculatorModel.h"
@interface ViewController ()
@property (nonatomic) BOOL enteringNumber;
@property (nonatomic) BOOL enteringExpression;
@property (nonatomic, strong) calculatorModel *model;
@property (nonatomic, strong) NSString *tempNumber;
@end

@implementation ViewController

-(calculatorModel *)model{
    if(!_model)
        _model = [[calculatorModel alloc] init];
    return _model;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if(self.enteringExpression){
        if(self.enteringNumber){
            self.tempNumber = [self.tempNumber stringByAppendingString:digit];
            self.display.text = [self.display.text stringByAppendingString:digit];
        }else{
            self.tempNumber = digit;
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.enteringNumber = YES;
        }
    } else {
        self.tempNumber = digit;
        self.display.text = digit;// [self.display.text stringByAppendingString:digit];
        self.enteringNumber = YES;
        self.enteringExpression = YES;
    }
    
}

- (IBAction)operationPressed:(UIButton *)sender {
    if([sender.currentTitle isEqualToString:@"Del"]){
        if(self.enteringNumber){
            self.tempNumber = [self.tempNumber substringToIndex:self.tempNumber.length-1];
        self.display.text = [self.display.text substringToIndex:self.display.text.length-1];
        }
    }else{
    if (self.enteringNumber){
        [self.model pushOperand:[self.tempNumber doubleValue]];
        self.enteringNumber = NO;

    }
    [self.model performOperation:sender.currentTitle];
    if([sender.currentTitle isEqualToString:@"="]){
        if(self.enteringExpression){
            if(self.model.error){
                self.display.text = @"ERROR";
                self.history.text = @"ERROR";
                self.enteringExpression = NO;
                self.enteringNumber = NO;
                [self.model initStack];
            }
            else{
                self.display.text = [NSString stringWithFormat:@"%g",[[self.model.operandStack lastObject] doubleValue]];
                self.history.text = [NSString stringWithFormat:@"%g %@ %g = %g",self.model.lastValueA,self.model.lastOperation,self.model.lastValueB,self.model.lastResult];
            }
        }else{
            [self acPressed];
        }
    } else {
        if(self.enteringExpression){
            self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
        }else{
            self.display.text = sender.currentTitle;
            self.enteringExpression = YES;
        }
    }
    }
}
- (IBAction)acPressed {
    self.enteringExpression = NO;
    self.enteringNumber = NO;
    self.display.text = @"0";
    self.history.text = @"0";
    // init stack...
    [self.model initStack];
}


@end
