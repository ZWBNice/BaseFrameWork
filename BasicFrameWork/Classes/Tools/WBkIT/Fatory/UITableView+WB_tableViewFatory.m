//
//  UITableView+WB_tableViewFatory.m
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UITableView+WB_tableViewFatory.h"
#import "UIView+nextRespond.h"

@implementation UITableView (WB_tableViewFatory)

+ (instancetype)WB_fatoryTableWithFrame:(CGRect)frame
                         withtableStyle:(UITableViewStyle)style
                            toSuperView:(UIView *)superView
                           withDelegate:(id)delegate{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    [superView addSubview:tableView];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}

+ (instancetype)WB_fatoryTableWithConstraints:(WBConstraintMaker)constraints
                         withtableStyle:(UITableViewStyle)style
                            toSuperView:(UIView *)superView
                           withDelegate:(id)delegate{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    [superView addSubview:tableView];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    
    if (superView && constraints) {
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return tableView;

}

@end
