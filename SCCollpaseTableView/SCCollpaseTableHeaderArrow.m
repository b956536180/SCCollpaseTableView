//
//  SCCollpaseTableHeaderArrow.m
//  20140318_CollapaseTabelView
//
//  Created by Xiao on 14-3-18.
//  Copyright (c) 2014年 ZhangXueFei. All rights reserved.
//

#import "SCCollpaseTableHeaderArrow.h"

@implementation SCCollpaseTableHeaderArrow

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    [_arrowColor setFill];
    [arrow moveToPoint:CGPointMake(self.frame.size.width, self.frame.size.height / 2)];
    [arrow addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [arrow addLineToPoint:CGPointMake(0, 0)];
    [arrow addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height / 2)];
    [arrow fill];
}


- (void)drawWithColor:(UIColor *)color {
    self.arrowColor = color;
    [self setNeedsDisplay];
}

- (void)_initData {
	// TODO: init data code
    self.arrowColor = [UIColor grayColor];
    [self setBackgroundColor:[UIColor clearColor]];
}
@end
