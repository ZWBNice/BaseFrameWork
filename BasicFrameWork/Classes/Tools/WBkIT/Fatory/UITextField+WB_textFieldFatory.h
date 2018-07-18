//
//  UITextField+WB_textFieldFatory.h
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBCommonHeader.h"


@interface UITextField (WB_textFieldFatory)

/**
 *  生产texFiled frame
 *
 *  @param frame               frame
 *  @param text                内容
 *  @param placeHolder         placeHolder description
 *  @param placeHolderHexColor placeHolderHexColor description
 *  @param font                font description
 *  @param texthexcolor        texthexcolor description
 *  @param superView           superView description
 *
 *  @return UITextFiled对象
 */
+ (instancetype)WB_fatoryTextfieldWithFrame:(CGRect)frame
                                Withcontent:(NSString *)text
                            withPlaceHolder:(NSString *)placeHolder
                             withPlaceColor:(UInt32)placeHolderHexColor
                                   Withfont:(CGFloat)font
                               WithHexColor:(UInt32)texthexcolor
                                   delegate:(id<UITextFieldDelegate>)delegate
                                toSuperView:(UIView *)superView;

/**
 *  生产textFiled Masonry
 *
 *  @param constraints         约束
 *  @param text                内容
 *  @param placeHolder         placeHolder description
 *  @param placeHolderHexColor placeHolderHexColor description
 *  @param font                font description
 *  @param texthexcolor        texthexcolor description
 *  @param superView           superView description
 *
 *  @return UITextFiled对象
 */
+ (instancetype)WB_fatoryTextfieldConstraints:(WBConstraintMaker)constraints
                                  Withcontent:(NSString *)text
                              withPlaceHolder:(NSString *)placeHolder
                               withPlaceColor:(UInt32)placeHolderHexColor
                                     Withfont:(CGFloat)font
                                 WithHexColor:(UInt32)texthexcolor
                                     delegate:(id<UITextFieldDelegate>)delegate
                                  toSuperView:(UIView *)superView;


@end
