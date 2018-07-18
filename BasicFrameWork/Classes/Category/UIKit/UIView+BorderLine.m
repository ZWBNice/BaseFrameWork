//
//  UIView+BorderLine.m
//  imagePick
//
//  Created by ifly on 2018/5/24.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "UIView+BorderLine.h"

@implementation UIView (BorderLine)
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    
    
    /// 左侧
    if (borderType & UIBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// 右侧
    if (borderType & UIBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}


- (void)setBorderColor:(UIColor *)borderColor WithBorderWith:(CGFloat)borderWidth WithBorderRadius:(CGFloat)radius{
        //设置layer
        CALayer *layer=[self layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius:radius];
        //设置边框线的宽
        [layer setBorderWidth:borderWidth];
//    layer.shadowColor=[UIColor blackColor].CGColor;
//    layer.shadowOffset=CGSizeMake(5, 5);
//    layer.shadowOpacity=0.5;
//    layer.shadowRadius=5;
        //设置边框线的颜色
    if (borderColor == nil) {
        borderColor = [UIColor clearColor];
    }
        [layer setBorderColor:[borderColor CGColor]];
}


- (void)addShadowTosuperview:(UIView *)superView WithShadowColor:(UIColor *)shadowColor withShadowRadius:(CGFloat)shadowRadius WithshadowOffset:(CGSize)shadowOffset{
    CALayer *shadowLayer = [[CALayer alloc] init];
    shadowLayer.frame = self.frame;
    shadowLayer.shadowColor = shadowColor.CGColor;
    shadowLayer.shadowOffset = shadowOffset;
    shadowLayer.shadowOpacity = 1;
    shadowLayer.backgroundColor=[shadowColor colorWithAlphaComponent:0.8].CGColor;
    shadowLayer.shadowRadius = shadowRadius;
    shadowLayer.cornerRadius = shadowRadius;
    shadowLayer.masksToBounds = NO;
    [superView.layer insertSublayer:shadowLayer below:self.layer];
    
}

- (void)addGradientLayerWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer insertSublayer:gradientLayer atIndex:0];
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,
                             (__bridge id)endColor.CGColor];
    //设置颜色分割点（范围：0-1）
    //    gradientLayer.locations = @[@(0.5f), @(1.0f)];

}


// MARK: - 绘制虚线
- (void)addDotteShapePathWithDottePathColor:(UIColor *)dottePathColor linewidth:(CGFloat)linewidth linelength:(CGFloat)linelength linespacing:(CGFloat)spacing startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色为blackColor
    [dotteShapeLayer setStrokeColor:[[UIColor orangeColor] CGColor]];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = linewidth ;
    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:linelength],[NSNumber numberWithFloat:spacing], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, startPoint.x ,startPoint.y);
    CGPathAddLineToPoint(dotteShapePath, NULL, endPoint.x, endPoint.y);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    //把绘制好的虚线添加上来
    [self.layer addSublayer:dotteShapeLayer];

}


- (void)addLineWithColor:(UIColor *)lineColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAShapeLayer *lineShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef lineShapePath =  CGPathCreateMutable();
    [lineShapeLayer setStrokeColor:[lineColor CGColor]];
    lineShapeLayer.lineWidth = 1;
    CGPathMoveToPoint(lineShapePath, NULL, startPoint.x ,startPoint.y);
    CGPathAddLineToPoint(lineShapePath, NULL, endPoint.x, endPoint.y);
    [lineShapeLayer setPath:lineShapePath];
    CGPathRelease(lineShapePath);
    [self.layer addSublayer:lineShapeLayer];
    
}

@end
