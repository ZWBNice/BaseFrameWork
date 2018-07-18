//
//  UITableViewCell+WB_cellSparator.h
//  LifeCool
//
//  Created by 张文博 on 16/9/2.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WBSeparatorStyle) {
    WBSeparatorStyleNone = 0,   // 无
    WBSeparatorStyleFull,       // 满行
    WBSeparatorStyleCenter,     // 两边留出间距
    WBSeparatorStyleLeftMargin, // 左边留出间距
    WBSeparatorStyleRightMargin,// 右边留出间距
};


@interface UITableViewCell (WB_cellSparator)
/**
 *   分割线风格
 */
@property (nonatomic, assign) WBSeparatorStyle wb_separatorStyle;

/**
 *  两边等间距
 */
@property (nonatomic, assign) CGFloat wb_separatorCenterMargin;

/**
 *  左边间距
 */
@property (nonatomic, assign) CGFloat wb_separatorLeftMargin;

/**
 *  右边间距
 */
@property (nonatomic, assign) CGFloat wb_separatorRightMargin;


@end
