//
//  BaseViewController.m
//  MyProject
//
//  Created by 张文博 on 16/1/7.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "BaseViewController.h"
//#import "WB_UIButton.h"
//#import "UIView+Shadow.h"
//#import "NJKWebViewProgressView.h"
//#import "UIImage+NTESColor.h"
#import "WBBaseEmptyView.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (UIBarButtonItem *)rightBarButton{
    return nil;
}

- (UIBarButtonItem *)leftBarButton{
    return nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {


    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    // iOS7顶部屏幕适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif

    // 默认背景色
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.rightBarButton != nil) {
        self.navigationItem.rightBarButtonItem = self.rightBarButton;
    }

    if (self.leftBarButton != nil) {
        self.navigationItem.leftBarButtonItem = self.leftBarButton;
    }
    
    [self  setupBackItem];

}

- (void)setupBackItem{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    //主要是以下两个图片设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"fanhui_icon"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"fanhui_icon"];
    self.navigationItem.backBarButtonItem = backItem;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 7, 25, 25);
//    // 图片向左偏移20像素
//    //        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    [leftBtn setImage:[UIImage imageNamed:@"03_03"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.backBarButtonItem = leftItem;

}

- (void)back{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [GSKAlertViewController dismissSVprogress];
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [SVProgressHUD dismiss];
}




- (WBBaseEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [WBBaseEmptyView noDataView];
    }
    return _emptyView;
}

- (WBBaseEmptyView *)noNetWorkView{
    if (!_noNetWorkView) {
        _noNetWorkView = [WBBaseEmptyView noDataViewWithTarget:self action:@selector(WBEmptyClick:)];
    }
    return _noNetWorkView;
}

- (void)WBEmptyClick:(UIButton *)btn{
    
}


- (void)isHiddenNavgation:(BOOL)isHidden animated:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:isHidden animated:animated];
}


@end
