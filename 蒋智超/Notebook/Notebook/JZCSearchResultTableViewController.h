//
//  JZCSearchResultTableViewController.h
//  Notebook
//
//  Created by miracle on 2017/4/28.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCBaseTableViewController.h"
@class JZCSearchResultTableViewController;
@protocol JZCSearchResultTableViewControllerDelegate <NSObject>

- (void)searchResultTableViewController:(JZCSearchResultTableViewController *)vc withDelegateRow:(NSInteger)row;
- (void)searchResultTableViewController:(JZCSearchResultTableViewController *)vc withResults:(NSMutableArray *)results;

@end
@interface JZCSearchResultTableViewController : JZCBaseTableViewController
@property (nonatomic, weak) id<JZCSearchResultTableViewControllerDelegate> delegate;
@end
