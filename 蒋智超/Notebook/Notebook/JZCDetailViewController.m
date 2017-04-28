//
//  JZCDetailViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/26.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCDetailViewController.h"
#import "JZCNote.h"
@interface JZCDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *detailTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@end

@implementation JZCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    if (self.note) {
        self.detailTitle.text = self.note.noteTitle;
        self.detailText.text = self.note.noteText;
        if (self.detailText.text.length) {
            self.placeholderLabel.text = @"";
        }
    }
    
    [self.detailTitle becomeFirstResponder];
}

- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)done {
    if (self.detailTitle.text.length || self.detailText.text.length) {
        JZCNote *note = [[JZCNote alloc] initWithTitle:self.detailTitle.text andText:self.detailText.text];
        if ([self.delegate respondsToSelector:@selector(detailViewController:noteForAdd:)] && self.isAdded) {
            [self.delegate detailViewController:self noteForAdd:note];
        } else {
            if (self.note.isCollected) {
                note.collect = YES;
            }
            [self.delegate detailViewController:self noteForDetail:note];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        self.placeholderLabel.text = @"";
    } else {
        self.placeholderLabel.text = @"正文";
    }
}



@end
