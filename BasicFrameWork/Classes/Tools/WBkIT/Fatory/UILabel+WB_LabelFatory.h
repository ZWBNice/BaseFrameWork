//
//  UILabel+WB_LabelFatory.h
//  WBKIT
//
//  Created by 张文博 on 16/7/20.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommonHeader.h"
@interface UILabel (WB_LabelFatory)

/**
 *  创建label frame
 *
 *  @param text         文字
 *  @param font         字体
 *  @param texthexcolor 字体颜色
 *  @param frame        frame
 *  @param superView    父视图
 *
 *  @return UILabel 对象
 */
+ (instancetype)WB_fatoryLabelWithcontent:(NSString *)text
                                  Withfont:(CGFloat)font
                              WithHexColor:(UInt32)texthexcolor
                                 WithFrame:(CGRect)frame
                               toSuperView:(UIView *)superView;


/**
 *  创建label masnory
 *
 *  @param constraints  约束
 *  @param text         文字
 *  @param font         字体
 *  @param texthexcolor 字体颜色
 *  @param superView    父视图
 *
 *  @return UILabel对象
 */
+ (instancetype)WB_fatoryLabelWithConstraints:(WBConstraintMaker)constraints
                                   Withcontent:(NSString *)text
                                      Withfont:(CGFloat)font
                                  WithHexColor:(UInt32)texthexcolor
                                   toSuperView:(UIView *)superView;





@end
