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
@property (nonatomic, strong) NSMutableArray *noteCollection;
@end

@implementation JZCCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)deliverCollection:(NSMutableArray *)collection {
    self.noteCollection = [NSMutableArray arrayWithArray:collection];
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
    return self.noteCollection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    JZCNote *note = self.noteCollection[indexPath.row];
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

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    JZCNote *note = self.noteCollection[indexPath.row];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    hud.mode = MBProgressHUDModeText;
    
    if (note.isCollected) {
        [self.noteCollection removeObject:note];
        note.collect = NO;
        hud.label.text = @"已取消收藏";
    } else {
        note.collect = YES;
        [self.noteCollection insertObject:note atIndex:0];
        hud.label.text = @"已收藏";
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    });
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
