//
//  UIButton+WB_buttonFatory.m
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UIButton+WB_buttonFatory.h"
#import <objc/runtime.h>

// 设置
static const char associatedButtonkey;

@implementation UIButton (WB_buttonFatory)

- (void)setBlcok:(btnBlock)blcok{
    
    objc_setAssociatedObject(self, &associatedButtonkey, blcok, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self
                action:@selector(btnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    if (blcok) {
        [self addTarget:self
                 action:@selector(btnAction:)
       forControlEvents:UIControlEventTouchUpInside];
    }

}

- (btnBlock)blcok{
    
    return objc_getAssociatedObject(self, &associatedButtonkey);
}

+ (instancetype)WB_fatoryButtonWithFrame:(CGRect)frame
                               WithTitle:(NSString *)title
                          WithTitleColor:(UInt32)titleHexColor
                                 Withfont:(CGFloat)font
                                Withimage:(id)image
                            WithselImage:(id)selImage
                             toSuperView:(UIView *)superView
                               WithClick:(btnBlock)block{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [superView addSubview:btn];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:[UIColor colorWithRGBHex:titleHexColor alpha:1] forState:UIControlStateNormal];
    if (!kIsEmptyString(title)) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    UIImage *normalImage = nil;
    if ([image isKindOfClass:[NSString class]]) {
        normalImage = kImage(image);
    } else if ([image isKindOfClass:[UIImage class]]) {
        normalImage = image;
    }
    
    UIImage *selectedImage = nil;
    if ([selImage isKindOfClass:[NSString class]]) {
        selectedImage = kImage(selImage);
    } else if ([selImage isKindOfClass:[UIImage class]]) {
        selectedImage = selImage;
    }
    
    if (normalImage) {
        [btn setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    
    if (block)
    {
        btn.blcok = block;
    }
    return btn;
}

- (void)btnAction:(id)sender{
    
    self.blcok(sender);

}


+ (instancetype)WB_fatoryButtonConstraints:(WBConstraintMaker)constraints
                                 WithClick:(btnBlock)block
                               WithTitle:(NSString *)title
                          WithTitleColor:(UInt32)titleHexColor
                                Withfont:(CGFloat)font
                               Withimage:(id)image
                            WithselImage:(id)selImage
                             toSuperView:(UIView *)superView{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    [superView addSubview:btn];

    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:[UIColor colorWithRGBHex:titleHexColor alpha:1] forState:UIControlStateNormal];
    if (!kIsEmptyString(title)) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    UIImage *normalImage = nil;
    if ([image isKindOfClass:[NSString class]]) {
        normalImage = kImage(image);
    } else if ([image isKindOfClass:[UIImage class]]) {
        normalImage = image;
    }
    
    UIImage *selectedImage = nil;
    if ([selImage isKindOfClass:[NSString class]]) {
        selectedImage = kImage(selImage);
    } else if ([selImage isKindOfClass:[UIImage class]]) {
        selectedImage = selImage;
    }
    
    if (normalImage) {
        [btn setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    
    if (constraints && superView) {
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    if (block)
    {
        btn.blcok = block;
    }
    return btn;

}


@end
