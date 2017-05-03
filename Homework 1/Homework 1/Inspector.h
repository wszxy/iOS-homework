//
//  Inspector.h
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#ifndef Inspector_h
#define Inspector_h


#endif /* Inspector_h */
#import "Calculator.h"
@interface Inspector:NSObject
@property(nonatomic,copy) NSString *userInput;//whenever set,clear the other two old properties.
@property(nonatomic,readonly) NSString *inputAfterCheck;
@property(nonatomic,readonly) NSString *errorString;
@property(nonatomic,readonly) BOOL isInputCorrect;
@end
