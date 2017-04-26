//
//  JZCNote.h
//  Notebook
//
//  Created by miracle on 2017/4/25.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZCNote : NSObject
@property (nonatomic, copy) NSString *noteTitle;
@property (nonatomic, copy) NSString *noteText;
@property (nonatomic, assign, getter=isCollected) BOOL collect;
- (instancetype)initWithTitle:(NSString *)title andText:(NSString *)text;
@end
