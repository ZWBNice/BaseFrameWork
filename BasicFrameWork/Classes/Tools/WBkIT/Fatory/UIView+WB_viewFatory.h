//
//  UIView+WB_viewFatory.h
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommonHeader.h"

@interface UIView (WB_viewFatory)

/**
 *  生产view frame
 *
 *  @param backgroundHexcolor 背景颜色 16进制
 *  @param frame              frame
 *  @param superView          父视图
 *
 *  @return UIView对象
 */
+ (instancetype) WB_fatoryViewWithBackColor:(UInt32)backgroundHexcolor
                                   WithFrame:(CGRect)frame
                                 toSuperView:(UIView *)superView;

/**
 *  生产view Masnory
 *
 *  @param constraints        约束
 *  @param backgroundHexcolor 背景颜色 16进制
 *  @param superView          父视图
 *
 *  @return UIView对象
 */
+ (instancetype)WB_fatoryViewWithConstraints:(WBConstraintMaker)constraints
                                WithBackColor:(UInt32)backgroundHexcolor
                                  toSuperView:(UIView *)superView;
@end
