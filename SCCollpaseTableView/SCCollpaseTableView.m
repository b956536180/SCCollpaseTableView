//
//  SCCollpaseTableView.m
//  20140318_CollapaseTabelView
//
//  Created by Xiao on 14-3-18.
//  Copyright (c) 2014年 ZhangXueFei. All rights reserved.
//

#import "SCCollpaseTableView.h"
#import "SCCollpaseTableHeaderArrow.h"

@interface SCCollpaseTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *innerDateArray;  //

@property (nonatomic, assign) NSInteger numberOfSections;

@end


@implementation SCCollpaseTableView

#pragma mark - Super Methods
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.subviews.count == 0) {
        [self _initView];
        
    }
}


#pragma mark - Publice Methods
- (void)openCellInSection:(NSInteger)section{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UIView *headerView = [[_innerDateArray objectAtIndex:section] objectForKey:@"headerView"];
    BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"] boolValue];
    
    [[_innerDateArray objectAtIndex:section] setObject:[NSNumber numberWithBool:YES] forKey:@"isOpen"];
    
    SCCollpaseTableHeaderArrow *arrow = nil;
    for (UIView *v in headerView.subviews) {
        if ([v isKindOfClass:[SCCollpaseTableHeaderArrow class]]) {
            arrow = (SCCollpaseTableHeaderArrow *)v;
            break;
        }
    }
    
    UIView *line = [headerView viewWithTag:section + 10000];
    
    if (!isOpen) {
        [line setHidden:NO];
        
        if (arrow) {
            [UIView animateWithDuration:0.25f
                             animations:^{
                                 // Change Arrow orientation
                                 CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 2);
                                 arrow.transform = transform;
                             }];
        }
        
        [_table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)]; // 调用了此方法，会重新加载数据，类似于reloadData方法，所以需要及时更新numberOfRowsInSection:的数据。
    }
}

- (void)closeCellInSection:(NSInteger)section {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    UIView *headerView = [[_innerDateArray objectAtIndex:section] objectForKey:@"headerView"];
    BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"] boolValue];
    
    [[_innerDateArray objectAtIndex:section] setObject:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
    
    SCCollpaseTableHeaderArrow *arrow = nil;
    for (UIView *v in headerView.subviews) {
        if ([v isKindOfClass:[SCCollpaseTableHeaderArrow class]]) {
            arrow = (SCCollpaseTableHeaderArrow *)v;
            break;
        }
    }
    
    UIView *line = [headerView viewWithTag:section + 10000];
    
    if (isOpen) {
        if (line.tag - 10000 == (_numberOfSections - 1)) { // 如果为最后一个section的话，末尾的底线还是需要加上，不然最后一个section的底线就没有了
            [line setHidden:NO];
        } else {
            [line setHidden:YES];
        }
        
        if (arrow) {
            [UIView animateWithDuration:0.25f
                             animations:^{
                                 // Change Arrow orientation
                                 CGAffineTransform transform = CGAffineTransformMakeRotation(0);
                                 arrow.transform = transform;
                             }];
        }
        
        [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)]; // 调用了此方法，会重新加载数据，类似于reloadData方法，所以需要及时更新numberOfRowsInSection:的数据。
    }
}

- (void)openAllCell {
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < _numberOfSections; i++) {
        NSInteger section = i;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        UIView *headerView = [[_innerDateArray objectAtIndex:section] objectForKey:@"headerView"];
        BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"] boolValue];
        
        [[_innerDateArray objectAtIndex:section] setObject:[NSNumber numberWithBool:YES] forKey:@"isOpen"];
        
        SCCollpaseTableHeaderArrow *arrow = nil;
        for (UIView *v in headerView.subviews) {
            if ([v isKindOfClass:[SCCollpaseTableHeaderArrow class]]) {
                arrow = (SCCollpaseTableHeaderArrow *)v;
                break;
            }
        }
        
        UIView *line = [headerView viewWithTag:section + 10000];
        
        if (!isOpen) {
            [line setHidden:NO];
            
            if (arrow) {
                [UIView animateWithDuration:0.25f
                                 animations:^{
                                     // Change Arrow orientation
                                     CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 2);
                                     arrow.transform = transform;
                                 }];
            }
            
            [indexPathArray addObject:indexPath];
        }
    }
    
    [_table insertRowsAtIndexPaths:indexPathArray withRowAnimation:(UITableViewRowAnimationTop)]; // 调用了此方法，会重新加载数据，类似于reloadData方法，所以需要及时更新numberOfRowsInSection:的数据。

}

