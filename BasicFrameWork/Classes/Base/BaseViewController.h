//
//  BaseViewController.h
//  MyProject
//
//  Created by 张文博 on 16/1/7.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBBaseEmptyView;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) WBBaseEmptyView *emptyView;
@property (nonatomic, strong) WBBaseEmptyView *noNetWorkView;

@property (nonatomic, strong) UIBarButtonItem *rightBarButton;
@property (nonatomic, strong) UIBarButtonItem *leftBarButton;

- (void)isHiddenNavgation:(BOOL)isHidden animated:(BOOL)animated;


@end
