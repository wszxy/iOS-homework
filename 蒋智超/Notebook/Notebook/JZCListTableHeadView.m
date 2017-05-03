//
//  JZCListTableHeadView.m
//  Notebook
//
//  Created by miracle on 2017/4/28.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCListTableHeadView.h"

@interface JZCListTableHeadView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation JZCListTableHeadView

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    if (textField.text.length) {
        [self.delegate listTableHeadView:self withSearchText:textField.text];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.delegate listTableHeadViewStartEdit:self];
    return YES;
}
@end
