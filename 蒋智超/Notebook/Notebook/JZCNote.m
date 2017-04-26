//
//  JZCNote.m
//  Notebook
//
//  Created by miracle on 2017/4/25.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCNote.h"

@implementation JZCNote

- (instancetype)initWithTitle:(NSString *)title andText:(NSString *)text {
    if (self = [super init]) {
        _noteTitle = title;
        _noteText = text;
    }
    
    return self;
}

@end
