//
//  LocalizableManager.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/9.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "LocalizableManager.h"
#import "CustomTabBarController.h"
static NSString * languageKey = @"WBlanguagekey";


@interface LocalizableManager()
@property (nonatomic, copy) NSString *countryCode;
@end

@implementation LocalizableManager

+ (LocalizableManager *)shareLocalizableManager{
    static LocalizableManager *_once = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _once = [[self alloc] init];
    });
    return _once;
}

- (instancetype)init{
    if (self = [super init]) {
        self.countryCode =  [self getCureentLanguage];
    }
    return self;
}

- (NSString *)getCureentLanguage{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *currentLanguage = [userDefault objectForKey:languageKey];
    if(currentLanguage == nil){
        currentLanguage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    }
    return currentLanguage;
}

- (void)changeLanguageWithCountryCode:(NSString *)countryCode{
//    NSString *countryCode = @"";
//    switch (countryType) {
//            case ChineseType:
//            countryCode = @"zh-Hans";
//            break;
//            case EnglishType:
//            countryCode = @"en";
//            break;
//            case IndonesiaType:
//            countryCode = @"id";
//            break;
//        default:
//            break;
//    }
    [self saveCountryCode:countryCode];
    // 重新渲染页面
    CustomTabBarController *tabbar = [[CustomTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
}


/**
 存储国家代码
 
 @param code 国家代码
 */
- (void)saveCountryCode:(NSString *)code{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:code forKey:languageKey];
    [userDefault synchronize];
    self.countryCode = code;
}

- (NSString *)getLocalizedTextWithKey:(NSString *)localizedKey{
    NSString *path = [[NSBundle mainBundle] pathForResource:self.countryCode ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    NSString * localizedText = [bundle localizedStringForKey:localizedKey value:nil table:@"Localizable"];
    return localizedText;
}

@end
