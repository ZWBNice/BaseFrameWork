//
//  UIImageView+WB_factoryImageView.h
//  WBKIT
//
//  Created by 张文博 on 16/7/22.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommonHeader.h"

@interface UIImageView (WB_factoryImageView)

/**
 *  生产imageView frame
 *
 *  @param frame        frame
 *  @param backHexColor 背景颜色
 *  @param image        图片
 *  @param superView    父视图
 *
 *  @return UIImageView对象
 */
+ (instancetype)WB_fatoryImageViewWithFrame:(CGRect)frame
                           WithBackHexColor:(UInt32)backHexColor
                                  WithImage:(id)image
                                toSuperView:(UIView *)superView
                                    isCirce:(BOOL)isCirce;

/**
 *  生产imageView Masnory
 *
 *  @param constraints  约束
 *  @param backHexColor 背景颜色
 *  @param image        图片
 *  @param superView    父视图
 *
 *  @return UIImageView对象
 */
+ (instancetype)WB_fatoryImageViewConstraints:(WBConstraintMaker)constraints
                             WithBackHexColor:(UInt32)backHexColor
                                    WithImage:(id)image
                                  toSuperView:(UIView *)superView                                     isCirce:(BOOL)isCirce;

@end
