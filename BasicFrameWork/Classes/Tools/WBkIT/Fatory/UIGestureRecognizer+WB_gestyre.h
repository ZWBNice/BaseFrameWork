//
//  UIGestureRecognizer+WB_gestyre.h
//  WBKIT
//
//  Created by 张文博 on 16/7/22.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(id sender);

typedef void(^LongPressBlock)(id sender);


@interface UIGestureRecognizer (WB_gestyre)


@property (nonatomic, strong) TapBlock tapBlock;

@property (nonatomic, strong) LongPressBlock longPressBlock;


@end
