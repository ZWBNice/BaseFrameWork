//
//  CustomTabBarController.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/10.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "CustomTabBarController.h"
#import "ViewController.h"
#import "BasenavgationController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *controllers = @[@"ViewController",@"ViewController",@"ViewController",@"ViewController"];
    NSArray *titles = @[LocalizableText(@"tab_home"),LocalizableText(@"tab_dr"),LocalizableText(@"tab_rec"),LocalizableText(@"tab_data")];
    NSArray *normalImages = @[@"tab_home_normal",@"tab_doc_normal",@"tab_record_normal",@"Tab Doc sel-1"];
    NSArray *seletedImages = @[@"Tab Home sel",@"Tab Doc sel",@"Tab Record sel",@"Home Data sel"];
    
    for (int i = 0; i < controllers.count; i++) {
      Class vcClass =  NSClassFromString(controllers[i]);
        [self addChildController:[vcClass new] title:titles[i] imageName:normalImages[i] selectedImageName:seletedImages[i]];
    }
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:11],NSForegroundColorAttributeName:LayerGrayColor  }forState:UIControlStateNormal];
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Medium" size:11],NSForegroundColorAttributeName:THEMECOLOR}forState:UIControlStateSelected];

    [self dropShadowWithOffset:CGSizeMake(0, -0.5) radius:1 color:[UIColor grayColor] opacity:0.3];

}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName {
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : THEMECOLOR }forState:UIControlStateSelected];
    
    UINavigationController* nav = [[BasenavgationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}


// MARK: - 根据颜色生成图片
- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}

@end