- (void)closeAllCell{
    NSMutableArray *indexPathArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < _numberOfSections; i++) {
        NSInteger section = i;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        UIView *headerView = [[_innerDateArray objectAtIndex:section] objectForKey:@"headerView"];
        BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"] boolValue];
        
        [[_innerDateArray objectAtIndex:section] setObject:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
        
        SCCollpaseTableHeaderArrow *arrow = nil;
        for (UIView *v in headerView.subviews) {
            if ([v isKindOfClass:[SCCollpaseTableHeaderArrow class]]) {
                arrow = (SCCollpaseTableHeaderArrow *)v;
                break;
            }
        }
        
        UIView *line = [headerView viewWithTag:section + 10000];
        
        if (isOpen) {
            if (line.tag - 10000 == (_numberOfSections - 1)) { // 如果为最后一个section的话，末尾的底线还是需要加上，不然最后一个section的底线就没有了
                [line setHidden:NO];
            } else {
                [line setHidden:YES];
            }
            
            if (arrow) {
                [UIView animateWithDuration:0.25f
                                 animations:^{
                                     // Change Arrow orientation
                                     CGAffineTransform transform = CGAffineTransformMakeRotation(0);
                                     arrow.transform = transform;
                                 }];
            }
            
            [indexPathArray addObject:indexPath];
        }
    }
    
    [_table deleteRowsAtIndexPaths:indexPathArray withRowAnimation:(UITableViewRowAnimationTop)]; // 调用了此方法，会重新加载数据，类似于reloadData方法，所以需要及时更新numberOfRowsInSection:的数据。
}

#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSection = 0;
    
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInCollapseTable:)]) {
        numberOfSection = [_dataSource numberOfSectionsInCollapseTable:self];
    }
    
    if (_numberOfSections != numberOfSection) {
        for (unsigned i = 0; i <numberOfSection; i++) {
            if (i == 0) {
                NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:0];
                [md setObject:[NSNumber numberWithBool:YES] forKey:@"isOpen"];
                [_innerDateArray addObject:md];
            }
            else{
                NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:0];
                [md setObject:[NSNumber numberWithBool:NO] forKey:@"isOpen"];
                [_innerDateArray addObject:md];
            }
        }
    }
    
    _numberOfSections = numberOfSection;
    
    return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"]boolValue];
    
    if (isOpen) {
        return 1;
    }
    else{
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat heightForRow = 100;
    
    if ([_dataSource respondsToSelector:@selector(collapseTable:heightForCellInSection:)]) {
        heightForRow = [_dataSource collapseTable:self heightForCellInSection:indexPath.section];
    }
    
    CGFloat height = [[[_innerDateArray objectAtIndex:indexPath.section] objectForKey:@"heightForRow"] floatValue];
    if (heightForRow != height) {
        [[_innerDateArray objectAtIndex:indexPath.section] setObject:[NSNumber numberWithFloat:heightForRow] forKey:@"heightForRow"];
    }
    
    return heightForRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifiier = @"SCCollpaseTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    //???????????????????????????????????????????????????????????????????
    
    UIView *cellView = nil;
    
    if ([_dataSource respondsToSelector:@selector(collapseTable:viewForCellInSection:)]) {
        cellView = [_dataSource collapseTable:self viewForCellInSection:indexPath.section];
        if (cellView) {
            CGFloat height = [[[_innerDateArray objectAtIndex:indexPath.section] objectForKey:@"heightForRow"] floatValue];
            cellView.frame = CGRectMake(0, 0, self.bounds.size.width, height);
            [cell addSubview:cellView];
        }
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat heightForHeader = 35;
    
    if ([_dataSource respondsToSelector:@selector(collapseTable:heightForHeaderInSection:)]) {
        heightForHeader = [_dataSource collapseTable:self heightForHeaderInSection:section];
    }
    
    CGFloat height = [[[_innerDateArray objectAtIndex:section] objectForKey:@"heightForHeader"] floatValue];
    if (height != heightForHeader) {
        [[_innerDateArray objectAtIndex:section] setObject:[NSNumber numberWithFloat:heightForHeader] forKey:@"heightForHeader"];
    }
    
    return heightForHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    [headerView setTag:section];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat arrowWidth = 15;
    CGFloat heightForHeader = [[[_innerDateArray objectAtIndex:section] objectForKey:@"heightForHeader"] floatValue];
    SCCollpaseTableHeaderArrow *arrow = [[SCCollpaseTableHeaderArrow alloc] initWithFrame:CGRectMake(self.bounds.size.width - arrowWidth - 10, (heightForHeader - arrowWidth) / 2, arrowWidth, arrowWidth)];
    [headerView addSubview:arrow];
    
    BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"] boolValue];
    if (isOpen) {
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 2);
        arrow.transform = transform;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_actionForTapGesture:)];
    [headerView addGestureRecognizer:tap];
    
    // 加横向分割线
    // 顶部线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [headerView addSubview:line];
    
    // 底部线
    line = [[UIView alloc] initWithFrame:CGRectMake(0, heightForHeader - 1, self.bounds.size.width, 1)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [line setTag:section + 10000];
    [headerView addSubview:line];
    
    if (section == _numberOfSections - 1) { // 如果是最后一个section的话，就不能将底线去掉
        [line setHidden:NO];
    } else {
        [line setHidden:YES];
    }
    
    if (isOpen) {
        [line setHidden:NO];
    }
    
    
    // 添加section的标题文本
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - (arrowWidth + 10 + 5 + 10), heightForHeader)] ;
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor darkGrayColor]];
    [label setText:[NSString stringWithFormat:@"Section%ld", (long)section]];
    [headerView addSubview:label];
    
    // 添加外部设置的section header
    if ([_dataSource respondsToSelector:@selector(collapseTable:viewForHeaderInSection:)]) {
        UIView *innerHeaderView = [_dataSource collapseTable:self viewForHeaderInSection:section];
        if (innerHeaderView) {
            [innerHeaderView setFrame:CGRectMake(0, 0, self.bounds.size.width, heightForHeader)];
            [headerView addSubview:innerHeaderView];
            [headerView bringSubviewToFront:arrow];
        }
    }
    
    [[_innerDateArray objectAtIndex:section] setObject:headerView forKey:@"headerView"];
 
    return headerView;
    
}

