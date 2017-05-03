//
//  ViewController.m
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableString *displayString;
    Inspector *inspector;
    Calculator *calculator;
   
}
@synthesize display;
- (void)viewDidLoad {
    [super viewDidLoad];
    displayString = [NSMutableString stringWithString:@""];
    display.text = displayString;
    inspector = [Inspector new];
    calculator = [Calculator new];
  
}
-(IBAction)clickDigit:(UIButton*)sender{
    int aDigit = (int)sender.tag;
    [displayString appendFormat:@"%d",aDigit];
    display.text = displayString;
}
-(IBAction)clickPlus{
    [displayString appendString:@"+"];
    display.text = displayString;
}
-(IBAction)clickMinus{
    [displayString appendString:@"-"];
    display.text = displayString;
}
-(IBAction)clickMultiply{
    [displayString appendString:@"×"];
    display.text = displayString;
}
-(IBAction)clickDivide{
    [displayString appendString:@"÷"];
    display.text = displayString;
}
-(IBAction)clickDot{
    [displayString appendString:@"."];
    display.text = displayString;
}
-(IBAction)clickBack{
    if (displayString.length) {
    [displayString deleteCharactersInRange:(NSRange){displayString.length - 1,1}];
    display.text = displayString;
    }
}

-(IBAction)clickLeftBrace;{
    [displayString appendString:@"("];
    display.text = displayString;
}
-(IBAction)clickRightBrace{
    [displayString appendString:@")"];
    display.text = displayString;
}
-(IBAction)clickEquals{
    [displayString appendString:@"="];
    inspector.userInput = displayString;
    if (inspector.isInputCorrect) {
        calculator.polynomial = inspector.inputAfterCheck;
        displayString = [NSMutableString stringWithString:[calculator getResult]];
        
    }
    else{
        displayString = [NSMutableString stringWithString:inspector.errorString];
            }
    display.text = displayString;
    [displayString setString:@""];
}
-(IBAction)clickClear{
    [displayString setString:@""];
    display.text = @"";
}
-(IBAction)clickAnswer{
    [displayString appendString:calculator.answer];
    display.text = displayString;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
