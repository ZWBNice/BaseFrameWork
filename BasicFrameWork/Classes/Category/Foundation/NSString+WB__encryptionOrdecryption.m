//
//  NSString+WB__encryptionOrdecryption.m
//  WBKIT
//
//  Created by 张文博 on 16/7/26.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "NSString+WB__encryptionOrdecryption.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

@implementation NSString (WB__encryptionOrdecryption)

#pragma mark -- 加密
// 小写
- (NSString*)stringFromMD5Lowercase
{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (int)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

// 大写
- (NSString*)stringFromMD5Capital
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


//将NSString转换成十六进制的字符串则可使用如下方式:
+ (NSString *)convertStringToHexStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (NSString *)encodeBase64String:(NSString *)str{
 return  [GTMBase64 encodeBase64String:str];
}

+ (NSString *)decodeBase64String:(NSString *)str{
    return [GTMBase64 decodeBase64String:str];
}

+ (NSString *)encodeBase64Data:(NSData *)data{
    return [GTMBase64 encodeBase64Data:data];
}

+ (NSString *)decodeBase64Data:(NSData *)data{
    
    return [GTMBase64 decodeBase64Data:data];
}

#pragma mark -- 验证
- (BOOL)wb_isEmail {
    
    return [NSString wb_isEmailWith:self];
}

+ (BOOL)wb_isEmailWith:(NSString *)email{
    NSString *reg =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    return [predicate evaluateWithObject:[email lowercaseString]];

}

- (BOOL)wb_isTelNumber{
    
    return [NSString wb_isTelNumberWith:self];
}

+ (BOOL)wb_isTelNumberWith:(NSString *)tel{
    
    NSString *pattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([mobilePredicate evaluateWithObject:tel]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)wb_isPersonCardId{
    
    return [NSString wb_isPersonCardID:self];
}

+ (BOOL)wb_isPersonCardID:(NSString *)cardId{
    // 判断位数
    if (cardId.length != 15 && cardId.length != 18) {
        return NO;
    }
    NSString *carid = cardId;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:cardId];
    if (cardId.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self _areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self _substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self _substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self _substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                  strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

#pragma mark -- 字符串 转 objc

- (id)wb_conversionToObjc{
    
    return [NSString wb_conversionToObjcWith:self];
}

+ (id)wb_conversionToObjcWith:(NSString *)str {
    NSData *data = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error;
    id objc = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    return objc;
}

#pragma mark -- 修剪字符串

- (NSString *)wb_trimLeft{
    NSInteger len = 0;
    while (len < self.length) {
        if ([self characterAtIndex:len] != ' ') {
            break;
        }
        len++;
    }
    
    if (len >= self.length) {
        len = self.length - 1;
    }
    
    if (len <= 0) {
        return self;
    }
    
    return [self substringFromIndex:len];

}

- (NSString *)wb_trimRight{
    NSInteger index = self.length - 1;
    for (NSInteger i = self.length - 1; i >= 0; --i) {
        if ([self characterAtIndex:i] != ' ') {
            break;
        } else {
            index--;
        }
    }
    
    if (index + 1 < self.length) {
        index++;
    }
    
    if (index + 1 >= self.length) {
        return self;
    }
    
    return [self substringToIndex:index];

}

- (NSString *)wb_trimLeftAndRight{
    NSString *str = [self wb_trimRight];
    
    return [str wb_trimLeft];
}

- (NSString *)wb_trimAllSpace{
    
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (NSString *)wb_trimAllSpecilCharactes{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@":"];
    
    return  [self stringByTrimmingCharactersInSet:set];
}


- (NSString *)wb_urEncode{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark - Private
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
+ (BOOL)_areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

+ (NSString *)_substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}




- (NSString *)WB_chinesetoPinyin{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    // 去除音调
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        
    }
    // 转成拼音
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripCombiningMarks, NO)) {
    }
    NSString *str = [NSString stringWithFormat:@"%@",ms];
    return str;
}


@end
