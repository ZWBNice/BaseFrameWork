//
//  UITableView+WB_tableViewFatory.h
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommonHeader.h"

@interface UITableView (WB_tableViewFatory)

/**
 *  生产table frame
 *
 *  @param frame     frame
 *  @param style     样式
 *  @param superView 父视图
 *  @param delegate  代理人
 *
 *  @return UItableview 对象
 */
+ (instancetype)WB_fatoryTableWithFrame:(CGRect)frame
                         withtableStyle:(UITableViewStyle)style
                            toSuperView:(UIView *)superView
                           withDelegate:(id)delegate;

/**
 *  生产table Masnory
 *
 *  @param constraints 约束
 *  @param style       样式
 *  @param superView   父视图
 *  @param delegate    代理人
 *
 *  @return UItableView对象
 */
+ (instancetype)WB_fatoryTableWithConstraints:(WBConstraintMaker)constraints
                               withtableStyle:(UITableViewStyle)style
                                  toSuperView:(UIView *)superView
                                 withDelegate:(id)delegate;

@end
