//
//  DefineHeader.h
//  ProjectFramework
//
//  Created by zwb on 2018/1/15.
//  Copyright © 2018年 WB. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

/**
 *  主屏的宽
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  自定义log
 */
#ifdef DEBUG
#define DELog(fmt, ...) NSLog((@"<%s : %d> %s  " fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent]   UTF8String], __LINE__, __PRETTY_FUNCTION__,  ##__VA_ARGS__);
#else
#define DLog(...)
#endif


#endif /* DefineHeader_h */
