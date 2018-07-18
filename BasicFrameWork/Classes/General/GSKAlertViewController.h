//
//  GSKAlertViewController.h
//  iGSK
//
//  Created by ifly on 2018/5/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GSKAlertViewController : NSObject

/**
 创建一个alert
 @param title 标题
 @param message 信息
 @param confirmStr 确定的字符串
 @param tagert viewcontroller
 @param complementBlock 确定的回调
 */
+ (void)setAlertWithTitle:(NSString *)title message:(NSString *)message confirmStr:(NSString *)confirmStr target:(UIViewController *)tagert complementBlock:(void(^)(void))complementBlock;


+ (void)createAlertWithTitle:(NSString *)title message:(NSString *)message tagert:(UIViewController *)tagert cancelButtonTitle:(NSString *)cancelButtonTitle complementBlock:(void(^)(NSInteger clickIndex))complementBlock otherButtonTitles:(NSString *)firstbtnTitle, ...NS_REQUIRES_NIL_TERMINATION;

+ (void)showSVProgressWithStatus:(NSString *)status;

+ (void)dismissSVprogress;

+ (void)showSVProgressWithStatus:(NSString *)status withDismissTime:(NSTimeInterval)delay;

+ (void)showSuccessText:(NSString *)successText;

@end
