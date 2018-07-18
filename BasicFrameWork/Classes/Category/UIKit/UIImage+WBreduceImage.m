//
//  UIImage+WBreduceImage.m
//  LeKuProject
//
//  Created by 张文博 on 16/6/24.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "UIImage+WBreduceImage.h"

@implementation UIImage (WBreduceImage)


+ (UIImage *)reduceImage:(UIImage *)image  percent:(CGFloat)percent {
    NSData *data = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:data];
    return newImage;
}

+ (NSData *)reduceImageData:(UIImage *)image  percent:(CGFloat)percent {
    NSData *data = UIImageJPEGRepresentation(image, percent);
    return data;
}


+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
