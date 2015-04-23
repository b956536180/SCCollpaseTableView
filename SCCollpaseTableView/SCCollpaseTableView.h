//
//  SCCollpaseTableView.h
//  SoulCode
//
//  Created by 5Z4 on 12-12-01.
//  Copyright (c) 2012年 zhifang_Liu. All rights reserved.
//
//     _____  _____
//    /           /    /     /
//   /_____      /    /_____/
//        /     /          /
//  _____/     /_____     /


#import <UIKit/UIKit.h>


@class SCCollpaseTableView;

@protocol SCCollapaseTableViewDataSource <NSObject>

@required
- (NSInteger)numberOfSectionsInCollapseTable:(SCCollpaseTableView *)collapseTable;
- (UIView *)collapseTable:(SCCollpaseTableView *)collapseTable viewForCellInSection:(NSInteger)section;

@optional
- (UIView *)collapseTable:(SCCollpaseTableView *)collapseTable viewForHeaderInSection:(NSInteger)section;
- (CGFloat)collapseTable:(SCCollpaseTableView *)collapseTable heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collapseTable:(SCCollpaseTableView *)collapseTable heightForCellInSection:(NSInteger)section;
@end

@protocol SCCollapseTableViewDelegate <NSObject>

@optional
- (void)collapseTable:(SCCollpaseTableView *)collapseTable didClickAtSectionIndex:(NSInteger)sectionIndex;

@end


@interface SCCollpaseTableView : UIView

@property (nonatomic, assign) IBOutlet id<SCCollapaseTableViewDataSource> dataSource;

@property (nonatomic, assign) IBOutlet id<SCCollapseTableViewDelegate      > delegate;

@property (nonatomic, retain) UITableView                    *table;

- (void)openCellInSection:(NSInteger)section;

- (void)closeCellInSection:(NSInteger)section;

- (void)openAllCell;

- (void)closeAllCell;

@end
