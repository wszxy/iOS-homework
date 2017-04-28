//
//  JZCCollectionTableViewController.h
//  Notebook
//
//  Created by miracle on 2017/4/26.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCBaseTableViewController.h"
@class JZCCollectionTableViewController;
@protocol JZCCollectionTableViewControllerDelegate <NSObject>

- (void)collectionTableViewController:(JZCCollectionTableViewController *)vc withCollections:(NSMutableArray *)col;
- (void)collectionTableViewController:(JZCCollectionTableViewController *)vc withDeletedRow:(NSInteger)row;

@end

@interface JZCCollectionTableViewController : JZCBaseTableViewController

@property (nonatomic, weak) id<JZCCollectionTableViewControllerDelegate> delegate;

@end
