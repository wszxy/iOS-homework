//
//  JZCListTableViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/24.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCListTableViewController.h"
#import "JZCNote.h"
#import "JZCListTableHeadView.h"
#import "JZCDetailViewController.h"
#import "JZCCollectionTableViewController.h"

@interface JZCListTableViewController () <JZCDetailViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, weak) JZCListTableHeadView *headView;
@property (nonatomic, strong) JZCNote *selectedNote;
@property (nonatomic, strong) NSIndexPath *selectedIndex;
@property (nonatomic, strong) NSMutableArray *collections;
@end

@implementation JZCListTableViewController

- (NSMutableArray *)lists {
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    
    return _lists;
}

- (NSMutableArray *)collections {
    if (!_collections) {
        _collections = [NSMutableArray array];
    }
    
    return _collections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.lists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    JZCNote *note = self.lists[indexPath.row];
    cell.textLabel.text = note.noteTitle;
    cell.detailTextLabel.text = note.noteText;
    if (note.isCollected) {
        cell.accessoryView = [self configureAccessoryViewWithButtonPicture:@"collect"];
    } else {
        cell.accessoryView = [self configureAccessoryViewWithButtonPicture:@"uncollect"];
    }
    
    return cell;
}

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
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexpath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JZCNote *note = self.lists[indexPath.row];
    self.selectedNote = note;
    self.selectedIndex = indexPath;
    [self performSegueWithIdentifier:@"detail" sender:self];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    JZCNote *note = self.lists[indexPath.row];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    if (note.isCollected) {
        [self.collections removeObject:note];
        note.collect = NO;
        hud.label.text = @"已取消收藏";
    } else {
        note.collect = YES;
        [self.collections insertObject:note atIndex:0];
        hud.label.text = @"已收藏";
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    });
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"JZCListTableHeadView" owner:nil options:nil] lastObject];
    
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - JZCDetailViewControllerDelegate
- (void)detailViewController:(JZCDetailViewController *)vc noteForDetail:(JZCNote *)note flag:(BOOL)add{
    if (add) {
        [self.lists insertObject:note atIndex:0];
        [self.tableView reloadData];
    } else {
        [self.lists replaceObjectAtIndex:self.selectedIndex.row withObject:note];
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndex] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"add"]) {
        JZCDetailViewController *detailVC = (JZCDetailViewController *)segue.destinationViewController;
        detailVC.delegate = self;
        detailVC.add = YES;
    }
    if ([segue.identifier isEqualToString:@"detail"]) {
        JZCDetailViewController *detailVC = (JZCDetailViewController *)segue.destinationViewController;
        detailVC.delegate = self;
        detailVC.note = self.selectedNote;
    }
    
    if ([segue.identifier isEqualToString:@"collection"]) {
        JZCCollectionTableViewController *colVC = (JZCCollectionTableViewController *)segue.destinationViewController;
        [colVC deliverCollection:self.collections];
    }
}


@end
