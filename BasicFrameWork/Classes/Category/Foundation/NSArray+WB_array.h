//
//  NSArray+WB_array.h
//  WBKIT
//
//  Created by 张文博 on 16/7/26.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WB_array)

/**
 *  获取数组元素
 *
 *  @param index 第几个
 *
 *  @return value
 */
- (id)wb_objectAtIndex:(NSUInteger)index;

/**
 *  判断数组内是否包含某个字符串
 *
 *  @param str 字符串
 *
 *  @return yes or no
 */
- (BOOL)wb_isContainsString:(NSString *)str;

/**
 *  数组元素倒序排列
 *
 *  @return 倒序的新数组
 */
- (NSArray *)wb_reverseArray;

@end
