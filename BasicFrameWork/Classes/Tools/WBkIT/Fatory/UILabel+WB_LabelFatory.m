//
//  UILabel+WB_LabelFatory.m
//  WBKIT
//
//  Created by 张文博 on 16/7/20.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UILabel+WB_LabelFatory.h"


@implementation UILabel (WB_LabelFatory)

+ (instancetype)WB_fatoryLabelWithcontent:(NSString *)text
                               Withfont:(CGFloat)font
                           WithHexColor:(UInt32)texthexcolor
                              WithFrame:(CGRect)frame
                            toSuperView:(UIView *)superView{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [superView addSubview:label];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithRGBHex:texthexcolor alpha:1];
    return label;
}


+ (instancetype)WB_fatoryLabelWithConstraints:(WBConstraintMaker)constraints Withcontent:(NSString *)text Withfont:(CGFloat)font WithHexColor:(UInt32)texthexcolor  toSuperView:(UIView *)superView{
    UILabel *label = UILabel.new;
    [superView addSubview:label];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithRGBHex:texthexcolor alpha:1];
    
    if (superView && constraints) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    return label;
}



@end
