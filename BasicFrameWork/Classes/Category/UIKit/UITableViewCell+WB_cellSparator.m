//
//  UITableViewCell+WB_cellSparator.m
//  LifeCool
//
//  Created by 张文博 on 16/9/2.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UITableViewCell+WB_cellSparator.h"
#import <objc/runtime.h>

static const char kJXSeparatorMarginKey = '\0';
static const char kJXSeparatorLeftMarginKey = '\0';
static const char kJXSeparatorRightMarginKey = '\0';
static const char kJXSeparatorStyleKey = '\0';


@implementation UITableViewCell (WB_cellSparator)

#pragma 左间距
- (CGFloat)wb_separatorLeftMargin {
    NSNumber *leftMargin = objc_getAssociatedObject(self, &kJXSeparatorLeftMarginKey);
    return leftMargin ? [leftMargin floatValue] : 0;
}


- (void)setWb_separatorLeftMargin:(CGFloat)wb_separatorLeftMargin{
    objc_setAssociatedObject(self, &kJXSeparatorLeftMarginKey, @(wb_separatorLeftMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

#pragma 右间距
- (CGFloat)wb_separatorRightMargin {
    NSNumber *rightMargin = objc_getAssociatedObject(self, &kJXSeparatorRightMarginKey);
    return rightMargin ? [rightMargin floatValue] : 0;
}

- (void)setWb_separatorRightMargin:(CGFloat)wb_separatorRightMargin {
    objc_setAssociatedObject(self, &kJXSeparatorRightMarginKey, @(wb_separatorRightMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma 两边间距
- (CGFloat)wb_separatorCenterMargin {
    NSNumber *margin = objc_getAssociatedObject(self, &kJXSeparatorMarginKey);
    return margin ? [margin floatValue] : 0;
}

- (void)setWb_separatorCenterMargin:(CGFloat)wb_separatorCenterMargin {
    objc_setAssociatedObject(self, &kJXSeparatorMarginKey, @(wb_separatorCenterMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 风格
- (WBSeparatorStyle)wb_separatorStyle {
    NSNumber *style = objc_getAssociatedObject(self, &kJXSeparatorStyleKey);
    return style ? [style integerValue] : 0;
}

- (void)setWb_separatorStyle:(WBSeparatorStyle)wb_separatorStyle {
    objc_setAssociatedObject(self, &kJXSeparatorStyleKey, @(wb_separatorStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([[UIDevice currentDevice].systemVersion compare:@"8.0"] != NSOrderedAscending) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;
    }
    
    switch (wb_separatorStyle) {
        case WBSeparatorStyleNone:
            self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width);
            break;
        case WBSeparatorStyleFull:
            self.separatorInset = UIEdgeInsetsZero;
            break;
        case WBSeparatorStyleLeftMargin:
            self.separatorInset = UIEdgeInsetsMake(0, self.wb_separatorLeftMargin, 0, 0);
            break;
        case WBSeparatorStyleRightMargin:
            self.separatorInset = UIEdgeInsetsMake(0, 0, 0, self.wb_separatorRightMargin);
            break;
        case WBSeparatorStyleCenter:
            self.separatorInset = UIEdgeInsetsMake(0, self.wb_separatorCenterMargin, 0, self.wb_separatorCenterMargin);
            break;
        default:
            break;
    }
}



@end
