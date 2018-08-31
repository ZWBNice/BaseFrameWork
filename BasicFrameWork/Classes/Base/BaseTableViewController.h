//
//  BaseTableViewController.h
//  ProjectFramework
//
//  Created by zwb on 2018/1/17.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "BaseViewController.h"
/** @brief 带加载、刷新的Controller(包含UITableView) */

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


// table
@property (nonatomic, strong) UITableView *tableView;
// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
// 当前加载的页数
@property (nonatomic, assign) int page;
// 是否启用下拉刷新
@property (nonatomic, assign) BOOL showRefreshHeader;
// 是否启用下拉加载更多
@property (nonatomic, assign) BOOL showRefreshFooter;
// 是否显示无数据时的空白提示，默认为NO
@property (nonatomic, assign) BOOL showTableBlankView;

/** @brief 默认的tableFooterView */
@property (strong, nonatomic) UIView *defaultFooterView;

/*!
 @method
 @brief 下拉加载更多(下拉刷新)
 */
- (void)tableViewDidTriggerHeaderRefresh;

/*!
 @method
 @brief 上拉加载更多
 */
- (void)tableViewDidTriggerFooterRefresh;

/*!
 @method
 @brief 加载结束
 @discussion 加载结束后，通过参数reload来判断是否需要调用tableView的reloadData，判断isHeader来停止加载
 @param isHeader   是否结束下拉加载(或者上拉加载)
 @param reload     是否需要重载TabeleView
 */
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

/*!
 @method
 @brief 初始化ViewController
 @param style   tableView样式
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

/*!
 @method
 @brief 设置tableView的frame
 */

- (void)setTableViewFrame:(CGRect)frame;



@end

