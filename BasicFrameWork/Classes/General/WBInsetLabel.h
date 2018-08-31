//
//  WBInsetLabel.h
//  breathPatientApp
//
//  Created by ifly on 2018/8/30.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBInsetLabel : UILabel
// MARK: - 设置内边距 默认UIEdgeInsetsMake(10, 10, 10, 10)
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@end
