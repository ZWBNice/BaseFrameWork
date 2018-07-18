//
//  UIImage+WBreduceImage.h
//  LeKuProject
//
//  Created by 张文博 on 16/6/24.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WBreduceImage)

/**
 *  减小图片的体积，文件体积变小，但是像素数不变，长宽尺寸不变，那么质量可能下降
 *
 *  @param image   要压缩的UIimage
 *  @param percent 压缩的系数0.3~0.7之间比较好
 *
 *  @return 新的UIImage
 */
+ (UIImage *)reduceImage:(UIImage *)image  percent:(CGFloat)percent;


/**
 *  文件的尺寸变小，也就是像素数减少，而长宽尺寸变小，文件体积同样会减小。
 *
 *  @param image   要压缩的UIimage
 *  @param percent 压缩的系数0.3~0.7之间比较好
 *
 *  @return 新的UIImage 的data类型
 */
+ (NSData *)reduceImageData:(UIImage *)image  percent:(CGFloat)percent;



/**
 *  等比例缩小图片
 *
 *  @param sourceImage 要缩小的图片，原图
 *  @param targetWidth 宽度
 *
 *  @return 新的UIImage对象
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;



@end
