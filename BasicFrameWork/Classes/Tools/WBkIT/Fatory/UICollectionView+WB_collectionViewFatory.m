//
//  UICollectionView+WB_collectionViewFatory.m
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "UICollectionView+WB_collectionViewFatory.h"

@implementation UICollectionView (WB_collectionViewFatory)


+ (instancetype)WB_fatoryCollectionWithFrame:(CGRect)frame
                            toSuperView:(UIView *)superView
                           withDelegate:(id)delegate
                             withlayout:(UICollectionViewLayout *)layout{
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [superView addSubview:collection];
    collection.delegate = delegate;
    collection.dataSource = delegate;
    return collection;
}

+ (instancetype)WB_fatoryCollectionWithConstraints:(WBConstraintMaker)constraints
                                  toSuperView:(UIView *)superView
                                 withDelegate:(id)delegate
                                   withlayout:(UICollectionViewLayout *)layout{
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [superView addSubview:collection];
    collection.delegate = delegate;
    collection.dataSource = delegate;
    
    if (superView && constraints) {
        [collection mas_makeConstraints:^(MASConstraintMaker *make) {
            
            constraints(make);
            
        }];
    }
    
    return collection;
    
}


@end
