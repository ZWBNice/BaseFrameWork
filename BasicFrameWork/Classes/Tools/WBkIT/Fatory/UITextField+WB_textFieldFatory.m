//
//  UITextField+WB_textFieldFatory.m
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UITextField+WB_textFieldFatory.h"

@implementation UITextField (WB_textFieldFatory)


+ (instancetype)WB_fatoryTextfieldWithFrame:(CGRect)frame
                                Withcontent:(NSString *)text
                            withPlaceHolder:(NSString *)placeHolder
                             withPlaceColor:(UInt32)placeHolderHexColor
                                 Withfont:(CGFloat)font
                             WithHexColor:(UInt32)texthexcolor
                                 delegate:(id<UITextFieldDelegate>)delegate
                              toSuperView:(UIView *)superView {
    
    UITextField *textfiled = [[UITextField alloc] initWithFrame:frame];
    [superView addSubview:textfiled];
    textfiled.placeholder = placeHolder;
    textfiled.font = [UIFont systemFontOfSize:font];
    textfiled.textColor = [UIColor colorWithRGBHex:texthexcolor alpha:1];
    [textfiled setValue:[UIColor colorWithRGBHex:placeHolderHexColor alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [textfiled setValue:[UIFont boldSystemFontOfSize:font] forKeyPath:@"_placeholderLabel.font"];
    textfiled.tintColor = [UIColor colorWithRGBHex:texthexcolor alpha:1];
    textfiled.delegate = delegate;
    
    return textfiled;
}


+ (instancetype)WB_fatoryTextfieldConstraints:(WBConstraintMaker)constraints
                                Withcontent:(NSString *)text
                            withPlaceHolder:(NSString *)placeHolder
                             withPlaceColor:(UInt32)placeHolderHexColor
                                   Withfont:(CGFloat)font
                               WithHexColor:(UInt32)texthexcolor
                                     delegate:(id<UITextFieldDelegate>)delegate
                                toSuperView:(UIView *)superView {
    
    UITextField *textfiled = [[UITextField alloc] initWithFrame:CGRectZero];
    [superView addSubview:textfiled];
    textfiled.placeholder = placeHolder;
    textfiled.font = [UIFont systemFontOfSize:font];
    textfiled.tintColor = [UIColor colorWithRGBHex:texthexcolor alpha:1];
    textfiled.textColor = [UIColor colorWithRGBHex:texthexcolor alpha:1];
    [textfiled setValue:[UIColor colorWithRGBHex:placeHolderHexColor alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [textfiled setValue:[UIFont boldSystemFontOfSize:font] forKeyPath:@"_placeholderLabel.font"];
    textfiled.delegate = delegate;
    if (superView && constraints) {
        [superView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return textfiled;
}


@end
