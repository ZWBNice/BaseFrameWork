//
//  UIView+WB_viewFatory.m
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UIView+WB_viewFatory.h"

@implementation UIView (WB_viewFatory)

+ (instancetype) WB_fatoryViewWithBackColor:(UInt32)backgroundHexcolor
                                   WithFrame:(CGRect)frame
                                 toSuperView:(UIView *)superView{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [superView addSubview:view];
    view.backgroundColor = [UIColor colorWithRGBHex:backgroundHexcolor alpha:1];
    return view;
    
}

+ (instancetype)WB_fatoryViewWithConstraints:(WBConstraintMaker)constraints
                                WithBackColor:(UInt32)backgroundHexcolor
                                  toSuperView:(UIView *)superView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [superView addSubview:view];
    view.backgroundColor = [UIColor colorWithRGBHex:backgroundHexcolor alpha:1];
    if (superView && constraints) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    return view;
}


@end
