//
//  CountdownTool.h
//  breathPatientApp
//
//  Created by ifly on 2018/7/11.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Complemnet)(void);
typedef void(^Countdowning)(NSInteger timer);


@interface CountdownTool : NSObject
/**
 计时器
 */
@property (nonatomic, strong) NSTimer *cycyleTimer;

/**
 计数
 */
@property(nonatomic, assign) NSInteger timer;

/**
 结束回调
 */
@property (nonatomic, copy) Complemnet complete;

/**
 计时中回调
 */
@property (nonatomic, copy) Countdowning countdown;


- (void)countdownWithtime:(NSInteger)time comBegin:(Countdowning)countdown compelte:(Complemnet)complete;


/**
 停止计时器

 @return 返回计时多久
 */
- (NSInteger)stopTimer;


/**
 开始计时
 */
- (void)startTimer;

@end
