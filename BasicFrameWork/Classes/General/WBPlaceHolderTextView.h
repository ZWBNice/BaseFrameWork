//
//  WBPlaceHolderTextView.h
//  breathPatientApp
//
//  Created by ifly on 2018/7/27.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBPlaceHolderTextView : UITextView<UITextViewDelegate>
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 最多输入多少文字 */
@property (nonatomic, assign) NSInteger maxLength;

@end
