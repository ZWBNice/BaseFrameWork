//
//  UIView+WB_ViewaddGesture.h
//  WBKIT
//
//  Created by 张文博 on 16/7/22.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGestureRecognizer+WB_gestyre.h"

@interface UIView (WB_ViewaddGesture)

@property (nonatomic, strong,readonly) UITapGestureRecognizer *wb_tapGesture;

@property (nonatomic, strong,readonly) UILongPressGestureRecognizer *wb_longGesture;

/**
 *  添加点击手势
 *
 *  @param tapBlock 回调
 */
- (void)wb_addtapGestureWithTapBlcok:(TapBlock)tapBlock;

/**
 *  添加长按手势
 *
 *  @param longPressBlock 回调
 */
- (void)wb_addLongPressWithLongBlock:(LongPressBlock)longPressBlock;



@end