#pragma mark - Private Methods

- (void)_initView {
    self.table = [[UITableView alloc] initWithFrame:self.bounds];
    [_table setDelegate:self];
    [_table setDataSource:self];
    [_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_table setShowsVerticalScrollIndicator:NO];
    [self addSubview:_table];

}

- (void)_initData {

    _innerDateArray = [NSMutableArray arrayWithCapacity:0];
    _numberOfSections = -1;
    
    
//    self.backgroundColor = [UIColor redColor];
    
}

- (void)_actionForTapGesture:(UITapGestureRecognizer *)recognizer {
    NSInteger section = recognizer.view.tag;
    //索引当前cell在TableView中的位置，有两个属性，一个是section，一个是row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    if ([_delegate respondsToSelector:@selector(collapseTable:didClickAtSectionIndex:)]) {
        [_delegate collapseTable:self didClickAtSectionIndex:section];
    }
    
    BOOL isOpen = [[[_innerDateArray objectAtIndex:section] objectForKey:@"isOpen"] boolValue];
    [[_innerDateArray objectAtIndex:section] setObject:[NSNumber numberWithBool:!isOpen] forKey:@"isOpen"];
    
    SCCollpaseTableHeaderArrow *arrow = nil;
    
    for (UIView *v in recognizer.view.subviews) {
        if ([v isKindOfClass:[SCCollpaseTableHeaderArrow class]]) {
            arrow = (SCCollpaseTableHeaderArrow *)v;
            break;
        }
    }
    
    UIView *line = [recognizer.view viewWithTag:section + 10000];
    
    if (isOpen) {
        if (line.tag - 10000 == (_numberOfSections - 1)) { // 如果为最后一个section的话，末尾的底线还是需要加上，不然最后一个section的底线就没有了
            [line setHidden:NO];
        } else {
            [line setHidden:YES];
        }
        
        if (arrow) {
            [UIView animateWithDuration:0.25f
                             animations:^{
                                 // Change Arrow orientation
                                 CGAffineTransform transform = CGAffineTransformMakeRotation(0);
                                 arrow.transform = transform;
                             }];
        }
        
        [_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)]; 
        
    }
    else{
        
        [line setHidden:NO];
        
        if (arrow) {
            [UIView animateWithDuration:0.25f
                             animations:^{
                                 // Change Arrow orientation
                                 CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 2);
                                 arrow.transform = transform;
                             }];
        }
        
        [_table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
    }
    
}

@end
