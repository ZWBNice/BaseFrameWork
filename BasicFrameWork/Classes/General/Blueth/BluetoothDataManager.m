//
//  BluetoothDataManager.m
//  WBBluetoothManager
//
//  Created by ifly on 2018/7/30.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "BluetoothDataManager.h"

@implementation BluetoothDataManager


+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    return hexStr;
}


+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
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



// 16进制转10进制

+ (NSString *) numberHexString:(NSString *)aHexString

{
    
    // 为空,直接返回.
    
    if (nil == aHexString)
        
    {
        
        return nil;
        
    }
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    
    unsigned long long longlongValue;
    
    [scanner scanHexLongLong:&longlongValue];
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    NSString *hexString = [NSString stringWithFormat:@"%@",hexNumber];
    
    return hexString;
}


// 16进制转data
+ (NSData *)hexToBytes:(NSString *)str{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= str.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [str substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    return data;
}



+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
    
    return timeStr;
}


/**
 十进制转换十六进制
 
 @param decimalString 十进制字符串
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSString *)decimalString {
    NSInteger decimal = [decimalString integerValue];
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}


+ (NSString *)dataBytetoReverseOrder:(NSData *)data{
    Byte *testByte = (Byte*)[data bytes];
    NSInteger count = [data length];
    uint8_t *bytes = malloc(sizeof(*bytes) * count);
    //    Byte newByte[count] = {};
    NSInteger i;
    NSInteger j = count-1;
    for (i = 0; i<count; i++) {
        bytes[i] = testByte[j];
        j--;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:count];
    NSString *newHEXStr = [BluetoothDataManager convertDataToHexStr:newData];
    free(bytes);
    return newHEXStr;
}

+ (NSString *)hexStringToReverseOrderNewhexString:(NSString *)hexString{
    NSData *data = [BluetoothDataManager hexToBytes:hexString];
    NSString *newHexString = [BluetoothDataManager dataBytetoReverseOrder:data];
    return newHexString;
}

+ (NSArray *)subStringwithstring:(NSString *)string Withlength:(NSInteger)length{
    NSMutableArray *strings = [NSMutableArray array];
    NSMutableString *str = [[NSMutableString alloc] initWithString:string];
    NSInteger count = 0;
    if (str.length % length == 0) {
        count = str.length / length;
    }else{
        count = str.length / length + 1;
    }
    NSInteger j = 0;
    for (NSInteger i = 0; i<count; i++) {
        if (str.length >= j) {
            NSString * temp =  [str substringWithRange:NSMakeRange(j, length)];
            [strings addObject:temp];
        }else{
            [strings addObject:str];
        }
        j+=length;
    }
    return strings;
}

+ (NSString *)getDateStringWithtimeStamp:(NSTimeInterval)interval WithFormat:(NSString *)formaterString{
    NSDate *date     = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formaterString];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

@end
