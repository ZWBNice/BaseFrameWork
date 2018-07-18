//
//  UIImageView+WB_factoryImageView.m
//  WBKIT
//
//  Created by 张文博 on 16/7/22.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UIImageView+WB_factoryImageView.h"
#import "UIImage+WB_CircleImage.h"

@implementation UIImageView (WB_factoryImageView)

+ (instancetype)WB_fatoryImageViewWithFrame:(CGRect)frame
                           WithBackHexColor:(UInt32)backHexColor
                                  WithImage:(id)image
                                toSuperView:(UIView *)superView
                                    isCirce:(BOOL)isCirce{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [superView addSubview:imageView];
    if (backHexColor ) {
        imageView.backgroundColor = [UIColor colorWithRGBHex:backHexColor alpha:1];
    }

    if (image != nil) {
        if ([image isKindOfClass:[NSString class]]) {
            UIImage *image1 = kImage(image);
            imageView.image = [image1 wb_circleImage];
        } else {
            imageView.image = [image wb_circleImage];
        }
    }
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    return imageView;
}

+ (instancetype)WB_fatoryImageViewConstraints:(WBConstraintMaker)constraints
                               WithBackHexColor:(UInt32)backHexColor
                                  WithImage:(id)image
                                  toSuperView:(UIView *)superView                                     isCirce:(BOOL)isCirce {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [superView addSubview:imageView];
    if (image != nil) {
        if ([image isKindOfClass:[NSString class]]) {
            UIImage *image1 = kImage(image);

            imageView.image = [image1 wb_circleImage];
        } else {
            imageView.image = [image wb_circleImage];
        }
    }
    if (backHexColor ) {
        imageView.backgroundColor = [UIColor colorWithRGBHex:backHexColor alpha:1];
    }

    
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    if (superView && constraints) {
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            constraints(make);
        }];
        
    }
    
    return imageView;
}





@end
