//
//  BluetoothDataManager.h
//  WBBluetoothManager
//
//  Created by ifly on 2018/7/30.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BluetoothDataManager : NSObject


// MARK: - 字符串转16进制
+ (NSString *)hexStringFromString:(NSString *)string;

/**
 data转十六进制字符串
 @param data data
 @return 十六进制字符串
 */
+ (NSString *)convertDataToHexStr:(NSData *)data;

/**
 十六进制转data

 @param str 十六进制字符串
 @return data
 */
+ (NSData *)hexToBytes:(NSString *)str;

/**
 十六进制转10进制

 @param aHexString 16进制字符串
 @return 十进制字符串
 */
+ (NSString *) numberHexString:(NSString *)aHexString;

/**
 十进制转换十六进制
 
 @param decimalString 十进制字符串
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSString *)decimalString;



+ (NSString *)dataBytetoReverseOrder:(NSData *)data;

/**
 将16进制的字符串倒序排列 例如 "3B6AAB5A" = "5aab6a3b"

 @param hexString 原来的16进制字符串
 @return 排序后的16进制字符串
 */
+ (NSString *)hexStringToReverseOrderNewhexString:(NSString *)hexString;

+ (NSString *)getTimeStrWithString:(NSString *)str;

+ (NSArray *)subStringwithstring:(NSString *)string Withlength:(NSInteger)length;

+ (NSString *)getDateStringWithtimeStamp:(NSTimeInterval)interval WithFormat:(NSString *)formaterString;
@end
