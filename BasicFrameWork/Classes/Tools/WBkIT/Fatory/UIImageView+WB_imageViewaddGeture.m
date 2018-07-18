//
//  UIImageView+WB_imageViewaddGeture.m
//  WBKIT
//
//  Created by 张文博 on 16/7/25.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UIImageView+WB_imageViewaddGeture.h"

static const void *wb_tapGestureKey = "wb_tapGestureKey";
static const void *wb_longGestureKey = "wb_longGestureKey";
#import <objc/runtime.h>

@implementation UIImageView (WB_imageViewaddGeture)

- (UITapGestureRecognizer *)wb_tapGesture {
    return objc_getAssociatedObject(self, &wb_tapGestureKey);

}

- (UILongPressGestureRecognizer *)wb_longGesture {
    
    return objc_getAssociatedObject(self, &wb_longGestureKey);
}


- (void)wb_addLongPressWithLongBlock:(LongPressBlock)longPressBlock{
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    longPress.longPressBlock = longPressBlock;
    [self addGestureRecognizer:longPress];
    objc_setAssociatedObject(self,
                             wb_longGestureKey,
                             longPress,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)wb_addtapGestureWithTapBlcok:(TapBlock)tapBlock{
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.tapBlock = tapBlock;
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, &wb_tapGestureKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

@end
