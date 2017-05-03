//
//  JZCSearchResultTableViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/28.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCSearchResultTableViewController.h"
#import "JZCNote.h"
@interface JZCSearchResultTableViewController ()

@end

@implementation JZCSearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    for (JZCNote *note in self.notes) {
        if (note.isCollected) {
            [self.collections addObject:note];
        }
    }
}

- (void)back {
    [self.delegate searchResultTableViewController:self withResults:self.notes];
    self.collections = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    JZCNote *note = self.notes[indexPath.row];    
    FMDatabase *db = [FMDatabase databaseWithPath:kSqlitePath];
    if ([db open]) {
        [db executeUpdateWithFormat:@"delete from t_notes where title = %@ and detailText = %@;", note.noteTitle, note.noteText];
    }
    [db close];

    
    [self.notes removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.delegate searchResultTableViewController:self withDelegateRow:indexPath.row];
    [self resetCollections];
}

@end
