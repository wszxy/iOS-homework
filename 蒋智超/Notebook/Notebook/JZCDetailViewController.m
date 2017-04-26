//
//  JZCDetailViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/25.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCDetailViewController.h"

#import "JZCNote.h"

@interface JZCDetailViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *detailTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation JZCDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.note) {
        self.detailTitle.text = self.note.noteTitle;
        self.detailText.text = self.note.noteText;
        if (self.detailText.text.length) {
            self.placeholderLabel.text = @"";
        }
    }
}


- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender {
    if (self.detailTitle.text.length || self.detailText.text.length) {
        JZCNote *note = [[JZCNote alloc] initWithTitle:self.detailTitle.text andText:self.detailText.text];
        [self.delegate detailViewController:self noteForDetail:note flag:self.isAdded];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        self.placeholderLabel.text = @"";
    } else {
        self.placeholderLabel.text = @"正文";
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
