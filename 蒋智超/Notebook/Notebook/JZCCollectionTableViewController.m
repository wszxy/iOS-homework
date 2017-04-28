//
//  JZCCollectionTableViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/26.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCCollectionTableViewController.h"
#import "JZCNote.h"
@interface JZCCollectionTableViewController ()
@end

@implementation JZCCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.collections = [NSMutableArray arrayWithArray:self.notes];
}

- (void)back {
    [self.delegate collectionTableViewController:self withCollections:self.notes];
    self.collections = nil;
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    JZCNote *note = self.notes[indexPath.row];
    [self.notes removeObject:note];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.delegate collectionTableViewController:self withDeletedRow:indexPath.row];
    [self resetCollections];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.notes removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.delegate collectionTableViewController:self withDeletedRow:indexPath.row];
    [self resetCollections];
}


@end
