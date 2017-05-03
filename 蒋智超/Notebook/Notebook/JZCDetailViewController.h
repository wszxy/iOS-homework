//
//  JZCDetailViewController.h
//  Notebook
//
//  Created by miracle on 2017/4/26.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZCNote;
@class JZCDetailViewController;

@protocol JZCDetailViewControllerDelegate <NSObject>
@optional
- (void)detailViewController:(JZCDetailViewController *)vc noteForDetail:(JZCNote *)note;
- (void)detailViewController:(JZCDetailViewController *)vc noteForAdd:(JZCNote *)note;
@end

@interface JZCDetailViewController : UIViewController

@property (nonatomic, weak) id<JZCDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) JZCNote *note;
@property (nonatomic, assign, getter=isAdded) BOOL add;
@end
