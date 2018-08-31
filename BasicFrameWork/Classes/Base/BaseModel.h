//
//  BaseModel.h
//
//  Created by 钩钩硬 on 15/10/19.
//  Copyright © 2015年 Mr.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject


// 把数组套字典的传给方法,返回一个数组套model
+ (NSMutableArray *)baseModelByArr:(NSArray *)arr;

+ (instancetype)baseModelWithDic:(NSDictionary *)dic;


- (instancetype)initWithDic:(NSDictionary *)dic ;

@end
