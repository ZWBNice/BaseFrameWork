//
//  UICollectionView+WB_collectionViewFatory.h
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCommonHeader.h"

@interface UICollectionView (WB_collectionViewFatory)

/**
 *  生产collection frame
 *
 *  @param frame     frame
 *  @param superView 父视图
 *  @param delegate  代理人
 *  @param layout    layout
 *
 *  @return UICollectionView 对象
 */
+ (instancetype)WB_fatoryCollectionWithFrame:(CGRect)frame
                                 toSuperView:(UIView *)superView
                                withDelegate:(id)delegate
                                  withlayout:(UICollectionViewLayout *)layout;


/**
 *  生产collection Masnory
 *
 *  @param frame     frame
 *  @param superView 父视图
 *  @param delegate  代理人
 *  @param layout    layout
 *
 *  @return UICollectionView 对象
 */
+ (instancetype)WB_fatoryCollectionWithConstraints:(WBConstraintMaker)constraints
                                       toSuperView:(UIView *)superView
                                      withDelegate:(id)delegate
                                        withlayout:(UICollectionViewLayout *)layout;

@end
