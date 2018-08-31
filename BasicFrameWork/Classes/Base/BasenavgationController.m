//
//  BasenavgationController.m
//  MyProject
//
//  Created by 张文博 on 16/1/7.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "BasenavgationController.h"

@interface BasenavgationController ()<UINavigationControllerDelegate>
@property (strong, nonatomic)UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic)UIImageView *backView;
@property (strong, nonatomic)NSMutableArray *backImgs;
@property (assign) CGPoint panBeginPoint;
@property (assign) CGPoint panEndPoint;

@property (nonatomic, assign) id<UIGestureRecognizerDelegate> popDelegate;
@end

@implementation BasenavgationController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    }
    return self;
}

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.navigationBar.bounds);
    self.navigationBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.navigationBar.layer.shadowColor = color.CGColor;
    self.navigationBar.layer.shadowOffset = offset;
    self.navigationBar.layer.shadowRadius = radius;
    self.navigationBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.navigationBar.clipsToBounds = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;

    

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 需要在调用super 之前才好使
    //viewController是将要被push的控制器
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = true;

    }
    [super pushViewController:viewController animated:animated];

//    if (self.childViewControllers.count > 1) {
//        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        leftBtn.frame = CGRectMake(0, 7, 25, 25);
//        // 图片向左偏移20像素
////        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//        [leftBtn setImage:[UIImage imageNamed:@"fanhui_icon"] forState:UIControlStateNormal];
//        [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//        viewController.navigationItem.backBarButtonItem = leftItem;
//    }
//
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //实现滑动返回功能
    //清空滑动返回手势的代理就能实现
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
    else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [_backImgs removeLastObject];

    return [super popViewControllerAnimated:animated];
}

#pragma mark- private method
- (void)panGestureRecognizerAction:(UIPanGestureRecognizer*)panGestureRecognizer{
    if ([self.viewControllers count] == 1) {
        return ;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"flag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    CGPoint translatedPoint = [panGestureRecognizer translationInView:[UIApplication sharedApplication].keyWindow];
    
    if (translatedPoint.x< 0) {
        
        return;
    }else {
        if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            NSLog(@"滑动开始");
            //存放滑动开始的位置
            self.panBeginPoint = [panGestureRecognizer locationInView:[UIApplication sharedApplication].keyWindow];
            //插入图片
            [self insertLastViewFromSuperView:self.view.superview];
            
        }else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded){
            NSLog(@"滑动结束");
            //存放数据
            self.panEndPoint = [panGestureRecognizer locationInView:[UIApplication sharedApplication].keyWindow];
            
            if ((_panEndPoint.x - _panBeginPoint.x) > 50) {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveNavigationViewWithLenght:[UIScreen mainScreen].bounds.size.width];
                } completion:^(BOOL finished) {
                    [self removeLastViewFromSuperView];
                    [self moveNavigationViewWithLenght:0];
                    [self popViewControllerAnimated:NO];
                }];
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveNavigationViewWithLenght:0];
                }];
            }
        }else{
            //添加移动效果
            CGFloat panLength = ([panGestureRecognizer locationInView:[UIApplication sharedApplication].keyWindow].x - _panBeginPoint.x);
            if (panLength > 0) {
                [self moveNavigationViewWithLenght:panLength];
            }
        }

    }
}

/**
 *  移动视图界面
 *
 *  @param lenght 移动的长度
 */
- (void)moveNavigationViewWithLenght:(CGFloat)lenght{
    
    //图片位置设置
    self.view.frame = CGRectMake(lenght, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    //图片动态阴影
    _backView.alpha = (lenght/[UIScreen mainScreen].bounds.size.width)*2/3 + 0.33;
//    _backView.frame  = CGRectMake(lenght - WIDTH, 0, WIDTH, HEIGHT);
    _backView.backgroundColor = [UIColor whiteColor];
}

/**
 *  插图上一级图片
 *
 *  @param superView 图片的superView
 */
- (void)insertLastViewFromSuperView:(UIView *)superView{
    //插入上一级视图背景
    if (_backView == nil) {
        _backView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backView.image = [_backImgs lastObject];
    }
    [self.view.superview insertSubview:_backView belowSubview:self.view];
}

/**
 *  移除上一级图片
 */
- (void)removeLastViewFromSuperView{
    [_backView removeFromSuperview];
    _backView = nil;
}

#pragma mark -- 解决侧滑手势的冲突
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        
//        NSLog(@"%c",[[self.topViewController.view gestureRecognizers] containsObject:gestureRecognizer]);
        
        if (self.topViewController ) {
            CGPoint tPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
            if (tPoint.x >= 0) {
                CGFloat y = fabs(tPoint.y);
                CGFloat x = fabs(tPoint.x);
                CGFloat af = 30.0f/180.0f * M_PI;
                
                CGFloat tf = tanf(af);
                if ((y/x) <= tf) {
                    return YES;
                }
            
                return NO;
            }else{
                return NO;
            }
        }
        
    }
    
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    UIViewController* topVC = self.topViewController;
    
    return [topVC preferredStatusBarStyle];
}

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, YES, 1.0);
//    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.backImgs addObject:img];
//
//    if (self.childViewControllers.count > 0) {
//        //这里是设置了一个返回按钮,效果图如下
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:@"" forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        button.frame = CGRectMake(0, 0, 70, 30);
//        //让按钮内部的所有内容左对齐
//        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        //让按钮的内容往左偏移10
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//        // 修改导航栏左边的item
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        // 隐藏tabbar
//        viewController.hidesBottomBarWhenPushed = YES;
//        // 如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
//       // __weak typeof(viewController)Weakself = viewController;
//        //self.interactivePopGestureRecognizer.delegate = (id)Weakself;
//    }
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        self.interactivePopGestureRecognizer.enabled = NO;
//    //这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
//    [super pushViewController:viewController animated:animated];
//}
-(void)back{
    [self popViewControllerAnimated:YES];
}



@end
