//
//  WBCommonHeader.h
//  WBKIT
//
//  Created by 张文博 on 16/7/21.
//  Copyright © 2016年 张文博. All rights reserved.
//

#ifndef WBCommonHeader_h
#define WBCommonHeader_h

#import "Masonry.h"
#import "UIColor+MHCommon.h"

// 判断数组不为空
#define kIsArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

// 判断字符串部位空
#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

// 判断对象不为空
#define kIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// 判断字典不为空
#define kIsDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

#define kImage(Name) ([UIImage imageNamed:Name])

#define KHexColor(color) [UIColor colorWithRGBHex:color alpha:1]

#define DEF_DEBUG(fmt, ...)   NSLog((@"%s[Line: %d]™ " fmt), strrchr(__FUNCTION__,'['), __LINE__, ##__VA_ARGS__)


typedef void(^WBConstraintMaker)(MASConstraintMaker *make);


#endif /* WBCommonHeader_h */
