//
//  JZCBaseTableViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/26.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCBaseTableViewController.h"
#import "JZCNote.h"
#import "JZCDetailViewController.h"
@interface JZCBaseTableViewController () <JZCDetailViewControllerDelegate>
@property (nonatomic, strong) NSIndexPath *selectedIndex;
@end

@implementation JZCBaseTableViewController

- (NSMutableArray *)notes {
    if (!_notes) {
        _notes = [NSMutableArray array];
    }
    
    return _notes;
}

- (NSMutableArray *)collections {
    if (!_collections) {
        _collections = [NSMutableArray array];
    }
    
    return _collections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetCollections {
    self.collections = [NSMutableArray array];
    for (JZCNote *note in self.notes) {
        if (note.isCollected) {
            [self.collections addObject:note];
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    JZCNote *note = self.notes[indexPath.row];
    cell.textLabel.text = note.noteTitle;
    cell.detailTextLabel.text = note.noteText;
    if (note.isCollected) {
        cell.accessoryView = [self configureAccessoryViewWithButtonPicture:@"collect"];
    } else {
        cell.accessoryView = [self configureAccessoryViewWithButtonPicture:@"uncollect"];
    }
    
    return cell;
}

//自定义按钮
- (UIButton *)configureAccessoryViewWithButtonPicture:(NSString *)name {
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    [bu setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    bu.frame = CGRectMake(0, 0, 30, 30);
    [bu addTarget:self action:@selector(tapAccessoryView:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    return bu;
}

- (void)tapAccessoryView:(id)esnder forEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint  = [touch locationInView:self.tableView];
    NSIndexPath *indexpath = [self.tableView indexPathForRowAtPoint:touchPoint];
    if (indexpath) {
        JZCNote *note = self.notes[indexpath.row];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
        hud.mode = MBProgressHUDModeText;
        
        if (note.isCollected) {
            [self.collections removeObject:note];
            note.collect = NO;
            hud.label.text = @"已取消收藏";
        } else {
            JZCNote *newNote = [[JZCNote alloc] initWithTitle:note.noteTitle andText:note.noteText];
            newNote.collect = YES;
            [self.collections insertObject:newNote atIndex:0];
            [self.notes replaceObjectAtIndex:indexpath.row withObject:newNote];
            hud.label.text = @"已收藏";
        }
        
        [self.tableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexpath];
                
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        });

    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JZCDetailViewController *detailVC = [[JZCDetailViewController alloc] init];
    detailVC.delegate = self;
    detailVC.add = NO;
    detailVC.note = self.notes[indexPath.row];
    self.selectedIndex = indexPath;
    [self.navigationController pushViewController:detailVC animated:YES];

}

//左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    JZCNote *note = self.notes[indexPath.row];
    if (note.isCollected) {
        [self.collections removeObject:note];
    }
    [self.notes removeObject:note];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - JZCDetailViewControllerDelegate
- (void)detailViewController:(JZCDetailViewController *)vc noteForDetail:(JZCNote *)note{
    if (note.isCollected) {
        JZCNote *dataNote = self.notes[self.selectedIndex.row];
        [self.collections replaceObjectAtIndex:[self.collections indexOfObject:dataNote] withObject:note];
    }
    [self.notes replaceObjectAtIndex:self.selectedIndex.row withObject:note];
    [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndex] withRowAnimation:UITableViewRowAnimationFade];
    
}


@end
