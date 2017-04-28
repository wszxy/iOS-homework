//
//  JZCListTableHeadView.h
//  Notebook
//
//  Created by miracle on 2017/4/28.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZCListTableHeadView;
@protocol JZCListTableHeadViewDelegate <NSObject>

- (void)listTableHeadView:(JZCListTableHeadView *)headView withSearchText:(NSString *)text;
- (void)listTableHeadViewStartEdit:(JZCListTableHeadView *)headView;

@end
@interface JZCListTableHeadView : UIView

@property (nonatomic, weak) id<JZCListTableHeadViewDelegate> delegate;

@end
