//
//  ViewController.h
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "math.h"
#import "Inspector.h"
#import "Calculator.h"
@interface ViewController : UIViewController
@property IBOutlet UILabel *display;
-(IBAction)clickDigit:(UIButton*)sender;
-(IBAction)clickPlus;
-(IBAction)clickMinus;
-(IBAction)clickMultiply;
-(IBAction)clickDivide;
-(IBAction)clickDot;
-(IBAction)clickBack;
-(IBAction)clickEquals;
-(IBAction)clickLeftBrace;
-(IBAction)clickRightBrace;
-(IBAction)clickClear;
-(IBAction)clickAnswer;


@end

