//
//  UIView+WB_ViewaddGesture.m
//  WBKIT
//
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UIView+WB_ViewaddGesture.h"
//#import <objc/objc-runtime.h>
//#import <objc/NSObjCRuntime.h>
#import <objc/runtime.h>

static const void *wb_tapGestureKey = "wb_tapGestureKey";
static const void *wb_longGestureKey = "wb_longGestureKey";

@implementation UIView (WB_ViewaddGesture)

- (UITapGestureRecognizer *)wb_tapGesture{
    
   return objc_getAssociatedObject(self, &wb_tapGestureKey);
}

- (UILongPressGestureRecognizer *)wb_longGesture {
    
    return objc_getAssociatedObject(self, &wb_longGestureKey);

}

- (void)wb_addtapGestureWithTapBlcok:(TapBlock)tapBlock {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.tapBlock = tapBlock;
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self,
                             wb_tapGestureKey,
                             tap,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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


@end
