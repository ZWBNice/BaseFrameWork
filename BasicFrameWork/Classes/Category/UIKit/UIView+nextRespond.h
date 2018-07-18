//
//  UIView+nextRespond.h
//  MyProject
//
//  Created by 张文博 on 16/1/7.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (nextRespond)
- (UIViewController *)viewController;

// 获取模态出来的控制器

- (UIViewController *)getPresentedViewController;

// 不论view在哪里都能拿到当前的控制器

+ (UIViewController *)currentViewController;
@end
