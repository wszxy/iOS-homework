//
//  Inspector.m
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inspector.h"
typedef NS_ENUM(NSInteger,State){
    Inital,unsafedigit,nodotdigit,dotdigit,unsafedotdigit,safedot,unsafedot,safeop,division,Lbrace,Rbrace
};
@interface Inspector ()
@property(readwrite) NSString *inputAfterCheck;
@property (readwrite) NSString *errorString;
@property(readwrite)  BOOL isInputCorrect;
@end
@implementation Inspector
{
    State state;
    int i,rBraceNeeded,lBraceNeeded;
    NSMutableString *stringToProcess;
}
@synthesize userInput,inputAfterCheck,errorString,isInputCorrect;
-(instancetype)init{
    self = [super init];
    if (self) {
        state = Inital;
        i = 0;
        rBraceNeeded = 0;
        lBraceNeeded = 0;
        userInput = @"";
        inputAfterCheck = @"";
        errorString = @"Input not detected,please tap the screen to input.";
        isInputCorrect = false;
    }
    return self;
}
-(void)setUserInput:(NSString *)input{
    state = Inital;
    userInput = [NSString stringWithString:input];
    if ([self processUserInput]) {
        self.inputAfterCheck = stringToProcess;//can i set a nsstring from a mutablestring??
        self.isInputCorrect = true;
    }
    else self.isInputCorrect = false;
}
-(BOOL)processUserInput{
    stringToProcess = [NSMutableString stringWithString:self.userInput];
    for (; i < [stringToProcess length] ; i++) {
        unichar character = [stringToProcess characterAtIndex:i];
        switch (character) {
            case 0x002E://.
                if(![self handleDot])
                    return false;
                break;
            case 0x0030://0
                if(![self handleZero])
                    return false;
                break;
            case 0x0031://1
            case 0x0032:
            case 0x0033:
            case 0x0034:
            case 0x0035:
            case 0x0036:
            case 0x0037:
            case 0x0038:
            case 0x0039://9
                if(![self handleNonZero])
                    return false;
                break;
            case 0x002B://+
            case 0x002D://hyphen minus
            case 0x00D7://multiply
            case 0x2212://minus sign
                if(![self handleNonDivision])
                    return false;
                break;
            case 0x00F7://÷
                if(![self handleDivision])
                    return false;
                break;
            case 0x0028://(
                if(![self handleLbrace])
                    return false;//need to count
                break;
            case 0x0029://)
                if(![self handleRbrace])
                    return false;//need to count
                break;
            case 0x003D://=
                if(![self handleEquals])
                    return false;
                break;
        }
    }
    i = 0;
    return true;
}
-(BOOL)handleDot{
    switch (state) {
        case Inital:
            self.errorString = @"cannot start with dot";
            return false;
        case nodotdigit:
            state = safedot;
            return true;
        case dotdigit:
        case unsafedotdigit:
        case safedot:
        case unsafedot:
            self.errorString = @"cannot contain two dots in a number";
            return false;
        case unsafedigit:
            state = unsafedot;
            return true;
        case Lbrace:
        case Rbrace:
        case safeop:
        case division:
            self.errorString = @"cannot follow an operator or a brace by a dot";
            return false;
    }
}
-(BOOL)handleZero{
    switch (state) {
        case Inital:
        case nodotdigit:
        case safeop:
        case Lbrace:

            state = nodotdigit;
            return true;
        case dotdigit:
        case safedot:

            state = dotdigit;
            return true;
        case unsafedigit:
        case division:

            state = unsafedigit;
            return  true;
        case unsafedotdigit:
        case unsafedot:

            state = unsafedotdigit;
            return  true;
            
            
        case Rbrace:
            self.errorString = @"cannot follow a rightbrace by a number!";
            return false;


    
    }
}
-(BOOL)handleNonZero{
    switch (state) {
        case Inital:
        case nodotdigit:
        case unsafedigit:
        case safeop:
        case division:
        case Lbrace:
            state = nodotdigit;
            return true;
        case dotdigit:
        case unsafedotdigit:
        case safedot:
        case unsafedot:
            state = dotdigit;
            return  true;
        case Rbrace:
            self.errorString = @"cannot follow a rightbrace by a number!";
            return  false;
    }
}
-(BOOL)handleNonDivision{
    switch (state) {
        case Inital:
            self.errorString = @"cannot start with an operator!";
            return  false;
        case nodotdigit:
        case dotdigit:
        case Rbrace:

            state = safeop;
            return true;
        case unsafedigit:
        case unsafedotdigit:
            self.errorString = @"cannot diveded by zero!";
            return false;
        case safedot:
        case unsafedot:
            self.errorString = @"cannot follow an operator or a brace by a dot!";
            return false;
        case safeop:
        case division:

            self.errorString = @"cannot follow an operator by an operator!";
            return false;
        case Lbrace:
            self.errorString = @"cannot follow a left brace by an operator!";
            return false;
            
    }
}
-(BOOL)handleDivision{
    switch (state) {
        case Inital:
            self.errorString = @"cannot start with an operator!";
            return  false;
        case nodotdigit:
        case dotdigit:
        case Rbrace:
            
            state = division;
            return true;
        case unsafedigit:
        case unsafedotdigit:
            self.errorString = @"cannot diveded by zero!";
            return false;
        case safedot:
        case unsafedot:
            self.errorString = @"cannot follow an operator or a brace by a dot!";
            return false;
        case safeop:
        case division:
            
            self.errorString = @"cannot follow an operator by an operator!";
            return false;
        case Lbrace:
            self.errorString = @"cannot follow a left brace by an operator!";
            return false;
            
    }
}
-(BOOL)handleLbrace{
    rBraceNeeded++;
    switch (state) {
        case Inital:
            state = Lbrace;
            return true;
        case nodotdigit:
        case dotdigit:
        case unsafedigit:
        case unsafedotdigit:
        case safedot:
        case unsafedot:
            self.errorString = @"cannot follow a number or a dot by a left brace!";
            return false;
        case safeop:
        case division:
        case Lbrace:

            state = Lbrace;
            return true;
        case Rbrace:
            [stringToProcess insertString:@"×" atIndex:i];
            i++;
            state = Lbrace;
            return true;
            
            
            
            
    }
}

