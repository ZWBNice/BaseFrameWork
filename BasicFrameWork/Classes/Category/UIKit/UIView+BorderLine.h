//
//  UIView+BorderLine.h
//  imagePick
//
//  Created by ifly on 2018/5/24.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (BorderLine)


/**
 给view添加单独的边框

 @param color 边框颜色
 @param borderWidth 边框宽度
 @param borderType 给哪条边添加边框
 @return self
 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;


/**
 给view添加圆角

 @param borderColor 边款颜色
 @param borderWidth 边框宽度
 @param radius 圆角
 */
- (void)setBorderColor:(UIColor *)borderColor WithBorderWith:(CGFloat)borderWidth WithBorderRadius:(CGFloat)radius;


/**
 给view添加阴影
注意阴影是加在父视图的sublayer上的 防止设置圆角的时候不生效
 @param superView 父视图
 @param shadowColor 阴影颜色
 @param shadowRadius 阴影圆角
 @param shadowOffset 阴影的偏移
 */
- (void)addShadowTosuperview:(UIView *)superView WithShadowColor:(UIColor *)shadowColor withShadowRadius:(CGFloat)shadowRadius WithshadowOffset:(CGSize)shadowOffset;


/**
 给view添加渐变色背景
 startPoint&endPoint    颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
 @param startPoint 开始的坐标点
 @param endPoint 结束的坐标点
 @param startColor 开始渐变的颜色
 @param endColor 结束渐变的颜色
 */
- (void)addGradientLayerWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor;




/**
 在viewlayer上添加一条虚线
 
 @param dottePathColor 虚线的颜色
 @param linewidth 每一段的线的宽度
 @param linelength 每一段线的长度
 @param spacing 虚线的间距
 @param startPoint 开始点的坐标
 @param endPoint 结束点的坐标
 */
- (void)addDotteShapePathWithDottePathColor:(UIColor *)dottePathColor linewidth:(CGFloat)linewidth linelength:(CGFloat)linelength linespacing:(CGFloat)spacing startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


/**
 在viewlayer上添加一条直线

 @param lineColor 线的颜色
 @param startPoint 开始坐标
 @param endPoint 结束坐标
 */
- (void)addLineWithColor:(UIColor *)lineColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
