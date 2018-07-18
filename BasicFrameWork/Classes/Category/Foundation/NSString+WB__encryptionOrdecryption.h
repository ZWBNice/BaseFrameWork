//
//  NSString+WB__encryptionOrdecryption.h
//  WBKIT
//
//  Created by 张文博 on 16/7/26.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WB__encryptionOrdecryption)

#pragma mark - 加密
/**
 *  MD5小写加密
 *
 *  @return 小写md5加密后的value
 */
- (NSString*)stringFromMD5Lowercase;

/**
 *  MD5大写加密
 *
 *  @return 大写MD5加密后的value
 */
- (NSString*)stringFromMD5Capital;

/**
 *  NSString转换成十六进制的字符串则
 *
 *  @param str 要转成16进制的字符串
 *
 *  @return 16进制的字符串
 */
+ (NSString *)convertStringToHexStr:(NSString *)str ;

/**
 *  字符串base64加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)encodeBase64String:(NSString *)str;

/**
 *  字符串解密
 *
 *  @param str 要解密的字符串
 *
 *  @return 解密后的字符串
 */
+ (NSString *)decodeBase64String:(NSString *)str;

/**
 *  二进制加密
 *
 *  @param data 加密的二进制
 *
 *  @return 加密后的字符串
 */
+ (NSString*)encodeBase64Data:(NSData *)data;

/**
 *  解密二进制
 *
 *  @param data 要解密的二进制
 *
 *  @return 解密的字符串
 */
+ (NSString*)decodeBase64Data:(NSData *)data;



#pragma mark -- 验证字符是否满足验证条件
/**
 *  判断是否是电子邮件
 *
 *  @return yes or no
 */
- (BOOL)wb_isEmail;

/**
 *  判断是否是email地址
 *
 *  @param email 要判断的email地址
 *
 *  @return yes or no
 */
+ (BOOL)wb_isEmailWith:(NSString *)email;

/**
 *  判断是否是电话号码
 *
 *  @return yes or no
 */
- (BOOL)wb_isTelNumber;

/**
 *  判断是否是电话号码
 *
 *  @param tel tel 号码
 *
 *  @return yes or no
 */
+ (BOOL)wb_isTelNumberWith:(NSString *)tel;

/**
 *  判断是否是身份证号
 *
 *  @param cardId 身份证号
 *
 *  @return yes or no
 */
+ (BOOL)wb_isPersonCardID:(NSString *)cardId;

/**
 *  判断是否是身份证号
 *
 *  @return yes or no
 */
- (BOOL)wb_isPersonCardId;

#pragma mark -- 字符串 转 objc

/**
 *  json字符串转成objc
 *
 *  @return objc
 */
- (id)wb_conversionToObjc;

/**
 *  json字符串转成objc
 *
 *  @param str 要转的json字符串
 *
 *  @return objc
 */
+ (id)wb_conversionToObjcWith:(NSString *)str;

#pragma mark - 修剪字符
/**
 *  去除字符串左边的空格
 *
 *  @return 新的字符串去除了左侧空格
 */
- (NSString *)wb_trimLeft;

/**
 *  去除字符串右边的空格
 *
 *  @return 新的字符串去除了右侧的空格
 */
- (NSString *)wb_trimRight;

/**
 *  去除字符串左右两边的空格
 *
 *  @return 新的字符串
 */
- (NSString *)wb_trimLeftAndRight;

/**
 *  去除所有的空格
 *
 *  @return 新的字符串去除所有的空格
 */
- (NSString *)wb_trimAllSpace;

/**
 *  去除特殊字符
 *
 *  @return 新的字符串去除所有特殊字符
 */

- (NSString *)wb_trimAllSpecilCharactes;

/**
 *  urlcode
 *
 *  @return 新的url
 */
- (NSString *)wb_urEncode;




- (NSString *)WB_chinesetoPinyin;

@end
