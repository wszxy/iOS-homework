//
//  JZCBaseTableViewController.h
//  Notebook
//
//  Created by miracle on 2017/4/26.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZCBaseTableHeadView;
@interface JZCBaseTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *notes;
@property (nonatomic, strong) NSMutableArray *collections;
- (void)resetCollections;
@end
