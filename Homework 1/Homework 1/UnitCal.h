//
//  UnitCal.h
//  Homework 1
//
//  Created by john on 4/21/17.
//  Copyright © 2017 john. All rights reserved.
//

#ifndef UnitCal_h
#define UnitCal_h


#endif /* UnitCal_h */
@interface UnitCal:NSObject
@property double oprd1,oprd2,oprd3;
@property char op1,op2;//becaue of syntacs of switch statement,use type char.  
-(void)reduce;
-(double)getResult;
@end
