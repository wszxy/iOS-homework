//
//  JZCListTableViewController.m
//  Notebook
//
//  Created by miracle on 2017/4/24.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCListTableViewController.h"
#import "JZCNote.h"
#import "JZCCollectionTableViewController.h"
#import "JZCDetailViewController.h"
#import "JZCListTableHeadView.h"
#import "JZCSearchResultTableViewController.h"
@interface JZCListTableViewController () <JZCDetailViewControllerDelegate, JZCCollectionTableViewControllerDelegate, JZCListTableHeadViewDelegate, JZCSearchResultTableViewControllerDelegate>
@property (nonatomic, weak) JZCListTableHeadView *headVi;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation JZCListTableViewController


-(NSMutableArray *)searchResults {
    if (!_searchResults) {
        _searchResults = [NSMutableArray array];
    }
    
    return _searchResults;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏夹" style:UIBarButtonItemStylePlain target:self action:@selector(pushToCollection)];
}

- (void)pushToCollection {
    JZCCollectionTableViewController *collectionVC = [[JZCCollectionTableViewController alloc] init];
    collectionVC.notes = [NSMutableArray arrayWithArray:self.collections];
    collectionVC.delegate = self;
    [self.navigationController pushViewController:collectionVC animated:YES];
}

- (void)add {
    JZCDetailViewController *detailVC = [[JZCDetailViewController alloc] init];
    detailVC.delegate = self;
    detailVC.add = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDelegate
//表头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.headVi =  [[[NSBundle mainBundle] loadNibNamed:@"JZCListTableHeadView" owner:nil options:nil] lastObject];
    self.headVi.delegate = self;
    return self.headVi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}



#pragma mark - JZCDetailViewControllerDelegate
- (void)detailViewController:(JZCDetailViewController *)vc noteForAdd:(JZCNote *)note{
    [self.notes insertObject:note atIndex:0];
    [self.tableView reloadData];
}

#pragma mark - JZCCollectionTableViewControllerDelegate
- (void)collectionTableViewController:(JZCCollectionTableViewController *)vc withCollections:(NSMutableArray *)col {
    if ([self.collections isEqualToArray:col]) return;
   
    for (int i = 0; i < col.count; i++) {
        JZCNote *colNote = col[i];
        NSUInteger index = [self.notes indexOfObject:self.collections[i]];
        [self.notes replaceObjectAtIndex:index withObject:colNote];
    }
    
    [self resetCollections];
    
    [self.tableView reloadData];
}

- (void)collectionTableViewController:(JZCCollectionTableViewController *)vc withDeletedRow:(NSInteger)row {
    JZCNote *colNote = self.collections[row];
    [self.collections removeObject:colNote];
    JZCNote *dataNote = self.notes[[self.notes indexOfObject:colNote]];
    dataNote.collect = NO;
    [self.tableView reloadData];
}

#pragma mark - JZClistTableHeadViewDelegate
- (void)listTableHeadView:(JZCListTableHeadView *)headView withSearchText:(NSString *)text {
    for (JZCNote *note in self.notes) {
        if ([note.totalStr containsString:text]) {
            [self.searchResults addObject:note];
        }
    }
    
    JZCSearchResultTableViewController *searchVC = [[JZCSearchResultTableViewController alloc] init];
    searchVC.notes = [NSMutableArray arrayWithArray:self.searchResults];
    searchVC.delegate = self;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)listTableHeadViewStartEdit:(JZCListTableHeadView *)headView {
    self.searchResults = nil;
}

#pragma mark - JZCSearchResultTableViewControllerDelegate
- (void)searchResultTableViewController:(JZCSearchResultTableViewController *)vc withDelegateRow:(NSInteger)row {
    JZCNote *note = self.searchResults[row];
    [self.searchResults removeObject:note];
    [self.notes removeObject:note];
    [self resetCollections];
    [self.tableView reloadData];
}

- (void)searchResultTableViewController:(JZCSearchResultTableViewController *)vc withResults:(NSMutableArray *)results {
    if ([self.searchResults isEqualToArray:results]) return;
    
    for (int i = 0; i < results.count; i++) {
        JZCNote *newResult = results[i];
        JZCNote *oldResult = self.searchResults[i];
        [self.notes replaceObjectAtIndex:[self.notes indexOfObject:oldResult] withObject:newResult];
    }
    [self resetCollections];
    [self.tableView reloadData];
}


@end
