//
//  UIGestureRecognizer+WB_gestyre.m
//  WBKIT
//
//  Created by 张文博 on 16/7/22.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UIGestureRecognizer+WB_gestyre.h"
#import <objc/runtime.h>

static const void *wb_tapBlcokkey = "wb_tapBlcokkey";
static const void *wb_longPressBlcokkey = "wb_longPressBlcokkey";


@implementation UIGestureRecognizer (WB_gestyre)
- (TapBlock)tapBlock{
    
    return objc_getAssociatedObject(self, &wb_tapBlcokkey);
}

- (void)setTapBlock:(TapBlock)tapBlock{
    
    objc_setAssociatedObject(self, &wb_tapBlcokkey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(WB_private_tapGesture:)];
    
    if (tapBlock) {
        [self addTarget:self action:@selector(WB_private_tapGesture:)];
    }

}


- (void)WB_private_tapGesture:(UITapGestureRecognizer *)tap {
    
    TapBlock tapblock = self.tapBlock;
    tapblock(tap);
    
}


- (LongPressBlock)longPressBlock{
    
    return objc_getAssociatedObject(self, &wb_longPressBlcokkey);
}

- (void)setLongPressBlock:(LongPressBlock)longPressBlock {
    objc_setAssociatedObject(self, &wb_longPressBlcokkey, longPressBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(WB_private_LongpressGesture:)];
    
    if (longPressBlock) {
        [self addTarget:self action:@selector(WB_private_LongpressGesture:)];
    }
}

- (void)WB_private_LongpressGesture:(UILongPressGestureRecognizer *)longpress {
    
    LongPressBlock longblock = self.longPressBlock;
    longblock(longpress);
}


@end