-(BOOL)handleRbrace{
    rBraceNeeded == 0 ? lBraceNeeded++ : rBraceNeeded--;
    switch (state) {
        case Inital:
        case nodotdigit:
        case dotdigit:
        case Lbrace:
        case Rbrace:
            state = Rbrace;
            return true;
        case unsafedigit:
        case unsafedotdigit:
            self.errorString = @"cannot diveded by zero!";
            return false;
        case safedot:
        case unsafedot:
            self.errorString = @"cannot follow a dot by a brace!";
            return false;
        case safeop:
        case division:
            self.errorString = @"cannot follow an operator by a brace!";
            return false;
    }
}
-(BOOL)handleEquals{
    switch (state) {
        case Inital:
        case nodotdigit:
        case dotdigit:
        case Lbrace:
        case Rbrace:
            [stringToProcess deleteCharactersInRange:(NSRange){i,1}];
            for (int j = 0; j < lBraceNeeded; j++) {
                [stringToProcess insertString:@"(" atIndex:0];
            }
            for (int j = 0; j < rBraceNeeded; j++) {
                [stringToProcess appendString:@")"];
            }
            lBraceNeeded = 0;
            rBraceNeeded = 0;
            self.errorString = @"Congratulations!Your syntacs is absolutely correct!";
            return true;
        case unsafedigit:
        case unsafedotdigit:
            self.errorString = @"cannot divided by zero!";
            return false;
        case unsafedot:
        case safedot:
        case safeop:
        case division:
            self.errorString = @"cannot end with an operator or a dot!";
            return false;
    }
}
@end