//
//  UIButton+WB_buttonFatory.h
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommonHeader.h"

typedef void (^btnBlock)(id sender);

@interface UIButton (WB_buttonFatory)

@property (nonatomic, copy) btnBlock blcok;

/**
 *  生产button frame
 *
 *  @param frame         frame
 *  @param title         标题
 *  @param titleHexColor 标题颜色
 *  @param font          标题字体大小
 *  @param image         normalImage （id）可以传 uiimage 也可以传图片名字
 *  @param selImage      seleted （id）可以传 uiimage 也可以传图片名字
 *  @param superView     父视图
 *  @param block         touchup 绑定block
 *  @return UIbutton对象
 */
+ (instancetype)WB_fatoryButtonWithFrame:(CGRect)frame
                               WithTitle:(NSString *)title
                          WithTitleColor:(UInt32)titleHexColor
                                Withfont:(CGFloat)font
                               Withimage:(id)image
                            WithselImage:(id)selImage
                             toSuperView:(UIView *)superView
                               WithClick:(btnBlock)block;

/**
 *  生产button Masnory
 *
 *  @param constraints   约束
 *  @param block         touchup 绑定block
 *  @param title         标题
 *  @param titleHexColor 标题颜色
 *  @param font          字体
 *  @param image         normol
 *  @param selImage      seleted
 *  @param superView     父视图
 *
 *  @return UIbutton对象
 */
+ (instancetype)WB_fatoryButtonConstraints:(WBConstraintMaker)constraints
                                 WithClick:(btnBlock)block
                                 WithTitle:(NSString *)title
                            WithTitleColor:(UInt32)titleHexColor
                                  Withfont:(CGFloat)font
                                 Withimage:(id)image
                              WithselImage:(id)selImage
                               toSuperView:(UIView *)superView;
@end
