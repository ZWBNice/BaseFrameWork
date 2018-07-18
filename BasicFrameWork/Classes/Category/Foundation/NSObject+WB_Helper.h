//
//  NSObject+WB_Helper.h
//  WBKIT
//
//  Created by 张文博 on 16/7/26.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WB_Helper)

/**
 *  对象转成json字符串
 *
 *  @return json字符串
 */
- (NSString *)conversionToString;


/**
 *  对象转成json字符串
 *
 *  @param objc 要转的对象
 *
 *  @return json字符串
 */
+ (NSString *)conversionToStringWith:(id)objc;

/**
 *  对象转成NSData
 *
 *  @param objc 要转的对象
 *
 *  @return data
 */

+ (NSData *)conversionToDataWithObj:(NSObject *)obj;



@end
