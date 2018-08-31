//
//  CountdownTool.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/11.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "CountdownTool.h"

@implementation CountdownTool

- (void)countdownWithtime:(NSInteger)time comBegin:(Countdowning)countdown compelte:(Complemnet)complete{
    self.timer = time;
    self.complete = complete;
    self.countdown = countdown;
    self.cycyleTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.cycyleTimer forMode:NSRunLoopCommonModes];
}

- (void)next{
    self.timer -= 1;
    if (self.timer <= 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.complete();
            [self removeTimer];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.countdown(self.timer);
        });
    }
}

- (void)removeTimer{
    [self.cycyleTimer invalidate];
    self.cycyleTimer = nil;
}

- (void)startTimer{
    self.timer = 0;
    self.cycyleTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.cycyleTimer forMode:NSRunLoopCommonModes];
}

- (NSInteger)stopTimer{
    [self removeTimer];
    return self.timer;
}

- (void)timing{
    self.timer += 1;
}


@end
