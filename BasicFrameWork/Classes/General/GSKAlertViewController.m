//
//  GSKAlertViewController.m
//  iGSK
//
//  Created by ifly on 2018/5/31.
//

#import "GSKAlertViewController.h"
#import "SVProgressHUD.h"
@interface GSKAlertViewController()

@end
static const NSTimeInterval minimumDismissTimeInterval = 2;

@implementation GSKAlertViewController

+ (void)setAlertWithTitle:(NSString *)title message:(NSString *)message confirmStr:(NSString *)confirmStr target:(UIViewController *)tagert complementBlock:(void(^)(void))complementBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (complementBlock) {
            complementBlock();
        }
        
    }];
    
    [alert addAction:confirmAction];
    [tagert presentViewController:alert animated:true completion:nil];
}


+ (void)createAlertWithTitle:(NSString *)title message:(NSString *)message tagert:(UIViewController *)tagert cancelButtonTitle:(NSString *)cancelButtonTitle complementBlock:(void(^)(NSInteger clickIndex))complementBlock otherButtonTitles:(NSString *)firstbtnTitle, ...NS_REQUIRES_NIL_TERMINATION{
    
    NSInteger clickindex = 0;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    NSLog(@"传多个参数的第一个参数 %@",firstbtnTitle);
    if(cancelButtonTitle != nil && ![cancelButtonTitle isEqualToString:@""]){
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if(complementBlock){
                complementBlock(-1);
            }
        }];
        [alert addAction:cancleAction];
    }

    UIAlertAction *tempAction = [UIAlertAction actionWithTitle:firstbtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(complementBlock){
            complementBlock(clickindex);
        }
    }];
    [alert addAction:tempAction];
    //1.定义一个指向个数可变的参数列表指针；
    // 用于存放取出的参数
    va_list args;
    // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
    va_start(args, firstbtnTitle);
    if (firstbtnTitle){
        while (YES)
        {
            NSString * otherString = va_arg(args, NSString *);
            if(otherString){
                clickindex += 1;
                UIAlertAction *tempAction = [UIAlertAction actionWithTitle:otherString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if(complementBlock){
                        complementBlock(clickindex);
                    }
                    
                }];
                [alert addAction:tempAction];

            }
            NSLog(@"otherString %@",otherString);
            if (!otherString) {
                break;
            }
        }
    }
    //结束可变参数的获取
    va_end(args);
    [tagert presentViewController:alert animated:true completion:nil];
    
}

+ (void)showSVProgressWithStatus:(NSString *)status{
    [SVProgressHUD showWithStatus:status];
}

+ (void)showSVProgressWithStatus:(NSString *)status withMaskType:(SVProgressHUDMaskType)type{
    [SVProgressHUD setDefaultMaskType:type];
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismissSVprogress{
    [SVProgressHUD dismiss];
}

+ (void)showSVProgressWithStatus:(NSString *)status withDismissTime:(NSTimeInterval)delay{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD dismissWithDelay:delay];
}

+ (void)showSuccessText:(NSString *)successText{
    [SVProgressHUD setMinimumDismissTimeInterval:minimumDismissTimeInterval];
    [SVProgressHUD showSuccessWithStatus:successText];
    
}

+ (void)showErrorText:(NSString *)errorText{
    [SVProgressHUD setMinimumDismissTimeInterval:minimumDismissTimeInterval];
    [SVProgressHUD showErrorWithStatus:errorText];
}

@end
