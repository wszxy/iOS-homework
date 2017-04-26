//
//  JZCDetailViewController.h
//  Notebook
//
//  Created by miracle on 2017/4/25.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZCNote;
@class JZCDetailViewController;

@protocol JZCDetailViewControllerDelegate <NSObject>

- (void)detailViewController:(JZCDetailViewController *)vc noteForDetail:(JZCNote *)note flag:(BOOL)add;

@end

@interface JZCDetailViewController : UIViewController

@property (nonatomic, weak) id<JZCDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) JZCNote *note;
@property (nonatomic, assign, getter=isAdded) BOOL add;
@end
