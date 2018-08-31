//
//  LocalizableManager.h
//  breathPatientApp
//
//  Created by ifly on 2018/7/9.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, LanguagesType) {
        ChineseType, // 简体中文
        EnglishType, // 英文
        IndonesiaType, // 印尼语
};

//
// const NSString *StatusTypeStringMap[] = {
//    [ChineseType] = @"zh-Hans",
//    [EnglishType] = @"en",
//    [IndonesiaType] = @"id",
//};


@interface LocalizableManager : NSObject

+ (LocalizableManager *)shareLocalizableManager;

/**
 获取当前的国家代码

 @return 当前的国家代码
 */
- (NSString *)getCureentLanguage;


/**
 切换语言

 @param countryCode 国家代码
 */
- (void)changeLanguageWithCountryCode:(NSString *)countryCode;


/**
 国际化文本

 @param localizedKey 对应国际化的key
 @return 国际化字符串
 */
- (NSString *)getLocalizedTextWithKey:(NSString *)localizedKey;

@end
